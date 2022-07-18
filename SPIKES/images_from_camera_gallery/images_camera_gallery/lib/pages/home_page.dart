import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => showCameraOrGalleryPicker(context),
                child: const Text("Pick image"))
          ],
        ),
      ),
    );
  }

  void _getFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
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
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_rounded)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.image_rounded))
                ],
              ),
            ),
          );
        }));
  }
}
