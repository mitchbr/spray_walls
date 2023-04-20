import 'package:flutter/material.dart';

import 'package:spray_walls/components/hold_outline.dart';
import 'package:spray_walls/custom_theme.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/models/hold_placement_enum.dart';
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
  var theme = CustomTheme();

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
      physics: const NeverScrollableScrollPhysics(),
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
      bottomNavigationBar: bottomAppBar(),
    );
  }

  Widget imageView(Boulder boulder, width, radius) {
    var placements = HoldPlacement().holds;
    return InteractiveViewer(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('example_wall.png'),
            width: (width < 700) ? width : 700,
          ),
          HoldOutline(boulder.holds[0], placements[0]["top"], placements[0]["left"], () => {}, width),
          HoldOutline(boulder.holds[1], placements[1]["top"], placements[1]["left"], () => {}, width),
          HoldOutline(boulder.holds[2], placements[2]["top"], placements[2]["left"], () => {}, width),
          HoldOutline(boulder.holds[3], placements[3]["top"], placements[3]["left"], () => {}, width),
          HoldOutline(boulder.holds[4], placements[4]["top"], placements[4]["left"], () => {}, width),
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

  Widget bottomAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: theme.accentColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              tooltip: 'Previous Boulder',
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                if (controller.page != 0) {
                  controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                }
              },
            ),
            IconButton(
              tooltip: 'Route Details',
              icon: const Icon(Icons.info),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Mark Send',
              icon: const Icon(Icons.check),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Next Boulder',
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                if (controller.page != widget.listData.length - 1) {
                  controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
