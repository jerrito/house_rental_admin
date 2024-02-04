import 'package:equatable/equatable.dart';

class PlaceSearch extends Equatable {
  final List<Result>? results;
  const PlaceSearch({required this.results});

  @override
  List<Object?> get props => [results];
}

class Result extends Equatable {
  final Location? location;
  final String? formatedAddress;

  const Result({required this.location, required this.formatedAddress});

  @override
  List<Object?> get props => [location, formatedAddress];
}

class Geometry extends Equatable {
  final Location location;

 const Geometry({required this.location});
  @override
  // TODO: implement props
  List<Object?> get props => [location];
}

class Location extends Equatable {
  final num? lat, lng;

  const Location({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
