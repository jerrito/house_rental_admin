import 'package:equatable/equatable.dart';

class HouseDetail extends Equatable {
  final String? houseName, owner, phoneNumber, description, category;
  final num? amount, bedRoomCount, bathRoomCount, lat, long;
  final bool? isAvailable;
  final List<String>? images;

  const HouseDetail({
    required this.category,
    required this.lat,
    required this.long,
    required this.owner,
    required this.phoneNumber,
    required this.houseName,
    required this.description,
    required this.amount,
    required this.images,
    required this.bedRoomCount,
    required this.isAvailable,
    required this.bathRoomCount,
  });

  @override
  List<Object?> get props => [
        houseName,
        description,
        owner,
        amount,
        phoneNumber,
        bedRoomCount,
        bathRoomCount,
        images,
        isAvailable,
        lat,
        long,
        category
      ];
}
