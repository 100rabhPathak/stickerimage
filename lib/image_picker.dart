import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  XFile? image; //this is the state variable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final img =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = img;
                      });
                    },
                    label: const Text('Choose Image'),
                    icon: const Icon(Icons.image),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final img =
                          await picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        image = img;
                      });
                    },
                    label: const Text('Take Photo'),
                    icon: const Icon(Icons.camera_alt_outlined),
                  ),
                ],
              ),
              if (image != null)
                Expanded(
                  child: Column(
                    children: [
                     
                      Expanded(child: Image.file(File(image!.path))),

                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            image = null; 
                          });
                        },
                        label: const Text('Remove Image'),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
