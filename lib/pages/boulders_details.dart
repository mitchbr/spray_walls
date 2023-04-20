import 'package:flutter/material.dart';

import 'package:spray_walls/components/bottom_app_bar.dart';
import 'package:spray_walls/components/hold_outline.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/pages/update_boulder.dart';
import 'package:spray_walls/services/boulder_services.dart';
import 'package:spray_walls/models/hold_colors_enum.dart';

class BouldersDetails extends StatefulWidget {
  final List listData;
  final int index;
  const BouldersDetails({super.key, required this.listData, required this.index});

  @override
  State<BouldersDetails> createState() => _BouldersDetailsState();
}

class _BouldersDetailsState extends State<BouldersDetails> {
  final boulderServices = BoulderServices();
  late PageController controller;

  var holdColors = HoldColors().colors;

  @override
  void initState() {
    setState(() {
      controller = PageController(initialPage: widget.index);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double radius = width / 10.0;

    return PageView.builder(
      controller: controller,
      itemCount: widget.listData.length,
      itemBuilder: (context, index) {
        return pageWidget(widget.listData[index], width, radius);
      },
    );
  }

  Widget pageWidget(boulder, width, radius) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              boulder.name,
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              "V${boulder.grade}, Set by ${boulder.user}",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => pushUpdateBoulder(context, boulder),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => verifyDeleteBoulder(context, boulder.id),
                  ),
              icon: const Icon(Icons.delete))
        ],
      ),
      body: imageView(boulder, width, radius),
      bottomNavigationBar: BottomBoulderAppBar(),
    );
  }

  Widget imageView(Boulder boulder, width, radius) {
    return InteractiveViewer(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('example_wall.png'),
            width: (width < 700) ? width : 700,
          ),
          HoldOutline(boulder.holds[0], 0.17, 0.17, () => {}, width),
          HoldOutline(boulder.holds[1], 0.17, 0.7, () => {}, width),
          HoldOutline(boulder.holds[2], 0.5, 0.4, () => {}, width),
          HoldOutline(boulder.holds[3], 0.7, 0.17, () => {}, width),
          HoldOutline(boulder.holds[4], 0.7, 0.75, () => {}, width),
        ],
      ),
    );
  }

  void pushUpdateBoulder(BuildContext context, Boulder boulder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateBoulder(boulder: boulder),
      ),
    ).then((data) => setState(() => {}));
  }

  Widget verifyDeleteBoulder(BuildContext context, String id) {
    return AlertDialog(
        title: const Text('Delete Boulder?'),
        content: const Text('This will permanently remove the boulder'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              boulderServices.deleteBoulder(id);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ]);
  }
}
