import 'package:dartz/dartz.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/src/authentication/domain/repositories/authentication_repository.dart';

class UploadMultipleImages extends UseCases<List<String>, Map<String,dynamic>> {
  final AuthenticationRepository repository;

  UploadMultipleImages({required this.repository});

  @override
  Future<Either<String, List<String>>> call(Map<String,dynamic> params) async {
    return await repository.upLoadMultipleImages( params);
  }
}
