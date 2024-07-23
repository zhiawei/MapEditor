import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';
import 'Algorithms/BFS.dart';
import 'Algorithms/DFS.dart';
import 'Coordinate.dart';

class AlgorithmHandler {
  final WidgetRef ref;
  AlgorithmHandler(this.ref);

  void perform(algo) {
    Point? start;
    Point? goal;

    final selectedAlgorithm = algo;

    final GridState = ref.read(gridProvider);

    for (int row = 0; row < GridState.gridColors.length; row++) {
      for (int col = 0; col < GridState.gridColors[row].length; col++) {
        if (GridState.gridColors[row][col] == 'R') {
          start = Point(row, col);
        } else if (GridState.gridColors[row][col] == 'G') {
          goal = Point(row, col);
        }
      }
    }

    if (start != null && goal != null) {
      var algorithms = null;
      if (selectedAlgorithm == 'BFS') {
        algorithms = BFS(GridState.gridColors, 10, 10);
      } else if (selectedAlgorithm == 'DFS') {
        algorithms = DFS(GridState.gridColors, 10, 10);
      }
      List<Point> visitedPoints = [];
      List<Point> path = algorithms.perform(start, goal, visitedPoints);
      if (path.isNotEmpty) {
        ref.read(gridProvider.notifier).highlightVisited(visitedPoints);
        ref.read(gridProvider.notifier).highlightPath(path);
      } else {
        print('No path found');
      }
    } else {
      print('Start or Goal not defined');
    }
  }
}
