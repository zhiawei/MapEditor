import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Grid/GridStateModel.dart';
import 'package:main/Utilities/Themes.dart';

final gridProvider = StateNotifierProvider<GridState, GridModel>((ref) {
  return GridState();
});

final selectedColorProvider = StateProvider<Color>((ref) {
  return MainBackgroundColor;
});

final colorMappingProvider = Provider((ref) => ColorMapping());

final selectedAlgorithmProvider = StateProvider<String?>((ref) => null);
