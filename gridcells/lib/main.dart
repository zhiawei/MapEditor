import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridcells/utilities/provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapEditor GridCells',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
            width: 500,
            height: 500,
            padding: EdgeInsets.all(16),
            child: Grid_View()),
        Sidebar(),
        GridDisplay()
      ],
    ));
  }
}

class Grid_View extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);
    final selectedColor = ref.watch(selectedColorProvider);
    final ColorMapping = ref.read(colorMappingProvider);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, childAspectRatio: 1),
      itemCount: 10 * 10,
      itemBuilder: (context, index) {
        int row = index ~/ 10;
        int col = index % 10;
        Color tileColor =
            ColorMapping.alphabetToColor[GridState.gridColors[row][col]]!;
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
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), color: tileColor),
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
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorOptionButton(
              color: Colors.red,
              onTap: () =>
                  ref.read(selectedColorProvider.notifier).state = Colors.red),
          ColorOptionButton(
              color: Colors.blue,
              onTap: () =>
                  ref.read(selectedColorProvider.notifier).state = Colors.blue),
          ColorOptionButton(
              color: Colors.green,
              onTap: () => ref.read(selectedColorProvider.notifier).state =
                  Colors.green),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                gridNotifier.resetGrid();
              },
              child: Text('Reset Grid'))
        ],
      ),
    );
  }
}

class ColorOptionButton extends ConsumerWidget {
  final Color color;
  final VoidCallback onTap;

  ColorOptionButton({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(selectedColorProvider);
    final isSelected = selectedColor == color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: color,
            border: isSelected
                ? Border.all(
                    color: const Color.fromARGB(255, 0, 255, 242), width: 2)
                : null),
      ),
    );
  }
}

class GridDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridState = ref.watch(gridProvider);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Grid State:', style: TextStyle(fontWeight: FontWeight.bold)),
          ...gridState.gridColors.map((row) => Text(row.join(' '))).toList(),
        ],
      ),
    );
  }
}
