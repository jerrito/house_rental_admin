import 'package:house_rental_admin/src/home/domain/entities/place_search.dart';

class PlaceSearchModel extends PlaceSearch {
  const PlaceSearchModel({required super.results});
  factory PlaceSearchModel.fromJson(Map<String, dynamic>? json) =>
      PlaceSearchModel(
        results:json?["results"].map<ResultModel>((e)=>
        ResultModel.fromJson(e)).toList(),
      );
}

class ResultModel extends Result {
  const ResultModel({
    required super.location,
    required super.formatedAddress,
  });

  factory ResultModel.fromJson(Map<String, dynamic>? json) => ResultModel(
        location: LocationModel.fromJson(json?["geometry"]),
        formatedAddress: json?["formated_address"],
      );
}

class GeometryModel extends Geometry {
  const GeometryModel({required super.location});

  factory GeometryModel.fromJson(Map<String, dynamic>? json) => GeometryModel(
        location: LocationModel.fromJson(
          json?["location"],
        ),
      );
}

class LocationModel extends Location {
  const LocationModel({required super.lat, required super.lng});

  factory LocationModel.fromJson(Map<String, dynamic>? json) => LocationModel(
        lat: json?["lat"],
        lng: json?["lng"],
      );
}
