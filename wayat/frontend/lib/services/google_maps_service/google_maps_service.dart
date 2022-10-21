import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/services/google_maps_service/address_response/address_response.dart';
import 'package:wayat/services/google_maps_service/url_launcher_libw.dart';

class GoogleMapsService {
  static Future openMaps(double lat, double lng,
      {UrlLauncherLibW? urlLauncher, PlatformService? platformService}) async {
    UrlLauncherLibW launcher = urlLauncher ?? UrlLauncherLibW();
    platformService ??= PlatformService();
    late Uri uri;
    // To test the web condition, the access to this variable should be
    // wrapped in its own class to allow for mocking
    if (!platformService.isWeb &&
        platformService.targetPlatform == TargetPlatform.android) {
      uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    } else if (!platformService.isWeb &&
        platformService.targetPlatform == TargetPlatform.iOS) {
      //apple maps
      uri = Uri.parse("http://maps.apple.com/?daddr=$lat,$lng");
    } else {
      // google maps
      uri = Uri.parse(
          "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=walking");
    }
    if (await launcher.canLaunchUrl(uri)) {
      await launcher.launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  static Future<String> getAddressFromCoordinates(LatLng coords,
      {Client? httpClient}) async {
    Client client = httpClient ?? Client();
    String mapsKey = getApIKey();

    Uri url = Uri.https("maps.googleapis.com", "/maps/api/geocode/json",
        {"latlng": "${coords.latitude},${coords.longitude}", "key": mapsKey});
    try {
      Response response = await client.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      AddressResponse addressResponse = AddressResponse.fromJson(json);
      return addressResponse.firstValidAddress();
    } on SocketException {
      log("Exception: Failed host lookup to googleapis.com");
      return "ERROR_ADDRESS";
    } on HandshakeException {
      log("Exception: Bad handshake to googleapis.com");
      return "ERROR_ADDRESS";
    }
  }

  static String getStaticMapImageFromCoords(LatLng coords) {
    String apiKey = getApIKey();
    String secret = EnvModel.MAPS_STATIC_SECRET;
    secret = base64.normalize(secret);

    Uri url = Uri.https("maps.googleapis.com", "maps/api/staticmap", {
      "center": "${coords.latitude},${coords.longitude}",
      "size": "620x620",
      "zoom": "16",
      "key": apiKey,
    });

    String pathAndQuery = "${url.path}?${url.query}";
    Digest signature =
        Hmac(sha1, base64.decode(secret)).convert(utf8.encode(pathAndQuery));

    String signatureInBase64 = base64Url.encode(signature.bytes);

    Uri signedUrl = Uri.https("maps.googleapis.com", "maps/api/staticmap", {
      "center": "${coords.latitude},${coords.longitude}",
      "size": "620x620",
      "zoom": "16",
      "key": apiKey,
    });

    return "$signedUrl&signature=$signatureInBase64";
  }

  static String getApIKey([PlatformService? platformService]) {
    platformService ??= PlatformService();
    if (platformService.targetPlatform == TargetPlatform.android) {
      return EnvModel.ANDROID_API_KEY;
    }
    if (platformService.targetPlatform == TargetPlatform.iOS) {
      return EnvModel.IOS_API_KEY;
    }
    return EnvModel.WEB_API_KEY;
  }
}
