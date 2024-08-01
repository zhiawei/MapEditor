import 'dart:collection';
import 'package:main/Model/Coordinate.dart';

class BFS {
  final List<List<String>> grid;
  final int rows;
  final int cols;
  final Point start;
  final Point goal;
  BFS(this.grid, this.rows, this.cols, this.start, this.goal);

  List<Point> directions = [
    Point(0, 1),
    Point(1, 0),
    Point(0, -1),
    Point(-1, 0)
  ];

  Queue<Point> queue = Queue<Point>();
  Map<Point, Point?> visited = {};

  List<Point> perform(Point start, Point goal, List<Point> visitedPoints) {
    List<Point> directions = [
      Point(0, 1),
      Point(1, 0),
      Point(0, -1),
      Point(-1, 0)
    ];
    Queue<Point> queue = Queue<Point>();
    // List<Point> queue = [];
    Map<Point, Point?> visited = {};

    queue.add(start);
    visited[start] = null;

    while (queue.isNotEmpty) {
      Point current = queue.removeFirst();

      if (current == goal) {
        return getPath(visited, start, goal);
      }

      for (Point direction in directions) {
        Point neighbor =
            Point(current.x + direction.x, current.y + direction.y);

        if (isValid(neighbor) &&
            grid[neighbor.x][neighbor.y] != 'R' &&
            grid[neighbor.x][neighbor.y] != 'X' &&
            !visited.containsKey(neighbor)) {
          queue.add(neighbor);
          visited[neighbor] = current;
          visitedPoints.add(neighbor);
        }
      }
    }
    return [];
  }

  bool isValid(Point point) {
    return point.x >= 0 && point.y >= 0 && point.x < rows && point.y < cols;
  }

  List<Point> getPath(Map<Point, Point?> visited, Point start, Point goal) {
    List<Point> path = [];
    Point? current = goal;

    while (current != null) {
      path.add(current);
      current = visited[current];
    }

    path = path.reversed.toList();
    return path;
  }
}
