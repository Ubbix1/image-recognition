import 'package:flutter/material.dart';
import 'package:flutter_demo_1/services/image_picker_handler.dart';
import 'dart:io';
import 'dart:typed_data';
import '../model/recognition.dart';
import '../services/image_picker_handler_factory.dart';
import '../services/tflite_service.dart';
import '../widgets/image_display.dart';
import '../widgets/recognition_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  dynamic _image; // Can be File or Uint8List
  List<Recognition> _recognitions = [];
  bool _loading = false;
  late ImagePickerHandler _imagePickerHandler;

  @override
  void initState() {
    super.initState();
    _imagePickerHandler = getImagePickerHandler();
    TfliteService.loadModel();
  }

  Future<void> selectImage() async {
    var image = await _imagePickerHandler.pickImage();
    if (image == null) return;

    setState(() {
      _image = image;
      _loading = true;
    });
    await recognizeImage(_image);
  }

  Future<void> recognizeImage(dynamic image) async {
    List<Recognition> recognitions = [];
    if (image is File) {
      recognitions = await TfliteService.recognizeImage(image);
    } else if (image is Uint8List) {
      recognitions = await TfliteService.recognizeImageBytes(image);
    }

    setState(() {
      _recognitions = recognitions;
      _loading = false;
    });
  }

  @override
  void dispose() {
    TfliteService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Recognition'),
      ),
      body: Column(
        children: [
          ImageDisplay(image: _image),
          _loading
              ? const CircularProgressIndicator()
              : RecognitionList(recognitions: _recognitions),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: selectImage,
            child: const Text('Select Image'),
          ),
        ],
      ),
    );
  }
}
