import 'package:flutter/material.dart';
import 'package:spray_walls/custom_theme.dart';

import 'package:spray_walls/pages/boulders_list.dart';
import 'package:spray_walls/pages/login_page.dart';
import 'package:spray_walls/services/user_services.dart';

class SprayWalls extends StatefulWidget {
  const SprayWalls({super.key});

  @override
  State<SprayWalls> createState() => _SprayWallsState();
}

class _SprayWallsState extends State<SprayWalls> {
  final theme = CustomTheme();
  bool signedIn = false;
  Future<bool> getUsername = UserServices().checkUserExists();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsername,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (!snapshot.data) {
            return LoginPage(callback: callback);
          } else {
            return const BouldersList();
          }
        } else if (snapshot.hasError) {
          return bodyWidget(loadingError());
        } else {
          return bodyWidget(circularIndicator(context));
        }
      },
    );
  }

  Widget bodyWidget(Widget child) {
    return Scaffold(
      appBar: AppBar(title: const Text("Groceries")),
      body: child,
    );
  }

  Widget circularIndicator(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: theme.accentHighlightColor,
    ));
  }

  Widget loadingError() {
    return Center(
        child: Column(
      children: [
        const Text(
          "There was an error loading data, please try again",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        IconButton(
            onPressed: (() async {
              setState(() {
                getUsername = UserServices().checkUserExists();
              });
            }),
            icon: const Icon(Icons.refresh))
      ],
    ));
  }

  void callback(BuildContext context) {
    setState(() {
      getUsername = UserServices().checkUserExists();
    });
  }
}
