import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';
import 'package:main/Utilities/Themes.dart';

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
    final width = ref.watch(widthGridProvider.state).state;
    final height = ref.watch(heightGridProvider.state).state;
    // final rowCount = ref.watch(rowCountProvider.state).state;
    final colCount = ref.watch(colCountProvider.state).state;
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
                    label: 'Columns: ${colCount}',
                    onChanged: (value) {
                      ref.read(colCountProvider.state).state = value.toInt();
                    }),
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 300,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          ref.read(widthGridProvider.state).state += 100;
                          ref.read(heightGridProvider.state).state += 100;
                        },
                        child: const Text('+')),
                    const SizedBox(width: 16),
                    ElevatedButton(
                        onPressed: () {
                          ref.read(widthGridProvider.state).state -= 100;
                          ref.read(heightGridProvider.state).state -= 100;
                        },
                        child: const Text('-')),
                  ],
                ),
              )),
          // Align(
          //     alignment: Alignment.centerRight,
          //     child: RotatedBox(
          //       quarterTurns: 3,
          //       child: Container(
          //         height: 50,
          //         width: 300,
          //         child: Slider(
          //             value: rowCount.toDouble(),
          //             min: 10,
          //             max: 50,
          //             divisions: 4,
          //             label: 'Rows: ${rowCount}',
          //             onChanged: (value) {
          //               ref.read(rowCountProvider.state).state = value.toInt();
          //             }),
          //       ),
          //     )),
        ],
      ),
    );
  }
}

class Grid_View extends ConsumerWidget {
  const Grid_View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);
    final selectedColor = ref.watch(selectedColorProvider);
    final ColorMapping = ref.read(colorMappingProvider);
    // final rowCount = ref.watch(rowCountProvider.state).state;
    final colCount = ref.watch(colCountProvider.state).state;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: colCount, childAspectRatio: 1),
      itemCount: colCount * colCount,
      itemBuilder: (context, index) {
        int row = index ~/ colCount;
        int col = index % colCount;
        String tileColorCode = GridState.gridColors[row][col];
        Color tileColor = ColorMapping.alphabetToColor[tileColorCode]!;
        return GestureDetector(
          onTap: () {
            final selectedColorCode =
                ColorMapping.colorToAlphabets[selectedColor]!;
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
