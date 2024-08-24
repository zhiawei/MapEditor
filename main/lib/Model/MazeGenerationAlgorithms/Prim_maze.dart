import 'dart:math';

class Prim_MazeGenerator {
  final int rows;
  final int cols;
  late List<List<String>> maze;

  Prim_MazeGenerator(this.rows, this.cols) {
    maze = List.generate(
        rows, (_) => List.filled(cols, 'W')); // Initialize with 'X'
    generateMaze();
  }

  List<List<String>> generateMaze() {
    final random = Random();
    final walls = <Point<int>>[];
    final directions = [
      const Point(0, 2), // Right
      const Point(2, 0), // Down
      const Point(0, -2), // Left
      const Point(-2, 0), // Up
    ];

    // Start with a random cell
    final start = Point(random.nextInt(rows), random.nextInt(cols));
    maze[start.x][start.y] = 'X'; // Mark the start point as path

    void addWalls(int r, int c) {
      for (final direction in directions) {
        final wall = Point(r + direction.x, c + direction.y);
        if (isValid(wall.x, wall.y) && maze[wall.x][wall.y] == 'W') {
          walls.add(wall);
        }
      }
    }

    addWalls(start.x, start.y);

    while (walls.isNotEmpty) {
      final wall = walls.removeAt(random.nextInt(walls.length));
      final (wallRow, wallCol) = (wall.x, wall.y);

      final adjacentCells = [
        Point(wallRow - 2, wallCol),
        Point(wallRow + 2, wallCol),
        Point(wallRow, wallCol - 2),
        Point(wallRow, wallCol + 2),
      ];

      final visitedCells = adjacentCells
          .where((p) => isValid(p.x, p.y) && maze[p.x][p.y] == 'X')
          .toList();

      if (visitedCells.length == 1) {
        maze[wallRow][wallCol] = 'X'; // Mark the wall cell as path
        addWalls(wallRow, wallCol); // Add new walls around the newly added path
      }
    }

    return maze;
  }

  bool isValid(int r, int c) {
    return r >= 0 && r < rows && c >= 0 && c < cols;
  }
}
