import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';

class OwnerModel extends Owner {
  OwnerModel({
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.phoneNumber,
    required super.profileURL,
    required super.email,
    required super.password,
    required super.houseGPSAddress,
    required super.townORCity,
    required super.role,
    required super.houseDocument,
    required super.id,
    required super.uid,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) => OwnerModel(
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        profileURL: json["profile_URL"],
        email: json["email"],
        password: json["password"],
        houseGPSAddress: json["houseGPSAddress"],
        townORCity: json["townORCity"],
        role: json["role"],
        houseDocument: json["houseDocument"],
        id: json["id"],
        uid: json["uid"],
      );

      Map<String,dynamic> toMap()=>
      {
        "first_name":firstName,
        "middle_name":middleName,
        "last_name":lastName,
        "phone_number":phoneNumber,
        "profile_URL":profileURL,
        "email":email,
        "password":password,
        "house_GPS_adddress":houseGPSAddress,
        "town_or_city":townORCity,
        "role":role,
        "house_document":houseDocument,
        "id":id,
        "uid":uid
      };
}
