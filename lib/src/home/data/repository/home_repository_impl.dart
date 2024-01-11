import 'package:dartz/dartz.dart';
import 'package:house_rental_admin/core/network_info.dart/network_info.dart';
import 'package:house_rental_admin/src/home/data/data_source/localds.dart';
import 'package:house_rental_admin/src/home/domain/repository/home_repository.dart';
import 'package:image_picker/image_picker.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDatasource homeLocalDatasource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.homeLocalDatasource,
  });
  @override
  Future<Either<String, XFile>> getProfileImageGallery() async {
    try {
      final response = await homeLocalDatasource.getProfileImageGallery();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, XFile>> getProfileImageCamera() async {
    try {
      final response = await homeLocalDatasource.getProfileImageCamera();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<XFile>>> addMultipleImage() async {
    try {
      final response = await homeLocalDatasource.addMultipleImage();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
