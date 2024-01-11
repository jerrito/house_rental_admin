import 'package:dartz/dartz.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/src/home/domain/repository/home_repository.dart';
import 'package:image_picker/image_picker.dart';

class AddMultipleImage extends UseCases<List<XFile>,NoParams> {
  final HomeRepository repository;

  AddMultipleImage({required this.repository});

  @override
  Future<Either<String, List<XFile>>> call(NoParams params) async {
    return await repository.addMultipleImage();
  }
}
