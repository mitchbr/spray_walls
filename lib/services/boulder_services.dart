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

  Future<void> addBoulder(Boulder boulder) async {
    final bouldersCollection = _fireStore.collection('boulders');
    bouldersCollection.add(boulder.toJson());
  }

  Future<void> updateBoulder(Boulder boulder) async {
    final bouldersCollection = _fireStore.collection('boulders');
    bouldersCollection.doc(boulder.id).update(boulder.toJson());
  }

  Future<void> deleteBoulder(String id) async {
    var checklistCollection = _fireStore.collection('boulders');
    await checklistCollection.doc(id).delete();
  }
}
