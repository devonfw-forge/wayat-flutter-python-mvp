import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/services/google_maps_service/address_response/address.dart';
import 'package:wayat/services/google_maps_service/address_response/address_component.dart';
import 'package:wayat/services/google_maps_service/address_response/address_response.dart';
import 'package:wayat/services/google_maps_service/google_maps_service.dart';
import 'package:wayat/services/google_maps_service/url_launcher_libw.dart';
import 'package:http/http.dart' as http;

import 'google_maps_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UrlLauncherLibW>(),
  MockSpec<http.Client>(),
  MockSpec<http.Response>()
])
void main() async {
  setUpAll(() async {
    await dotenv.load();
  });

  test("OpenMaps launches GoogleMaps in Android", () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    double lat = 1, lng = 1;
    Uri url = Uri.parse("google.navigation:q=$lat,$lng&mode=d");

    UrlLauncherLibW mockUrlLauncher = MockUrlLauncherLibW();
    when(mockUrlLauncher.canLaunchUrl(url)).thenAnswer((_) async => true);
    when(mockUrlLauncher.launchUrl(url)).thenAnswer((_) async => true);

    await GoogleMapsService.openMaps(lat, lng, urlLauncher: mockUrlLauncher);

    verify(mockUrlLauncher.canLaunchUrl(url)).called(1);
    verify(mockUrlLauncher.launchUrl(url)).called(1);
  });

  test("OpenMaps launches GoogleMaps in iOS", () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    double lat = 1, lng = 1;
    Uri url = Uri.parse("http://maps.apple.com/?daddr=$lat,$lng");

    UrlLauncherLibW mockUrlLauncher = MockUrlLauncherLibW();
    when(mockUrlLauncher.canLaunchUrl(url)).thenAnswer((_) async => true);
    when(mockUrlLauncher.launchUrl(url)).thenAnswer((_) async => true);

    await GoogleMapsService.openMaps(lat, lng, urlLauncher: mockUrlLauncher);

    verify(mockUrlLauncher.canLaunchUrl(url)).called(1);
    verify(mockUrlLauncher.launchUrl(url)).called(1);
  });

  test("Throws exception if it can't launch url", () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    double lat = 1, lng = 1;
    Uri url = Uri.parse("http://maps.apple.com/?daddr=$lat,$lng");

    UrlLauncherLibW mockUrlLauncher = MockUrlLauncherLibW();
    when(mockUrlLauncher.canLaunchUrl(url)).thenAnswer((_) async => false);

    try {
      await GoogleMapsService.openMaps(lat, lng, urlLauncher: mockUrlLauncher);
    } catch (e) {
      verify(mockUrlLauncher.canLaunchUrl(url)).called(1);
      verifyNever(mockUrlLauncher.launchUrl(url));
      expect('Could not launch http://maps.apple.com/?daddr=$lat,$lng', e);
      return;
    }

    fail("No exception thrown");
  });

  test(
      "getAddressFromCoordinates returns address when the communication goes well",
      () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    AddressResponse addressResponse = AddressResponse([
      Address([
        AddressComponent("number", "number", ["number"]),
        AddressComponent("street", "street", ["street"]),
        AddressComponent("city", "city", ["city"])
      ], "street, number, city")
    ]);

    http.Client mockHttpClient = MockClient();
    LatLng coords = const LatLng(1, 1);
    String mapsKey = dotenv.get("ANDROID_API_KEY");
    Uri url = Uri.https("maps.googleapis.com", "/maps/api/geocode/json",
        {"latlng": "${coords.latitude},${coords.longitude}", "key": mapsKey});

    http.Response mockResponse = MockResponse();
    when(mockResponse.body).thenReturn(jsonEncode(addressResponse.toJson()));

    when(mockHttpClient.get(url)).thenAnswer((_) async => mockResponse);

    String res = await GoogleMapsService.getAddressFromCoordinates(coords,
        httpClient: mockHttpClient);

    verify(mockHttpClient.get(url)).called(1);
    expect(res, addressResponse.results.first.formattedAddress);
  });

  test(
      "getAddressFromCoordinates returns error code if there is a Socket Exception",
      () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    http.Client mockHttpClient = MockClient();
    LatLng coords = const LatLng(1, 1);
    String mapsKey = dotenv.get("ANDROID_API_KEY");
    Uri url = Uri.https("maps.googleapis.com", "/maps/api/geocode/json",
        {"latlng": "${coords.latitude},${coords.longitude}", "key": mapsKey});

    when(mockHttpClient.get(url)).thenAnswer(
        (_) async => throw const SocketException("Socket exception"));

    String res = await GoogleMapsService.getAddressFromCoordinates(coords,
        httpClient: mockHttpClient);

    verify(mockHttpClient.get(url)).called(1);
    expect(res, "ERROR_ADDRESS");
  });

  test(
      "getAddressFromCoordinates returns error code if there is a Handshake Exception",
      () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    http.Client mockHttpClient = MockClient();
    LatLng coords = const LatLng(1, 1);
    String mapsKey = dotenv.get("ANDROID_API_KEY");
    Uri url = Uri.https("maps.googleapis.com", "/maps/api/geocode/json",
        {"latlng": "${coords.latitude},${coords.longitude}", "key": mapsKey});

    when(mockHttpClient.get(url)).thenAnswer(
        (_) async => throw const HandshakeException("Handshake exception"));

    String res = await GoogleMapsService.getAddressFromCoordinates(coords,
        httpClient: mockHttpClient);

    verify(mockHttpClient.get(url)).called(1);
    expect(res, "ERROR_ADDRESS");
  });

  test("GetAPIKey returns a well signed url", () async {
    String androidKey = dotenv.get('ANDROID_API_KEY');
    String iosKey = dotenv.get('IOS_API_KEY');
    String webKey = dotenv.get('WEB_API_KEY');

    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(GoogleMapsService.getApIKey(), androidKey);

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(GoogleMapsService.getApIKey(), iosKey);

    // There is no TargetPlatform web, so every platform that is not
    // iOS or Android will use the web key
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    expect(GoogleMapsService.getApIKey(), webKey);
  });
}
