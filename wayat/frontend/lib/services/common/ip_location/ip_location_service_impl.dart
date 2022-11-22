import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wayat/services/common/ip_location/ip_location_service.dart';
import 'package:http/http.dart' as http;
import 'package:wayat/services/common/ip_location/models/ip_data.dart';

/// Implementation of the [IPLocationService] interface
class IPLocationServiceImpl implements IPLocationService {
  /// Client that will make all requests
  final http.Client client;

  /// Default location data (Paris)
  final defaultLocationData = LocationData.fromMap(
    {
      "latitude": 48.85341,
      "longitude": 2.3488
    }
  );

  /// Creates an [IPLocationService].
  ///
  /// The optional [http.CLient] argument is added for testing purposes.
  IPLocationServiceImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<LocationData> getLocationData() async {
    try {
      http.Response resultJson =
          await client.get(Uri.parse("http://ip-api.com/json"), headers: getHeaders());
      if (resultJson.statusCode != 200) return defaultLocationData;
      Map<String, dynamic> resultData = json.decode(const Utf8Decoder().convert(resultJson.bodyBytes))
          as Map<String, dynamic>;
      IPData ipData = IPData.fromJson(resultData);
      return LocationData.fromMap(
        {
          "latitude": ipData.lat,
          "longitude": ipData.lon
        }
      );
    } on Exception {
      log("[ERROR] Unable to get network location data");
      return defaultLocationData;
    }
  }

  /// Returns the necessary content and authentication headers for all server requests.
  @visibleForTesting
  Map<String, String> getHeaders() {
    return {
      "Content-Type": ContentType.json.toString()
    };
  }
}
