import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';
import 'Algorithms/BFS.dart';
import 'Algorithms/DFS.dart';
import 'Coordinate.dart';

class AlgorithmHandler {
  final WidgetRef ref;
  final String selectedAlgorithm;
  dynamic algorithms;
  Timer? timer;
  List<Point> visitedPoints = [];
  AlgorithmHandler(this.ref, this.selectedAlgorithm);

  Future<void> perform() async {
    Point? start;
    Point? goal;

    final gridState = ref.read(gridProvider);
    // final rowCount = ref.watch(rowCountProvider.notifier).state;
    final colCount = ref.watch(colCountProvider.notifier).state;

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
        print(visitedPoints);
        await ref.read(gridProvider.notifier).highlightVisited(visitedPoints);
        await ref.read(gridProvider.notifier).highlightPath(path);
      } else {
        print('No path found');
      }
    } else {
      print('Start or Goal not defined');
    }
  }

  // void Start() {
  //   Point? start;
  //   Point? goal;

  //   final gridState = ref.read(gridProvider);

  //   for (int row = 0; row < gridState.gridColors.length; row++) {
  //     for (int col = 0; col < gridState.gridColors[row].length; col++) {
  //       if (gridState.gridColors[row][col] == 'R') {
  //         start = Point(row, col);
  //       } else if (gridState.gridColors[row][col] == 'G') {
  //         goal = Point(row, col);
  //       }
  //     }
  //   }

  //   if (start != null && goal != null) {
  //     this.algorithms = BFS(gridState.gridColors, 10, 10, start, goal);
  //     algorithms.initialize();
  //     timer?.cancel();
  //     timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
  //       algoResult path = algorithms.step(visitedPoints);
  //       ref.read(gridProvider.notifier).highlightVisited(visitedPoints);
  //       if (path.current == null || path.current == goal) {
  //         timer.cancel();
  //         ref.read(gridProvider.notifier).highlightPath(path.visitedPoints);
  //       }
  //     });
  //   }
  // }
}
