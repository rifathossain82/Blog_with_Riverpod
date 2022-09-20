import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageServices{

  Future galleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      return image ;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future cameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      return image;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String getImagePath(image){
    return File(image.path).path;
  }

  Future getImageFile(image)async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    final fileImage = File('${directory.path}/$name');

    return File(image.path).copy(fileImage.path);
  }

}