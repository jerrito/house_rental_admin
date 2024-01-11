import 'package:equatable/equatable.dart';

class HouseDetail extends Equatable {
  final String? name, description;
  final num? amount, bedRoomCount, bathRoomCount;
  final List<String>? images;

  const HouseDetail({
    required this.name,
    required this.description,
    required this.amount,
    required this.images,
    required this.bedRoomCount,
    required this.bathRoomCount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        description,
        amount,
        bedRoomCount,
        bathRoomCount,
        images,
      ];

      
}
