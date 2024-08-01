import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Model/AlgorithmHandler.dart';
import 'package:main/ViewModel/Provider.dart';
import 'package:main/Utilities/Themes.dart';
import 'package:main/Model/Messenger.dart';

class ToolbarView_Container extends StatelessWidget {
  const ToolbarView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: const EdgeInsets.all(5.0),
        decoration: ViewDecoration(),
        child: Toolbar_View());
  }
}

class Toolbar_View extends ConsumerWidget {
  const Toolbar_View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAlgorithm = ref.watch(selectedAlgorithmProvider);
    final List<String> algorithms = ['BFS', 'DFS'];
    String? algorithm;
    final gridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: selectedAlgorithm,
            hint: Text('Select an algorithm', style: MainTextStyle()),
            onChanged: (String? newValue) {
              if (newValue != null) {
                ref.read(selectedAlgorithmProvider.notifier).state = newValue;
              }
            },
            items: algorithms.map((String algorithm) {
              return DropdownMenuItem<String>(
                  value: algorithm,
                  child: Text(
                    algorithm,
                    style: MainTextStyle(),
                  ));
            }).toList(),
            dropdownColor: Colors.blueAccent,
            underline: Container(
              height: 2,
              color: Colors.transparent, // Hide the default underline
            ),
            iconEnabledColor: Colors.blue,
          ),
          const SizedBox(width: 16),
          ElevatedButton(
              onPressed: () {
                algorithm = selectedAlgorithm;
                // gridNotifier.resetPath(gridState.gridColors);
                AlgorithmHandler(ref, algorithm).perform();
              },
              child: const Text('Run Algorithm')),
          const SizedBox(width: 16),
          ElevatedButton(
              onPressed: () {
                gridNotifier.generateMaze();
              },
              child: const Text('Generate Maze')),
          const SizedBox(width: 16),
          ElevatedButton(
              onPressed: () async {
                try {
                  gridNotifier.resetPath(gridState.gridColors);
                  await API_Messenger(ref).fetchBFSResult();
                  // Handle the message as needed
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: const Text('Send')),
        ],
      ),
    );
  }
}
