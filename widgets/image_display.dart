import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class ImageDisplay extends StatelessWidget {
  final dynamic image; // Can be File or Uint8List

  const ImageDisplay({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const Text('No image selected.');
    } else if (image is File) {
      return Image.file(image);
    } else if (image is Uint8List) {
      return Image.memory(image);
    } else {
      return const Text('Unsupported image type.');
    }
  }
}
