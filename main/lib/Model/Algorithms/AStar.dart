import 'package:collection/collection.dart';
import 'package:main/Model/Coordinate.dart';

class AStar {
  final List<List<String>> grid;
  final int rows;
  final int cols;
  final Point start;
  final Point goal;

  AStar(this.grid, this.rows, this.cols, this.start, this.goal);

  List<Point> directions = [
    Point(0, 1), // Right
    Point(1, 0), // Down
    Point(0, -1), // Left
    Point(-1, 0) // Up
  ];

  List<Point> perform(Point start, Point goal, List<Point> visitedPoints) {
    // Priority queue for open set, using f value to order nodes
    HeapPriorityQueue<Node> openSet =
        HeapPriorityQueue<Node>((a, b) => a.f.compareTo(b.f));
    Map<Point, Point?> cameFrom = {};
    Map<Point, int> gScore = {start: 0};
    Map<Point, int> fScore = {start: heuristic(start, goal)};

    openSet.add(Node(start, fScore[start]!));

    while (openSet.isNotEmpty) {
      Node currentNode = openSet.removeFirst();
      Point current = currentNode.point;

      if (current == goal) {
        return getPath(cameFrom, current); // Return path to goal
      }

      for (Point direction in directions) {
        Point neighbor =
            Point(current.x + direction.x, current.y + direction.y);

        if (!isValid(neighbor) ||
            grid[neighbor.x][neighbor.y] == 'R' ||
            grid[neighbor.x][neighbor.y] == 'X') {
          continue; // Skip invalid or blocked nodes
        }

        int tentativeGScore = gScore[current]! + 1;

        if (tentativeGScore < (gScore[neighbor] ?? double.infinity)) {
          cameFrom[neighbor] = current;
          gScore[neighbor] = tentativeGScore;
          fScore[neighbor] = gScore[neighbor]! + heuristic(neighbor, goal);
          visitedPoints.add(neighbor);

          // Check if the neighbor is not in the openSet by using contains
          if (!openSet.contains(Node(neighbor, fScore[neighbor]!))) {
            openSet.add(Node(neighbor, fScore[neighbor]!));
          }
        }
      }
    }

    return []; // Return empty path if no path is found
  }

  int heuristic(Point a, Point b) {
    // Using Manhattan Distance as the heuristic
    return (a.x - b.x).abs() + (a.y - b.y).abs();
  }

  bool isValid(Point point) {
    return point.x >= 0 && point.y >= 0 && point.x < rows && point.y < cols;
  }

  List<Point> getPath(Map<Point, Point?> cameFrom, Point current) {
    List<Point> path = [];
    Point? temp = current;
    while (temp != null) {
      path.add(temp);
      temp = cameFrom[temp];
    }
    return path.reversed.toList();
  }
}

class Node implements Comparable<Node> {
  final Point point;
  final int f;

  Node(this.point, this.f);

  @override
  int compareTo(Node other) => f.compareTo(other.f);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Node && other.point == point && other.f == f;
  }

  @override
  int get hashCode => point.hashCode ^ f.hashCode;
}
