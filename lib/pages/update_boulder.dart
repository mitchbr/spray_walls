import 'package:flutter/material.dart';
import 'package:spray_walls/components/boulder_holds_form.dart';
import 'package:spray_walls/models/boulder.dart';

class UpdateBoulder extends StatelessWidget {
  final Boulder boulder;
  const UpdateBoulder({super.key, required this.boulder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Editing: ${boulder.name}")),
        body: BoulderHoldsForm(
          state: "update",
          boulder: boulder,
        ));
  }
}
