import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeRepository {
  Future<Either<String, XFile>> getProfileImageGallery();
  Future<Either<String, XFile>> getProfileImageCamera();
}
