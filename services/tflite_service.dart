import 'dart:io';
import 'dart:typed_data';
import 'package:tflite/tflite.dart';
import '../model/recognition.dart';

class TfliteService {
  static Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite",
      labels: "assets/labels.txt",
    );
  }

  static Future<List<Recognition>> recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
    );
    return recognitions!.map((rec) {
      return Recognition(
        label: rec["label"],
        confidence: rec["confidence"],
      );
    }).toList();
  }

  static Future<List<Recognition>> recognizeImageBytes(Uint8List imageBytes) async {
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageBytes.buffer.asUint8List(),
      numResults: 5,
    );
    return recognitions!.map((rec) {
      return Recognition(
        label: rec["label"],
        confidence: rec["confidence"],
      );
    }).toList();
  }

  static Future<void> dispose() async {
    await Tflite.close();
  }
}
