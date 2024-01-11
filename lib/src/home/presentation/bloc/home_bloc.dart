import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/src/home/domain/usecases/add_multiple_image.dart';
import 'package:house_rental_admin/src/home/domain/usecases/get_profile_camera.dart';
import 'package:house_rental_admin/src/home/domain/usecases/get_profile_gallery.dart';
import 'package:house_rental_admin/src/authentication/domain/usecases/up_load_image.dart';
import 'package:image_picker/image_picker.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProfileCamera getProfileCamera;
  final GetProfileGallery getProfileGallery;
  final AddMultipleImage addMultipleImage;
  HomeBloc({
    required this.addMultipleImage,
    required this.getProfileCamera,
    required this.getProfileGallery,
  }) : super(HomeInitState()) {
    //!GET PROFILE Camera
    on<GetProfileCameraEvent>((event, emit) async {
      final response = await getProfileCamera.call(event.params);

      emit(response.fold((error) => GetProfileError(errorMessage: error),
          (response) => GetProfileLoaded(file: response)));
    });

    //!GET PROFILE Gallery
    on<GetProfileGalleryEvent>((event, emit) async {
      final response = await getProfileGallery.call(event.params);

      emit(response.fold((error) => GetProfileError(errorMessage: error),
          (response) => GetProfileLoaded(file: response)));
    });

    //!GET HOUSE DOCUMENT Camera
    on<GetHouseDocumentCameraEvent>((event, emit) async {
      final response = await getProfileCamera.call(event.params);
      emit(
        response.fold(
          (error) => HouseDocumentError(errorMessage: error),
          (response) => HouseDocumentLoaded(file: response),
        ),
      );
    });

    //!GET HOUSE DOCUMENT GALLERY
    on<GetHouseDocumentGalleryEvent>((event, emit) async {
      final response = await getProfileGallery.call(event.params);
      emit(
        response.fold(
          (error) => HouseDocumentError(errorMessage: error),
          (response) => HouseDocumentLoaded(file: response),
        ),
      );
    });

    //!ADD MULTIPLE IMAGES
    on<AddMultipleImageEvent>((event, emit) async {
      final response = await addMultipleImage.call(event.params);

      emit(
        response.fold(
          (error) => AddMultipleImageError(errorMessage: error),
          (response) => AddMultipleImageLoaded(
            files: response),
          ),
        
      );
    });
  }
}
