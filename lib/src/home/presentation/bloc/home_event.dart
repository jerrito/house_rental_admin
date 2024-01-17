part of 'home_bloc.dart';

class HomeEvent {}

class GetProfileGalleryEvent extends HomeEvent {
  final NoParams params;
  GetProfileGalleryEvent({required this.params});
}

class GetProfileCameraEvent extends HomeEvent {
  final NoParams params;
  GetProfileCameraEvent({required this.params});
}

class GetHouseDocumentCameraEvent extends HomeEvent {
  final NoParams params;
  GetHouseDocumentCameraEvent({required this.params});
}

class GetHouseDocumentGalleryEvent extends HomeEvent {
  final NoParams params;
  GetHouseDocumentGalleryEvent({required this.params});
}

class AddMultipleImageEvent extends HomeEvent {
  final NoParams params;

  AddMultipleImageEvent({required this.params});
}

class AddHomeEvent extends HomeEvent {
  final Map<String, dynamic> params;
  AddHomeEvent({required this.params});
}

class GetAllHousesEvent extends HomeEvent {
  final Map<String, dynamic> params;
  GetAllHousesEvent({required this.params});
}
