import 'dart:io' show Platform;
import 'image_picker_handler.dart';
import 'image_picker_handler_mobile.dart';
import 'image_picker_handler_web.dart';

ImagePickerHandler getImagePickerHandler() {
  if (Platform.isIOS || Platform.isAndroid) {
    return ImagePickerHandlerMobile();
  } else {
    return ImagePickerHandlerWeb();
  }
}
