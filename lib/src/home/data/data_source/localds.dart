import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeLocalDatasource {
  Future<XFile> getProfileImageCamera();
  Future<XFile> getProfileImageGallery();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  @override
  Future<XFile> getProfileImageCamera() async {
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result != null) {
      XFile file = XFile(result.path);
      return file;
    } else {
      throw Exception("Error getting image");
    }
  }

  @override
  Future<XFile> getProfileImageGallery() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      XFile file = XFile(result.path);
      return file;
    } else {
      throw Exception("Error getting image");
    }
  }

 
}
