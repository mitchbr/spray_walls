import 'package:flutter/material.dart';
import 'package:spray_walls/components/bottom_app_bar.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/pages/update_boulder.dart';
import 'package:spray_walls/services/boulder_services.dart';

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

  @override
  void initState() {
    setState(() {
      controller = PageController(initialPage: widget.index);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: widget.listData.length,
      itemBuilder: (context, index) {
        return pageWidget(widget.listData[index]);
      },
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
      body: const Image(
        image: AssetImage('example_wall.jpeg'),
      ),
      bottomNavigationBar: BottomBoulderAppBar(),
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
