import 'package:flutter/material.dart';
import 'package:spray_walls/models/hold_colors_enum.dart';

Widget HoldOutline(holdVal, topRatio, leftRatio, onPressed, width) {
  var holdColors = HoldColors().colors;
  var radius = width / 10.0;

  return Positioned(
    top: (width < 700) ? (width - radius) * topRatio : 650 * topRatio,
    left: (width < 700) ? (width - radius) * leftRatio : 650 * leftRatio,
    child: Opacity(
      opacity: holdVal == 0 ? 0.0 : 1.0,
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            shape: BoxShape.circle,
            border: Border.all(
              width: 3,
              color: holdColors[holdVal],
            ),
          ),
        ),
      ),
    ),
  );
}
