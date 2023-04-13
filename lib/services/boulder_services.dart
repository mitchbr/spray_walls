import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spray_walls/models/boulder.dart';

class BoulderServices {
  List<Boulder> buildListFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((e) {
      var rawData = {'id': e.id, ...e.data()! as Map};
      return Boulder.fromSnapshot(rawData);
    }).toList();
  }
}
