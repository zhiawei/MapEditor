class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Point(x: $x, y: $y)';
}

class algoResult {
  final Point? current;
  final List<Point> visitedPoints;

  algoResult(this.current, this.visitedPoints);
}
