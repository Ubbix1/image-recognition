import 'package:flutter/material.dart';
import 'package:flutter_demo_1/model/recognition.dart';


class RecognitionList extends StatelessWidget {
  final List<Recognition> recognitions;

  const RecognitionList({super.key, required this.recognitions});

  @override
  Widget build(BuildContext context) {
    return recognitions.isEmpty
        ? const Text('No recognitions.')
        : Column(
            children: recognitions.map((rec) {
              return Text(
                "${rec.label} - ${rec.confidence.toStringAsFixed(2)}",
              );
            }).toList(),
          );
  }
}
