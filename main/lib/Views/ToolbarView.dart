import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Model/AlgorithmHandler.dart';
import 'package:main/Utilities/Themes.dart';

class ToolbarView_Container extends StatelessWidget {
  const ToolbarView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: EdgeInsets.all(5.0),
        decoration: ViewDecoration(),
        child: Toolbar_View());
  }
}

class Toolbar_View extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var algorithm = null;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                algorithm = 'BFS';
                AlgorithmHandler(ref).perform(algorithm);
              },
              child: Text('Run BFS')),
          SizedBox(width: 16),
          ElevatedButton(
              onPressed: () {
                algorithm = 'DFS';
                AlgorithmHandler(ref).perform(algorithm);
              },
              child: Text('Run DFS'))
        ],
      ),
    );
  }
}
