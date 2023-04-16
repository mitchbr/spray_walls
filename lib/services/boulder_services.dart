import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/services/user_services.dart';

class BoulderServices {
  final _fireStore = FirebaseFirestore.instance;
  final userServices = UserServices();

  List<Boulder> buildListFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((e) {
      var rawData = {'id': e.id, ...e.data()! as Map};
      return Boulder.fromSnapshot(rawData);
    }).toList();
  }

  void addBoulder() async {
    // TODO: Add boulder as input parameter
    final boulder = Boulder(
      id: "tempid",
      user: "tempuser",
      name: "name",
      holds: [],
      stars: 0,
      ratingsCount: 0,
      sendCount: 0,
      description: "A boulder",
      grade: 1,
      location: "SplinterDome",
      private: true,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    boulder.user = await userServices.getUsername();
    final bouldersCollection = _fireStore.collection('boulders');
    bouldersCollection.add(boulder.toJson());
  }
}
