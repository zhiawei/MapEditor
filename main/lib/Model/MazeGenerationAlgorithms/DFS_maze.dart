import 'dart:math';

class MazeGenerator {
  final int rows;
  final int cols;
  late List<List<String>> maze;

  MazeGenerator(this.rows, this.cols) {
    maze = List.generate(
        rows, (_) => List.filled(cols, 'X')); // Initialize with 'X'
    generateMaze();
  }

  List<List<String>> generateMaze() {
    final random = Random();
    final stack = <Point<int>>[];
    final directions = [
      const Point(0, 1), // Right
      const Point(1, 0), // Down
      const Point(0, -1), // Left
      const Point(-1, 0), // Up
    ];

    void visit(int r, int c) {
      maze[r][c] = 'W'; // Mark the start point as path
      stack.add(Point(r, c));

      while (stack.isNotEmpty) {
        final current = stack.last;
        final (currentRow, currentCol) = (current.x, current.y);

        final neighbors = directions
            .map((d) => Point(currentRow + d.x * 2, currentCol + d.y * 2))
            .where((p) =>
                p.x >= 0 &&
                p.x < rows &&
                p.y >= 0 &&
                p.y < cols &&
                maze[p.x][p.y] == 'X') // Check if the cell is a wall
            .toList();

        if (neighbors.isNotEmpty) {
          final neighbor = neighbors[random.nextInt(neighbors.length)];
          final wall = Point(
              (currentRow + neighbor.x) ~/ 2, (currentCol + neighbor.y) ~/ 2);

          // Check if wall is within bounds before marking
          if (wall.x >= 0 && wall.x < rows && wall.y >= 0 && wall.y < cols) {
            maze[wall.x][wall.y] = 'W'; // Mark wall cell as path
          }

          // Check if neighbor is within bounds before marking
          if (neighbor.x >= 0 &&
              neighbor.x < rows &&
              neighbor.y >= 0 &&
              neighbor.y < cols) {
            maze[neighbor.x][neighbor.y] = 'W'; // Mark neighbor cell as path
            stack.add(neighbor);
          }
        } else {
          stack.removeLast();
        }
      }
    }

    // Ensure the starting point is within bounds
    if (rows > 0 && cols > 0) {
      visit(0, 0);
    }

    return maze;
  }
}
