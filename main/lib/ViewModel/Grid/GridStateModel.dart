import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Model/Coordinate.dart';
import 'package:main/Model/MazeGenerationAlgorithms/DFS_maze.dart';
import 'package:main/Model/SaveLoad.dart';

class GridModel {
  final List<List<String>> gridColors;
  GridModel({required this.gridColors});

  GridModel copyWith({List<List<String>>? gridColors}) {
    return GridModel(gridColors: gridColors ?? this.gridColors);
  }

  Map<String, dynamic> toJson() {
    return {'gridColors': gridColors};
  }

  factory GridModel.fromJson(Map<String, dynamic> json) {
    return GridModel(
        gridColors: List<List<String>>.from(
            json['gridColors'].map((row) => List<String>.from(row).toList())));
  }
}

class GridState extends StateNotifier<GridModel> {
  GridState()
      : super(GridModel(
            gridColors:
                List.generate(10, (_) => List<String>.filled(10, 'W'))));

  void resetGrid(int colCount) {
    state = GridModel(
        gridColors:
            List.generate(colCount, (_) => List<String>.filled(colCount, 'W')));
  }

  void setColor(int row, int col, String colorCode) {
    final newGridColors = [...state.gridColors];
    newGridColors[row][col] = colorCode;
    state = state.copyWith(gridColors: newGridColors);
  }

  Future<void> highlightPath(List<Point> path) async {
    final newGridColors = [...state.gridColors];
    for (Point point in path) {
      if (newGridColors[point.x][point.y] != 'R' &&
          newGridColors[point.x][point.y] != 'G') {
        newGridColors[point.x][point.y] = 'Y';
        state = state.copyWith(gridColors: newGridColors);
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    state = state.copyWith(gridColors: newGridColors);
  }

  Future<void> highlightVisited(List<Point> visitedPoints) async {
    final newGridColors = [...state.gridColors];
    for (final point in visitedPoints) {
      if (newGridColors[point.x][point.y] != 'R' &&
          newGridColors[point.x][point.y] != 'G') {
        newGridColors[point.x][point.y] = 'Y';
        state = state.copyWith(gridColors: newGridColors);
        await Future.delayed(const Duration(milliseconds: 100));
        newGridColors[point.x][point.y] = 'B';
        state = state.copyWith(gridColors: newGridColors); // Delay
      }
    }
    state = state.copyWith(gridColors: newGridColors);
  }

  void resetPath(List<List<String>> originalGrid) {
    state = GridModel(
      gridColors: originalGrid.map((row) {
        return row.map((cell) {
          if (cell == 'R' || cell == 'G') {
            return cell;
          } else {
            return 'W';
          }
        }).toList();
      }).toList(),
    );
  }

  Future<void> saveGridToFile() async {
    await saveToFile(state);
  }

  Future<void> loadGridFromFile() async {
    final gridModel = await loadFromFile();
    if (gridModel != null) {
      state = gridModel;
    }
  }

  void generateMaze() {
    final mazeGenerator = MazeGenerator(
      state.gridColors.length,
      state.gridColors[0].length,
    );
    final newMaze = mazeGenerator.maze;

    state = GridModel(gridColors: newMaze);
  }
}
