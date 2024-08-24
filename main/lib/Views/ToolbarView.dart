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
        height: 75,
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
    final selectedMazeAlgorithm = ref.watch(selectedMazeAlgorithmProvider);
    final highlightSpeed = ref.watch(highlightSpeedProvider);
    final List<String> algorithms = ['BFS', 'DFS', 'A*'];
    final List<String> algorithmsMaze = ['DFS', 'Prim'];
    String? algorithm;
    final gridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);
    final TextEditingController speedController =
        TextEditingController(text: highlightSpeed.toString());

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: selectedAlgorithm,
            hint: Text('Select an algorithm', style: mainTextStyle()),
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
                    style: mainTextStyle(),
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
          DropdownButton<String>(
            value: selectedMazeAlgorithm,
            hint: Text('Select a maze generator', style: mainTextStyle()),
            onChanged: (String? newValue) {
              if (newValue != null) {
                ref.read(selectedMazeAlgorithmProvider.notifier).state =
                    newValue;
              }
            },
            items: algorithmsMaze.map((String algorithm) {
              return DropdownMenuItem<String>(
                  value: algorithm,
                  child: Text(
                    algorithm,
                    style: mainTextStyle(),
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
                gridNotifier.resetPath(gridState.gridColors);
                AlgorithmHandler(ref, algorithm).perform();
              },
              child: const Text('Run Algorithm')),
          const SizedBox(width: 16),
          ElevatedButton(
              onPressed: () {
                gridNotifier.generateMaze(selectedMazeAlgorithm);
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
              child: const Text('Send API')),
          const SizedBox(width: 16),
          // New input field for highlight speed
          Container(
            width: 100,
            child: TextField(
              controller: speedController,
              decoration: InputDecoration(
                labelText: 'Speed (ms)',
                labelStyle: speedControllerTextStyle(),
                border: speedControllerBorder(),
                focusedBorder: speedControllerFocusedBorder(),
                enabledBorder: speedControllerEnabledBorder(),
                fillColor: mainLayoutColor, // Change background fill color
                filled: true, // Enable background fill color
              ),
              style: speedControllerTextStyle(),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                int? speed = int.tryParse(value);
                if (speed != null && speed > 0) {
                  ref.read(highlightSpeedProvider.notifier).state = speed;
                } else {
                  // Reset to previous valid value if input is invalid
                  speedController.text = highlightSpeed.toString();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
