import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Utilities/Themes.dart';
import 'package:main/ViewModel/Provider.dart';

class GridView_Container extends StatefulWidget {
  const GridView_Container({super.key});

  @override
  State<GridView_Container> createState() => _GridView_ContainerState();
}

class _GridView_ContainerState extends State<GridView_Container> {
  @override
  Widget build(BuildContext context) {
    return GridView_Widget();
  }
}

class GridView_Widget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = ref.watch(widthGridProvider);
    final height = ref.watch(heightGridProvider);
    final colCount = ref.watch(colCountProvider);
    return Scaffold(
      backgroundColor: MainBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: width,
              height: height,
              child: Grid_View(),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: 300,
                child: Slider(
                    value: colCount.toDouble(),
                    min: 10,
                    max: 50,
                    divisions: 4,
                    label: 'Grid Size: $colCount',
                    onChanged: (value) {
                      ref.read(colCountProvider.notifier).state = value.toInt();
                    }),
              )),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 300,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            ref.read(widthGridProvider.notifier).state += 100;
                            ref.read(heightGridProvider.notifier).state += 100;
                          },
                          child: const Text('+')),
                      const SizedBox(width: 16),
                      ElevatedButton(
                          onPressed: () {
                            ref.read(widthGridProvider.notifier).state -= 100;
                            ref.read(heightGridProvider.notifier).state -= 100;
                          },
                          child: const Text('-')),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class Grid_View extends ConsumerWidget {
  const Grid_View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);
    final selectedColor = ref.watch(selectedColorProvider);
    final colorMapping = ref.read(colorMappingProvider);
    final colCount = ref.watch(colCountProvider.notifier).state;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: colCount, childAspectRatio: 1),
      itemCount: colCount * colCount,
      itemBuilder: (context, index) {
        int row = index ~/ colCount;
        int col = index % colCount;
        String tileColorCode = gridState.gridColors[row][col];
        Color tileColor = colorMapping.alphabetToColor[tileColorCode]!;
        return GestureDetector(
          onTap: () {
            final selectedColorCode =
                colorMapping.colorToAlphabets[selectedColor]!;
            gridNotifier.setColor(row, col, selectedColorCode);
          },
          onSecondaryTap: () {
            gridNotifier.setColor(row, col, 'W');
          },
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), color: tileColor),
          ),
        );
      },
    );
  }
}
