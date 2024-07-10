import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridModel {
  final List<List<Color>> gridColors;
  GridModel({required this.gridColors});

  GridModel copyWith({List<List<Color>>? gridColors}) {
    return GridModel(gridColors: gridColors ?? this.gridColors);
  }
}

class GridState extends StateNotifier<GridModel> {
  GridState()
      : super(GridModel(
            gridColors: List.generate(
                10, (_) => List<Color>.filled(10, Colors.white))));

  void resetGrid() {
    state = GridModel(
        gridColors:
            List.generate(10, (_) => List<Color>.filled(10, Colors.white)));
  }

  void setColor(int row, int col, Color color) {
    final newGridColors = [...state.gridColors];
    newGridColors[row][col] = color;
    state = state.copyWith(gridColors: newGridColors);
  }
}
