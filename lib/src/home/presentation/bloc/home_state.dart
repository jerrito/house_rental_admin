part of 'home_bloc.dart';

class HomeState {}

class HomeInitState extends HomeState {}

class GetProfileLoaded extends HomeState {
  final XFile file;

  GetProfileLoaded({required this.file});
}

class GetProfileError extends HomeState {
  final String errorMessage;
  GetProfileError({required this.errorMessage});
}

class HouseDocumentLoaded extends HomeState {
  final XFile file;
  HouseDocumentLoaded({required this.file});
}

class HouseDocumentError extends HomeState {
  final String errorMessage;
  HouseDocumentError({required this.errorMessage});
}


