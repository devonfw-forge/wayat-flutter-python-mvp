import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayat/services/google_maps_service/address_response/address_response.dart';

class GoogleMapsService {
  static void openMaps(double lat, double lng) async {
    var uri;
    if (kIsWeb || Platform.isAndroid) {
      uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    } else if (Platform.isIOS) {
      //apple maps
      uri = Uri.parse("http://maps.apple.com/?daddr=$lat,$lng");
      //google maps
      //uri = Uri.parse("https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&mode=driving");
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  static Future<String> getAddressFromCoordinates(LatLng coords) async {
    String mapsKey = getApIKey();

    Uri url = Uri.https("maps.googleapis.com", "/maps/api/geocode/json",
        {"latlng": "${coords.latitude},${coords.longitude}", "key": mapsKey});
    try {
      Response response = await get(url);
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
    String secret = dotenv.get("MAPS_STATIC_SECRET").replaceAll("\"", "");
    secret = base64.normalize(secret);

    Uri url = Uri.https("maps.googleapis.com", "maps/api/staticmap", {
      "center": "${coords.latitude},${coords.longitude}",
      "key": apiKey,
      "size": "400x400",
      "zoom": "16",
    });

    String pathAndQuery = "${url.path}?${url.query}";
    print("DEBUG ${url.path}?${url.query}");
    Digest signature =
        Hmac(sha1, base64.decode(secret)).convert(utf8.encode(pathAndQuery));
    print("DEBUG signature ${signature.bytes}");

    String signatureInBase64 = base64.encode(signature.bytes);
    String signatureInBase64Normalized = base64.normalize(signatureInBase64);

    Uri signedUrl = Uri.https("maps.googleapis.com", "maps/api/staticmap", {
      "center": "${coords.latitude},${coords.longitude}",
      "key": apiKey,
      "size": "400x400",
      "zoom": "16",
      "signature": signatureInBase64Normalized
    });

    return signedUrl.toString();
  }

  static String getApIKey() {
    if (kIsWeb) {
      return dotenv.get('WEB_API_KEY');
    } else if (Platform.isAndroid) {
      return dotenv.get('ANDROID_API_KEY');
    } else if (Platform.isIOS) {
      return dotenv.get('IOS_API_KEY');
    } else {
      return "";
    }
  }
}
