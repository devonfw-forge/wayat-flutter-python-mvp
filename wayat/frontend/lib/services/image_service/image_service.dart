import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    ui.Codec codec = await ui.instantiateImageCodec(bytes,
        targetWidth: 100, targetHeight: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image image = fi.image;

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    Path path = Path()
      ..addOval(Rect.fromCenter(
          center: const Offset(50, 50), width: 100, height: 100));

    canvas.clipPath(path);

    canvas.drawImage(
        image, const Offset(0, 0), Paint()..style = PaintingStyle.fill);

    final img = await recorder.endRecording().toImage(100, 100);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  Future<Map<String, BitmapDescriptor>> getBitmapsFromUrl(
      List<String> urls) async {
    Map<String, BitmapDescriptor> res = {};
    for (String url in urls) {
      BitmapDescriptor descriptor = await _getBitmapFromUrl(url);
      res[url] = descriptor;
    }

    return res;
  }
}
