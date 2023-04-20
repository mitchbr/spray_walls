import 'package:flutter/material.dart';

import 'package:spray_walls/components/boulder_holds_form.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/services/user_services.dart';

class CreateBoulder extends StatelessWidget {
  CreateBoulder({super.key});

  final userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New Boulder")),
        body: BoulderHoldsForm(
          state: "create",
          boulder: Boulder.create('', [0, 0, 0, 0, 0], '', '', '', true),
        ));
  }
}
