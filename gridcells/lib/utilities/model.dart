import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'algorithm/BFS.dart';

class GridModel {
  final List<List<String>> gridColors;

  GridModel({required this.gridColors});

  GridModel copyWith({List<List<String>>? gridColors}) {
    return GridModel(gridColors: gridColors ?? this.gridColors);
  }
}

class GridState extends StateNotifier<GridModel> {
  GridState()
      : super(GridModel(
            gridColors:
                List.generate(10, (_) => List<String>.filled(10, 'W'))));

  void resetGrid() {
    state = GridModel(
        gridColors: List.generate(10, (_) => List<String>.filled(10, 'W')));
  }

  void setColor(int row, int col, String colorCode) {
    final newGridColors = [...state.gridColors];
    newGridColors[row][col] = colorCode;
    state = state.copyWith(gridColors: newGridColors);
  }

  void highlightPath(List<Point> path) {
    final newGridColors = [...state.gridColors];
    for (Point point in path) {
      if (newGridColors[point.x][point.y] != 'R' &&
          newGridColors[point.x][point.y] != 'G') {
        newGridColors[point.x][point.y] = 'Y';
      }
    }
    state = state.copyWith(gridColors: newGridColors);
  }

  void highlightVisited(List<Point> visitedPoints) {
    final newGridColors = [...state.gridColors];
    for (final point in visitedPoints) {
      if (newGridColors[point.x][point.y] != 'R' &&
          newGridColors[point.x][point.y] != 'G') {
        newGridColors[point.x][point.y] = 'B';
      }
    }
    state = state.copyWith(gridColors: newGridColors);
  }
}

class ColorMapping {
  final Map<Color, String> colorToAlphabets = {
    Colors.white: 'W',
    Colors.red: 'R',
    Colors.blue: 'B',
    Colors.green: 'G',
    Colors.yellow: 'Y'
  };
  final Map<String, Color> alphabetToColor = {
    'W': Colors.white,
    'R': Colors.red,
    'B': Colors.blue,
    'G': Colors.green,
    'Y': Colors.yellow
  };
}
