import 'package:house_rental_admin/src/home/domain/entities/house.dart';

class HouseDetailModel extends HouseDetail {
  const HouseDetailModel({
    required super.houseName,
    required super.description,
    required super.amount,
    required super.images,
    required super.bedRoomCount,
    required super.bathRoomCount,
    required super.owner,
    required super.phoneNumber,
    required super.isAvailable,
    required super.category,
    required super.lat,
    required super.long,
  });

  factory HouseDetailModel.fromJson(Map<String, dynamic>? json) =>
      HouseDetailModel(
          houseName: json?["house_name"],
          description: json?["description"],
          amount: json?["amount"],
          images: List<String>.from(json?["images"].map((e) => e)),
          bedRoomCount: json?["bed_room_count"],
          bathRoomCount: json?["bath_room_count"],
          phoneNumber: json?["phone_number"],
          owner: json?["owner"],
          isAvailable: json?["is_available"], 
          category: json?["category"],
          lat: json?["lat"],
          long: json?["long"]);

  Map<String, dynamic> toMap() {
    return {
      "house_name": houseName,
      "description": description,
      "owner": owner,
      "phone_number": phoneNumber,
      "amount": amount,
      "bed_room_count": bedRoomCount,
      "bath_room_count": bathRoomCount,
      "images": images,
      "category": category,
      "long": long,
      "lat": lat,
      "is_available": isAvailable
    };
  }
}
