import 'package:house_rental_admin/src/home/domain/entities/house.dart';

class HouseDetailModel extends HouseDetail {
  const HouseDetailModel({
    required super.houseName,
    required super.description,
    required super.amount,
    required super.images,
    required super.bedRoomCount,
    required super.bathRoomCount,
  });

  factory HouseDetailModel.fromJson(Map<String, dynamic>? json) =>
      HouseDetailModel(
          houseName: json?["house_name"],
          description: json?["description"],
          amount: json?["amount"],
          images:List<String>.from(json?["images"].map<List<String>>((e)=>
          e)),
          bedRoomCount: json?["bed_room_count"],
          bathRoomCount: json?["bath_room_count"]);

  Map<String, dynamic> toMap() {
    return {
      "house_name": houseName,
      "description": description,
      "amount": amount,
      "bed_room_count": bedRoomCount,
      "bath_room_count": bathRoomCount,
      "images":List.from(images!.map((e)=>
      e),)
    };
  }
}


