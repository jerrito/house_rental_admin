import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';
import 'package:house_rental_admin/src/home/domain/entities/house.dart';

abstract class HomeRemoteDataSource {
  Future<DocumentReference<HouseDetailModel>?> addHouse(
      Map<String, dynamic> params);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAdminAccount')
      .withConverter<HouseDetailModel>(
        fromFirestore: (snapshot, _) =>
            HouseDetailModel.fromJson(snapshot.data()!),
        toFirestore: (houseDetail, _) => houseDetail.toMap(),
      );
  @override
  Future<DocumentReference<HouseDetailModel>?> addHouse(
      Map<String, dynamic> params) async {
    final response =await usersRef.add(HouseDetailModel.fromJson(params));
    return response;
  }
}
