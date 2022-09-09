import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayat/services/google_maps_service/address_response/address_response.dart';

class GoogleMapsService {
  static void openMaps(double lat, double lng) async {
    var uri;
    if (Platform.isAndroid) {
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
    String mapsKey = dotenv.get('GOOGLE_MAPS_KEY');

    Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${coords.latitude},${coords.longitude}&key=$mapsKey");
    try {
      Response response = await get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      AddressResponse addressResponse = AddressResponse.fromJson(json);
      return addressResponse.firstValidAddress();
    } on HandshakeException {
      log("Exception: Bad handshake to googleapis.com");
      return "ERROR_ADDRESS";
    }
  }
}
