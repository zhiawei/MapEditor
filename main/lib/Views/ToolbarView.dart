import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Model/AlgorithmHandler.dart';
import 'package:main/ViewModel/Provider.dart';
import 'package:main/Utilities/Themes.dart';
import 'package:main/Model/messenger.dart';

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
    String message;
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
          SizedBox(width: 16),
          ElevatedButton(
              onPressed: () async {
                try {
                  gridNotifier.resetPath(GridState.gridColors);
                  final message = await API_Messenger(ref).fetchBFSResult();
                  print(message);
                  // Handle the message as needed
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: Text('Send')),
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
