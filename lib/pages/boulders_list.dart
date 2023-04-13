import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spray_walls/custom_theme.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/services/boulder_services.dart';
import 'package:spray_walls/services/user_services.dart';

class BouldersList extends StatefulWidget {
  const BouldersList({super.key});

  @override
  State<BouldersList> createState() => _BouldersListState();
}

class _BouldersListState extends State<BouldersList> {
  final theme = CustomTheme();
  final userServices = UserServices();
  final boulderServices = BoulderServices();

  List listData = [false];
  final Stream<QuerySnapshot> _bouldersStream = FirebaseFirestore.instance.collection('boulders').snapshots();
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
      body: listThingy(),
    );
  }

  Widget listThingy() {
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

        return entriesList(context);
      },
    );
  }

  Widget emptyWidget(BuildContext context) {
    return const Center(
        child: Icon(
      Icons.book,
      size: 100,
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

  Widget entriesList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return boulderTile(listData[index]);
      },
    );
  }

  Widget boulderTile(Boulder item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Row(
        children: [
          Text(item.user),
          const SizedBox(width: 5),
          starRating(item),
          const SizedBox(width: 5),
          Text("V${item.grade}"),
        ],
      ),
      onTap: () => {},
    );
  }

  Widget starRating(Boulder item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          index < item.stars ? Icons.star : Icons.star_border,
          size: 15,
        );
      }),
    );
  }
}
