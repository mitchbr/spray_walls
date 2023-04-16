import 'package:flutter/material.dart';
import 'package:spray_walls/components/boulder_form.dart';
import 'package:spray_walls/models/boulder.dart';

class UpdateBoulder extends StatefulWidget {
  final Boulder boulder;
  const UpdateBoulder({super.key, required this.boulder});

  @override
  State<UpdateBoulder> createState() => UpdateBoulderState();
}

class UpdateBoulderState extends State<UpdateBoulder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Editing: ${widget.boulder.name}")),
        body: BoulderForm(
          state: "update",
          boulder: widget.boulder,
        ));
  }
}
