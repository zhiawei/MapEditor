import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Grid/GridStateModel.dart';
import 'package:main/Model/MazeGenerationAlgorithms/DFS_maze.dart';
import 'package:main/Utilities/Themes.dart';

final gridProvider = StateNotifierProvider<GridState, GridModel>((ref) {
  // final rowCount = ref.watch(rowCountProvider);
  final colCount = ref.watch(colCountProvider);
  final gridState = GridState();
  gridState.resetGrid(colCount);
  return gridState;
});

final selectedColorProvider = StateProvider<Color>((ref) {
  return MainBackgroundColor;
});

final colorMappingProvider = Provider((ref) => ColorMapping());

final selectedAlgorithmProvider = StateProvider<String?>((ref) => null);

// final rowCountProvider = StateProvider<int>((ref) => 10);
final colCountProvider = StateProvider<int>((ref) => 10);

final widthGridProvider = StateProvider<double>((ref) => 500);
final heightGridProvider = StateProvider<double>((ref) => 500);
