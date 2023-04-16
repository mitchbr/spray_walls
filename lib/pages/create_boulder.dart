import 'package:flutter/material.dart';
import 'package:spray_walls/components/boulder_form.dart';

class CreateBoulder extends StatefulWidget {
  const CreateBoulder({super.key});

  @override
  State<CreateBoulder> createState() => _CreateBoulderState();
}

class _CreateBoulderState extends State<CreateBoulder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New Boulder")),
        body: BoulderForm(
          state: "create",
        ));
  }
}
