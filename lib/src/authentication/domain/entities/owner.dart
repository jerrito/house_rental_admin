import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final String firstName,
      middleName,
      lastName,
      phoneNumber,
      profileURL,
      email,
      password,
      houseGPSAddress,
      townORCity,
      role,
      houseDocument;
  String? id, uid;

  Owner({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileURL,
    required this.email,
    required this.password,
    required this.houseGPSAddress,
    required this.townORCity,
    required this.role,
    required this.houseDocument,
    required this.id,
    required this.uid,
  });
  //const Owner({});

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        phoneNumber,
        profileURL,
        email,
        password,
        houseGPSAddress,
        townORCity,
        role,
        houseDocument,
        id,
        uid
      ];

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
