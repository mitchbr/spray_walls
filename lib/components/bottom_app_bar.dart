import 'package:flutter/material.dart';
import 'package:spray_walls/custom_theme.dart';

class BottomBoulderAppBar extends StatelessWidget {
  BottomBoulderAppBar({
    super.key,
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  var theme = CustomTheme();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: theme.accentColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
