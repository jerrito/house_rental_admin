import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeLocalDatasource {
  Future<XFile> getProfileImageCamera();
  Future<List<XFile>> addMultipleImage();
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

  @override
  Future<List<XFile>> addMultipleImage() async {
    final response = await ImagePicker().pickMultiImage();

     List<XFile> file =[];
    if (response.isNotEmpty) {
    file.addAll(response.map((e) => e)) ;
      return file;
    }
    else{
      throw Exception("Error getting images");
    }
  }

 
}
