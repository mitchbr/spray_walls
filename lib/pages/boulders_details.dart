import 'package:flutter/material.dart';
import 'package:spray_walls/components/bottom_app_bar.dart';

class BouldersDetails extends StatefulWidget {
  final List listData;
  final int index;
  const BouldersDetails({super.key, required this.listData, required this.index});

  @override
  State<BouldersDetails> createState() => _BouldersDetailsState();
}

class _BouldersDetailsState extends State<BouldersDetails> {
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    setState(() {
      controller.jumpToPage(widget.index);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: widget.listData.map((boulder) => pageWidget(boulder)).toList(),
    );
  }

  Widget pageWidget(boulder) {
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
      )),
      body: const Image(
        image: AssetImage('example_wall.jpeg'),
      ),
      bottomNavigationBar: BottomBoulderAppBar(),
    );
  }
}
