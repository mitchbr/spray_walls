import 'package:flutter/material.dart';
import 'package:spray_walls/components/boulder_meta_form.dart';
import 'package:spray_walls/components/hold_outline.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/models/hold_colors_enum.dart';
import 'package:spray_walls/models/hold_placement_enum.dart';

class BoulderHoldsForm extends StatefulWidget {
  final Boulder boulder;
  final String state;
  const BoulderHoldsForm({super.key, required this.boulder, required this.state});

  @override
  State<BoulderHoldsForm> createState() => _BoulderHoldsFormState();
}

class _BoulderHoldsFormState extends State<BoulderHoldsForm> {
  late PageController controller;

  var holdColors = HoldColors().colors;

  @override
  void initState() {
    setState(() {
      controller = PageController(initialPage: 0);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: imageView(width),
        floatingActionButton: FloatingActionButton(onPressed: () => pushBoulderMetaForm(context)));
  }

  Widget imageView(width) {
    Boulder boulder = widget.boulder;
    var placements = HoldPlacement().holds;

    return InteractiveViewer(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('example_wall.png'),
            width: (width < 700) ? width : 700,
          ),
          HoldOutline(
            boulder.holds[0],
            placements[0]["top"],
            placements[0]["left"],
            () {
              (boulder.holds[0] < 4) ? ++boulder.holds[0] : boulder.holds[0] = 0;
              setState(() {});
            },
            width,
          ),
          HoldOutline(
            boulder.holds[1],
            placements[1]["top"],
            placements[1]["left"],
            () {
              (boulder.holds[1] < 4) ? ++boulder.holds[1] : boulder.holds[1] = 0;
              setState(() {});
            },
            width,
          ),
          HoldOutline(
            boulder.holds[2],
            placements[2]["top"],
            placements[2]["left"],
            () {
              (boulder.holds[2] < 4) ? ++boulder.holds[2] : boulder.holds[2] = 0;
              setState(() {});
            },
            width,
          ),
          HoldOutline(
            boulder.holds[3],
            placements[3]["top"],
            placements[3]["left"],
            () {
              (boulder.holds[3] < 4) ? ++boulder.holds[3] : boulder.holds[3] = 0;
              setState(() {});
            },
            width,
          ),
          HoldOutline(
            boulder.holds[4],
            placements[4]["top"],
            placements[4]["left"],
            () {
              (boulder.holds[4] < 4) ? ++boulder.holds[4] : boulder.holds[4] = 0;
              setState(() {});
            },
            width,
          ),
        ],
      ),
    );
  }

  void pushBoulderMetaForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BoulderMetaForm(
          state: widget.state,
          boulder: widget.boulder,
        ),
      ),
    ).then((data) => setState(() => {}));
  }
}
