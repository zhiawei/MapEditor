import 'package:flutter/material.dart';

const MainBackgroundColor = Color.fromARGB(255, 0, 0, 0);
const startColor = Colors.red;
const goalColor = Colors.green;
const defaultColor = Colors.white;
const wallColor = Color.fromARGB(36, 255, 255, 255);
const visitedColor = Colors.blue;
const pathColor = Colors.yellow;

const highlightBorderColor = Color.fromARGB(255, 0, 255, 200);

BoxDecoration ViewDecoration() {
  return BoxDecoration(
    color: const Color.fromARGB(255, 39, 39, 39),
    border: Border.all(color: Colors.blue, width: 1),
  );
}

TextStyle MainTextStyle() {
  return const TextStyle(color: Colors.white);
}

TextStyle GridTextStyle() {
  return const TextStyle(
      color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold);
}

class ColorMapping {
  final Map<Color, String> colorToAlphabets = {
    defaultColor: 'W',
    startColor: 'R',
    visitedColor: 'B',
    goalColor: 'G',
    pathColor: 'Y',
    wallColor: 'X',
  };
  final Map<String, Color> alphabetToColor = {
    'W': defaultColor,
    'R': startColor,
    'B': visitedColor,
    'G': goalColor,
    'Y': pathColor,
    'X': wallColor
  };
}
