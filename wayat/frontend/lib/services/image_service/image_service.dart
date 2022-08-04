import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class ImageService {
  Future<BitmapDescriptor> _getBitmapFromUrl(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    Uint8List bytes = response.bodyBytes;
    Uint8List resizedImage = await _resizeImage(bytes);
    return BitmapDescriptor.fromBytes(resizedImage);
  }

  Future<Uint8List> _resizeImage(Uint8List bytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: 150);
    ui.FrameInfo fi = await codec.getNextFrame();
    Uint8List resizedImage =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return resizedImage;
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
