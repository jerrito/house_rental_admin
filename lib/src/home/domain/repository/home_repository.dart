import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeRepository {
  Future<Either<String, XFile>> getProfileImageGallery();
  Future<Either<String, XFile>> getProfileImageCamera();
  Future<Either<String, List<XFile>>> addMultipleImage();
  Future<Either<String, DocumentReference<HouseDetailModel>?>> addHouse(Map<String,dynamic> params);
}
