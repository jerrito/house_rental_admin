import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';

abstract class HomeRemoteDataSource {
  Future<DocumentReference<Map<String, dynamic>>?> addHouse(
      Map<String, dynamic> params);

  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(Map<String, dynamic> params);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAdminAccount')
      .doc()
      .withConverter<HouseDetailModel>(
        fromFirestore: (snapshot, _) =>
            HouseDetailModel.fromJson(snapshot.data()!),
        toFirestore: (houseDetail, _) => houseDetail.toMap(),
      );
  @override
  Future<DocumentReference<Map<String, dynamic>>> addHouse(
      Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        .collection('houseRentalAdminAccount')
        .doc(params["id"])
        .collection("houses")
        .add(HouseDetailModel.fromJson(params).toMap());
    return response;
  }

  @override
  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(
      Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        .collection('houseRentalAdminAccount')
        .doc(params["id"])
        .collection("houses")
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (houseDetail, _) => houseDetail.toMap(),
        )
        .get();

    return response;
  }
}
