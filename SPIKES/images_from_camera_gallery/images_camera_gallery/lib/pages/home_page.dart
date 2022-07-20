import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? currentSelectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (currentSelectedImage != null)
                ? Image.file(File(currentSelectedImage!.path))
                : Container(),
            ElevatedButton(
                onPressed: () => showCameraOrGalleryPicker(context),
                child: const Text("Pick image"))
          ],
        ),
      ),
    );
  }

  void _getFromGallery(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setState(() {
      currentSelectedImage = newImage;
    });
    Navigator.pop(context);
  }

  void showCameraOrGalleryPicker(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: ((BuildContext context) {
          return Container(
            alignment: AlignmentDirectional.center,
            height: 150,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => _getFromGallery(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt_rounded)),
                  IconButton(
                      onPressed: () => _getFromGallery(ImageSource.gallery),
                      icon: const Icon(Icons.image_rounded))
                ],
              ),
            ),
          );
        }));
  }
}
