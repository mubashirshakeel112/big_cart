import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CustomImagePicker{
  static pickSingleImage(ImageSource imageSource) async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: imageSource);
    if(photo != null){
      return File(photo.path);
    }
  }
}