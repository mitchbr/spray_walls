import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spray_walls/custom_theme.dart';
import 'package:spray_walls/pages/boulders_list.dart';
import 'package:spray_walls/services/boulder_services.dart';
import 'package:spray_walls/services/user_services.dart';

class BouldersStream extends StatefulWidget {
  const BouldersStream({super.key});

  @override
  State<BouldersStream> createState() => _BouldersStreamState();
}

class _BouldersStreamState extends State<BouldersStream> {
  final theme = CustomTheme();
  final userServices = UserServices();
  final boulderServices = BoulderServices();

  final Stream<QuerySnapshot> _bouldersStream = FirebaseFirestore.instance.collection('boulders').snapshots();
  List listData = [false];
  String username = '';

  @override
  void initState() {
    userServices.getUsername().then((value) {
      setState(() {
        username = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bodyWidget();
  }

  Widget bodyWidget() {
    return Scaffold(
      appBar: AppBar(title: const Text("Spray Walls")),
      body: bouldersStream(),
      floatingActionButton: FloatingActionButton(onPressed: () => boulderServices.addBoulder()),
    );
  }

  Widget bouldersStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: _bouldersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return errorIndicator(context);
        }

        if (snapshot.connectionState == ConnectionState.waiting || username == 'initial_username') {
          return circularIndicator(context);
        }

        listData = boulderServices.buildListFromSnapshot(snapshot);

        if (listData.isEmpty) {
          return emptyWidget(context);
        }

        return BouldersList(listData: listData);
      },
    );
  }

  Widget emptyWidget(BuildContext context) {
    return Center(
        child: Column(
      children: const [
        Icon(
          Icons.local_cafe_rounded,
          size: 100,
        ),
        Text("Uh oh! Looks like this wall doesn't have any boulders")
      ],
    ));
  }

  Widget circularIndicator(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: theme.accentHighlightColor,
    ));
  }

  Widget errorIndicator(BuildContext context) {
    return const Center(child: Text("Error loading data"));
  }
}
