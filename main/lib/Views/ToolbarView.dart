import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Model/AlgorithmHandler.dart';
import 'package:main/ViewModel/Provider.dart';
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
    final GridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                algorithm = 'BFS';
                gridNotifier.resetPath(GridState.gridColors);
                AlgorithmHandler(ref, algorithm).perform();
              },
              child: Text('Run BFS')),
          SizedBox(width: 16),
          ElevatedButton(
              onPressed: () {
                algorithm = 'DFS';
                gridNotifier.resetPath(GridState.gridColors);
                AlgorithmHandler(ref, algorithm).perform();
              },
              child: Text('Run DFS')),
          // SizedBox(width: 16),
          // ElevatedButton(
          //     onPressed: () {
          //       algorithm = 'BFS';
          //       gridNotifier.resetPath(GridState.gridColors);
          //       AlgorithmHandler(ref, algorithm).Start();
          //     },
          //     child: Text('Run DFS')),
          // SizedBox(width: 16),
          // ElevatedButton(
          //     onPressed: () {
          //       algorithm = 'BFS';
          //       gridNotifier.resetPath(GridState.gridColors);
          //       AlgorithmHandler(ref, algorithm).perform();
          //     },
          //     child: Text('Run DFS')),
        ],
      ),
    );
  }
}
