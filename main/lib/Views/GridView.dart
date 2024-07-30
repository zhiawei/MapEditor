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
    return Scaffold(
        backgroundColor: MainBackgroundColor,
        body: Container(
            width: 500,
            height: 500,
            padding: const EdgeInsets.all(5.0),
            // decoration: ViewDecoration(),
            child: Grid_View()));
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
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, childAspectRatio: 1),
      itemCount: 10 * 10,
      itemBuilder: (context, index) {
        int row = index ~/ 10;
        int col = index % 10;
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
