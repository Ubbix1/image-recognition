import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'image_picker_handler.dart';

class ImagePickerHandlerMobile implements ImagePickerHandler {
  @override
  Future<File?> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }
}
