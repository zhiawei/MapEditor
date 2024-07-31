import 'package:flutter/material.dart';

const MainBackgroundColor = Color.fromARGB(255, 0, 0, 0);

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
    const Color.fromARGB(29, 255, 255, 255): 'W',
    Colors.red: 'R',
    Colors.blue: 'B',
    Colors.green: 'G',
    Colors.yellow: 'Y'
  };
  final Map<String, Color> alphabetToColor = {
    'W': const Color.fromARGB(29, 255, 255, 255),
    'R': Colors.red,
    'B': Colors.blue,
    'G': Colors.green,
    'Y': Colors.yellow
  };
}
