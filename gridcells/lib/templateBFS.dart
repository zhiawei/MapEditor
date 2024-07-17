import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:collection';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Cells with Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grid Cells with Riverpod'),
        ),
        body: Row(
          children: [
            Container(
              width: 900,
              height: 900,
              child: GridWithTiles(),
            ),
            Sidebar(),
          ],
        ),
      ),
    );
  }
}

// State management with Riverpod
final gridProvider = StateNotifierProvider<GridState, GridModel>((ref) {
  return GridState();
});

class GridModel {
  final List<List<Color>> gridColors;
  final Point? start;
  final Point? goal;
  final List<Point> path;

  GridModel(
      {required this.gridColors, this.start, this.goal, required this.path});

  GridModel copyWith(
      {List<List<Color>>? gridColors,
      Point? start,
      Point? goal,
      List<Point>? path}) {
    return GridModel(
      gridColors: gridColors ?? this.gridColors,
      start: start ?? this.start,
      goal: goal ?? this.goal,
      path: path ?? this.path,
    );
  }
}

class GridState extends StateNotifier<GridModel> {
  GridState()
      : super(GridModel(
          gridColors:
              List.generate(10, (_) => List<Color>.filled(10, Colors.white)),
          path: [],
        ));

  void resetGrid() {
    state = GridModel(
      gridColors:
          List.generate(10, (_) => List<Color>.filled(10, Colors.white)),
      path: [],
    );
  }

  void setColor(int row, int col, Color color) {
    final newGridColors = [...state.gridColors];
    newGridColors[row][col] = color;
    state = state.copyWith(gridColors: newGridColors);
  }

  void setStart(int row, int col) {
    state = state.copyWith(start: Point(row, col));
  }

  void setGoal(int row, int col) {
    state = state.copyWith(goal: Point(row, col));
  }

  void bfs() {
    if (state.start == null || state.goal == null) return;

    final start = state.start!;
    final goal = state.goal!;
    final queue = Queue<Point>();
    final visited = Set<Point>();
    final parentMap = <Point, Point?>{};

    queue.add(start);
    visited.add(start);
    parentMap[start] = null;

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (current == goal) {
        _highlightPath(goal, parentMap);
        return;
      }

      for (final neighbor in _getNeighbors(current)) {
        if (!visited.contains(neighbor) && _isValidCell(neighbor)) {
          queue.add(neighbor);
          visited.add(neighbor);
          parentMap[neighbor] = current;
          setColor(neighbor.row, neighbor.col, Colors.yellow);
        }
      }
    }
  }

  List<Point> _getNeighbors(Point point) {
    return [
      Point(point.row - 1, point.col),
      Point(point.row + 1, point.col),
      Point(point.row, point.col - 1),
      Point(point.row, point.col + 1),
    ];
  }

  bool _isValidCell(Point point) {
    return point.row >= 0 && point.row < 10 && point.col >= 0 && point.col < 10;
  }

  void _highlightPath(Point goal, Map<Point, Point?> parentMap) {
    List<Point> path = [];
    Point? current = goal;
    while (current != null) {
      path.add(current);
      current = parentMap[current];
    }
    path = path.reversed.toList();
    state = state.copyWith(path: path);

    for (final point in path) {
      setColor(point.row, point.col, const Color.fromARGB(255, 0, 255, 234));
    }
  }
}

class Point {
  final int row;
  final int col;

  Point(this.row, this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          col == other.col;

  @override
  int get hashCode => row.hashCode ^ col.hashCode;
}

class GridWithTiles extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);
    final selectedColor = ref.watch(selectedColorProvider);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
      ),
      itemCount: 10 * 10,
      itemBuilder: (context, index) {
        int row = index ~/ 10;
        int col = index % 10;
        Color tileColor = gridState.gridColors[row][col];

        if (gridState.start != null &&
            gridState.start!.row == row &&
            gridState.start!.col == col) {
          tileColor = Colors.green;
        }
        if (gridState.goal != null &&
            gridState.goal!.row == row &&
            gridState.goal!.col == col) {
          tileColor = Colors.red;
        }

        return GestureDetector(
          onTap: () {
            if (selectedColor == Colors.green) {
              gridNotifier.setStart(row, col);
            } else if (selectedColor == Colors.red) {
              gridNotifier.setGoal(row, col);
            } else {
              gridNotifier.setColor(row, col, selectedColor);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: tileColor,
            ),
          ),
        );
      },
    );
  }
}

class Sidebar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridNotifier = ref.read(gridProvider.notifier);

    return Container(
      width: 100,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorOptionButton(
            color: Colors.blue,
            onTap: () =>
                ref.read(selectedColorProvider.notifier).state = Colors.blue,
          ),
          ColorOptionButton(
            color: Colors.green,
            onTap: () =>
                ref.read(selectedColorProvider.notifier).state = Colors.green,
          ),
          ColorOptionButton(
            color: Colors.red,
            onTap: () =>
                ref.read(selectedColorProvider.notifier).state = Colors.red,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              gridNotifier.resetGrid();
            },
            child: Text('Reset Grid'),
          ),
          ElevatedButton(
            onPressed: () {
              gridNotifier.bfs();
            },
            child: Text('Run BFS'),
          ),
        ],
      ),
    );
  }
}

class ColorOptionButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  ColorOptionButton({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        color: color,
      ),
    );
  }
}

final selectedColorProvider = StateProvider<Color>((ref) => Colors.blue);
