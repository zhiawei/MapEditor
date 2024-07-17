import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model.dart';

final gridProvider = StateNotifierProvider<GridState, GridModel>((ref) {
  return GridState();
});

final selectedColorProvider = StateProvider<Color>((ref) {
  return Colors.white;
});

final colorMappingProvider = Provider((ref) => ColorMapping());
