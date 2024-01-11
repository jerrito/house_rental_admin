import 'package:house_rental_admin/src/home/domain/entities/house.dart';

class HouseDetailModel extends HouseDetail {
  const HouseDetailModel({
    required super.name,
    required super.description,
    required super.amount,
    required super.images,
    required super.bedRoomCount,
    required super.bathRoomCount,
  });

  factory HouseDetailModel.fromJson(Map<String, dynamic> json) =>
      HouseDetailModel(
          name: json["name"],
          description: json["description"],
          amount: json["amount"],
          images: json["images"].map((e)=>
         e ).toList(),
          bedRoomCount: json["bed_room_count"],
          bathRoomCount: json["bath_room_count"]);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "amount": amount,
      "bed_room_count": bedRoomCount,
      "bath_room_count": bathRoomCount,
    };
  }
}
