import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';
import 'Algorithms/BFS.dart';
import 'Algorithms/DFS.dart';
import 'Coordinate.dart';

class AlgorithmHandler {
  final WidgetRef ref;
  final String? selectedAlgorithm;
  dynamic algorithms;
  Timer? timer;
  // List<Point> visitedPoints = [];
  AlgorithmHandler(this.ref, this.selectedAlgorithm);

  Future<void> perform() async {
    Point? start;
    Point? goal;

    final gridState = ref.read(gridProvider);
    final visitedPoints = ref.read(visitedPointsProvider.notifier).state = [];
    // final rowCount = ref.watch(rowCountProvider.notifier).state;
    final colCount = ref.watch(colCountProvider.notifier).state;
    final errorMessage = ref.watch(errorMessageProvider);

    for (int row = 0; row < gridState.gridColors.length; row++) {
      for (int col = 0; col < gridState.gridColors[row].length; col++) {
        if (gridState.gridColors[row][col] == 'R') {
          start = Point(row, col);
        } else if (gridState.gridColors[row][col] == 'G') {
          goal = Point(row, col);
        }
      }
    }

    if (start != null && goal != null) {
      if (selectedAlgorithm == 'BFS') {
        algorithms = BFS(gridState.gridColors, colCount, colCount, start, goal);
      } else if (selectedAlgorithm == 'DFS') {
        algorithms = DFS(gridState.gridColors, colCount, colCount);
      }
      List<Point> path = algorithms.perform(start, goal, visitedPoints);
      if (path.isNotEmpty) {
        ref.read(errorMessageProvider.notifier).state = '';
        ref.read(visitedPointsProvider.notifier).state = visitedPoints;
        await ref.read(gridProvider.notifier).highlightVisited(visitedPoints);
        await ref.read(gridProvider.notifier).highlightPath(path);
      } else {
        ref.read(errorMessageProvider.notifier).state = 'No path found';
      }
    } else {
      ref.read(errorMessageProvider.notifier).state =
          'Start or Goal not defined';
    }
  }
}
