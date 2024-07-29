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

  // Convert a Point instance to a Map
  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };

  // Create a Point instance from a Map
  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      json['x'],
      json['y'],
    );
  }
}

class algoResult {
  final Point? current;
  final List<Point> visitedPoints;

  algoResult(this.current, this.visitedPoints);
}
