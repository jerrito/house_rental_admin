import 'package:equatable/equatable.dart';

class HouseDetail extends Equatable {
  final String? houseName, description;
  final num? amount, bedRoomCount, bathRoomCount;
  final Images? images;

  const HouseDetail({
    required this.houseName,
    required this.description,
    required this.amount,
    required this.images,
    required this.bedRoomCount,
    required this.bathRoomCount,
    
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        houseName,
        description,
        amount,
        bedRoomCount,
        bathRoomCount,
        images,
      ];
}

class Images extends Equatable {
  final List<String>? images;

  const Images({required this.images});

  @override
  List<Object?> get props => [images];
}
