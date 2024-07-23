import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Model/Coordinate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

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

  String exportGridState() {
    return jsonEncode(state.toJson());
  }

  void importGridState(String jsonString) {
    state = GridModel.fromJson(jsonDecode(jsonString));
  }

  Future<void> saveToFile() async {
    final directory = await FilePicker.platform.getDirectoryPath();

    if (directory != null) {
      final file = File('$directory/grid_state.txt');
      final gridJson = exportGridState();
      await file.writeAsString(gridJson);
    }
  }

  Future<void> loadFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final gridJsonString = await file.readAsString();
      importGridState(gridJsonString);
    }
  }
}
