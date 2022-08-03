import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ImageService {
  Future<BitmapDescriptor> _getBitmapFromUrl(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return BitmapDescriptor.fromBytes(response.bodyBytes);
  }

  Future<Map<String, BitmapDescriptor>> getBitmapsFromUrl(
      List<String> urls) async {
    Map<String, BitmapDescriptor> res = {};
    for (String url in urls) {
      BitmapDescriptor descriptor = await _getBitmapFromUrl(url);
      res[url] = descriptor;
    }

    debugPrint(res.toString());

    return res;
  }
}
