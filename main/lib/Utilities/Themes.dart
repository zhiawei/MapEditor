import 'package:flutter/material.dart';

const MainBackgroundColor = Color.fromARGB(255, 0, 0, 0);
const startColor = Colors.red;
const goalColor = Colors.green;
const defaultColor = Color.fromARGB(183, 255, 255, 255);
const wallColor = Color.fromARGB(36, 255, 255, 255);
const visitedColor = Colors.blue;
const pathColor = Colors.yellow;

const mainLayoutColor = Color.fromARGB(255, 39, 39, 39);
const mainTooltipColor = Color.fromARGB(255, 75, 75, 75);
const highlightBorderColor = Color.fromARGB(255, 0, 255, 200);

BoxDecoration ViewDecoration() {
  return BoxDecoration(
    color: mainLayoutColor,
    border: Border.all(color: Colors.blue, width: 1),
  );
}

BoxDecoration tooltipDecoration() {
  return BoxDecoration(
    color: mainTooltipColor, // Custom tooltip background color
    borderRadius: BorderRadius.circular(8),
  );
}

TextStyle speedControllerTextStyle() {
  return const TextStyle(color: Colors.white);
}

OutlineInputBorder speedControllerBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: Colors.black, // Change default border color
    ),
  );
}

OutlineInputBorder speedControllerFocusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: highlightBorderColor, // Change border color when enabled
      width: 1.0,
    ),
  );
}

OutlineInputBorder speedControllerEnabledBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: Colors.blue, // Change default border color
    ),
  );
}

TextStyle tooltipTextStyle() {
  return const TextStyle(color: Colors.white, fontSize: 20);
}

TextStyle mainTextStyle() {
  return const TextStyle(color: Colors.white);
}

TextStyle gridTextStyle() {
  return const TextStyle(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
}

TextStyle gridViewTextStyle() {
  return const TextStyle(
      color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
}

class ColorMapping {
  final Map<String, Color> alphabetToColor = {
    'W': defaultColor,
    'R': startColor,
    'B': visitedColor,
    'G': goalColor,
    'Y': pathColor,
    'X': wallColor
  };

  late final Map<Color, String> colorToAlphabet;

  ColorMapping() {
    colorToAlphabet = reverseMap(alphabetToColor);
  }
}

Map<Color, String> reverseMap(Map<String, Color> original) {
  return Map.fromEntries(
    original.entries.map((entry) => MapEntry(entry.value, entry.key)),
  );
}

SliderThemeData customSliderTheme() {
  return SliderThemeData(
      activeTrackColor:
          const Color.fromARGB(255, 0, 110, 255), // Color of the active track
      inactiveTrackColor: Colors.grey, // Color of the inactive track
      thumbColor: const Color.fromARGB(255, 0, 89, 255), // Color of the thumb
      overlayColor: Colors.blue
          .withOpacity(0.2), // Color of the overlay when thumb is active
      thumbShape:
          RoundSliderThumbShape(enabledThumbRadius: 12), // Size of the thumb
      overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
      valueIndicatorColor: mainTooltipColor);
}
