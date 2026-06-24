import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UtilsScreen extends StatefulWidget {
  const UtilsScreen({super.key});

  @override
  State<UtilsScreen> createState() => _UtilsScreenState();
}

class _UtilsScreenState extends State<UtilsScreen> {
  final ImagePicker _picker = ImagePicker();
  File? imageCamera;
  File? imageGallery;
  String? fileName;
  // picked image from gallery

  // agginment

  // file picker

  Future<void> pickFile() async {
    FilePickerResult? filePickerResult = await FilePicker.pickFiles(
      allowMultiple: true,
      allowedExtensions: ['pdf'],
    );
    if (filePickerResult != null) {
      setState(() {
        fileName = filePickerResult.files.single.name;
      });
    }
  }

  Future<void> pickImageFromCam() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      setState(() {
        imageCamera = File(pickedImage.path);
      });
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        imageGallery = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Util Screen')),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 20,
            children: [
              ElevatedButton(
                onPressed: pickImageFromCam,

                //  ()
                // {

                //   // if (imageCamera != null) {
                //   //   Image.file(imageCamera!);
                //   // }
                // },
                child: Text('pick image'),
              ),
              imageCamera != null
                  ? Image.file(imageCamera!, height: 300, width: 200)
                  : Text('error'),

              ElevatedButton(
                onPressed: pickImageFromGallery,
                child: Text('image picked from camra'),
              ),
              imageGallery != null
                  ? Image.file(imageGallery!, height: 200)
                  : Text('Error picked'),

              // pick file
              ElevatedButton(
                onPressed: pickImageFromGallery,
                child: Text('pic file'),
              ),

              Text(fileName ?? 'n/a'),
            ],
          ),
        ),
      ),
    );
  }
}
