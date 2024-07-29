import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';
import 'Coordinate.dart';

class API_Messenger {
  final WidgetRef ref;
  API_Messenger(this.ref);
  Future<Map<String, dynamic>> fetchBFSResult() async {
    Point? start;
    Point? goal;

    Map<String, dynamic>? START;
    Map<String, dynamic>? GOAL;

    final GridState = ref.read(gridProvider);

    for (int row = 0; row < GridState.gridColors.length; row++) {
      for (int col = 0; col < GridState.gridColors[row].length; col++) {
        if (GridState.gridColors[row][col] == 'R') {
          start = Point(row, col);
          START = start.toJson();
        } else if (GridState.gridColors[row][col] == 'G') {
          goal = Point(row, col);
          GOAL = goal.toJson();
        }
      }
    }

    // print(GridState.gridColors);

    // if (path.isNotEmpty) {
    //     print(visitedPoints);
    //     await ref.read(gridProvider.notifier).highlightVisited(visitedPoints);
    //     await ref.read(gridProvider.notifier).highlightPath(path);
    //   } else {
    //     print('No path found');
    //   }
    // } else {
    //   print('Start or Goal not defined');
    // }

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/bfs'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        // 'message': 'hello'
        'grid': GridState.gridColors,
        'start': START,
        'goal': GOAL,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List<dynamic> pathCoordinates = decodedJson['path'];
      List<dynamic> VisitedCoordinates = decodedJson['visited'];
      List<Point> pathPoints = pathCoordinates.map((coords) {
        return Point(coords[0], coords[1]);
      }).toList();
      List<Point> visitedPoints = VisitedCoordinates.map((coords) {
        return Point(coords[0], coords[1]);
      }).toList();
      if (pathPoints.isNotEmpty) {
        await ref.read(gridProvider.notifier).highlightVisited(visitedPoints);
        await ref.read(gridProvider.notifier).highlightPath(pathPoints);
      }
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load BFS result');
    }
  }
}
