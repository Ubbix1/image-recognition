import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'image_picker_handler.dart';

class ImagePickerHandlerWeb implements ImagePickerHandler {
  @override
  Future<Uint8List?> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image != null ? await image.readAsBytes() : null;
  }
}
