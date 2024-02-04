import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';
import 'package:house_rental_admin/src/home/data/models/place_search_model.dart';
import "package:http/http.dart" as http;

abstract class HomeRemoteDataSource {
  Future<DocumentReference<HouseDetailModel>?> addHouse(
      Map<String, dynamic> params);

  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(
      Map<String, dynamic> params);

  Future<List<String>> upLoadMultipleImages(Map<String, dynamic> params);

  Future<void> updateHouse(Map<String, dynamic> params);

  Future<PlaceSearchModel> placeSearch(Map<String, dynamic> params);
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
  Future<DocumentReference<HouseDetailModel>> addHouse(
      Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        // .collection('houseRentalAdminAccount')
        // .doc(params["id"])
        .collection("houses")
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (house, _) => house.toMap(),
        )
        .add(HouseDetailModel.fromJson(params));
    return response;
  }

  @override
  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(
      Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        .collection("houses")
        .where("phone_number", isEqualTo: params["phone_number"])
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (houseDetail, _) => houseDetail.toMap(),
        )
        .get();

    return response;
  }

  @override
  Future<List<String>> upLoadMultipleImages(Map<String, dynamic> params) async {
    //Upload file
    final upLoadPath = FirebaseStorage.instance
        .ref()
        .child(
          params["phone_number"],
        )
        .child("houses");
    List<String> returnURL = [];

    for (int i = 0; i < params["images"]; i++) {
      final upLoadTask = upLoadPath.putFile(
        File(params["path"][i]),
      );

      await upLoadTask.whenComplete(
        () => upLoadPath.getDownloadURL().then((value) => returnURL.add(value)),
      );
    }

    //print(returnURL);

    return returnURL;
  }

  @override
  Future<void> updateHouse(Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        //.collection('houseRentalAdminAccount')
        .doc(params["id"])
        .collection("houses")
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (house, _) => house.toMap(),
        )
        .doc(params["id2"])
        .update(params);
    return response;
  }

  @override
  Future<PlaceSearchModel> placeSearch(Map<String, dynamic> params) async {
    final response = await http.get(Uri.parse("https://maps.googleapis.com/maps/api/place/textsearch/json?location=42.3675294%2C-71.186966&query=123%20main%20street&radius=10000&key=AIzaSyAN1qK_omx8p1g59BpEHJ2tsuirpFNpvns"));

    return PlaceSearchModel.fromJson(jsonDecode(response.body));
  }
}
