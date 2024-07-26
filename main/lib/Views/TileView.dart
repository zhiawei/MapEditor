import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';

import 'package:main/Utilities/Themes.dart';

class TileView_Container extends StatelessWidget {
  const TileView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        padding: EdgeInsets.all(0.0),
        decoration: ViewDecoration(),
        child: Sidebar());
  }
}

class Sidebar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridNotifier = ref.read(gridProvider.notifier);

    return Container(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorOptionButton(
              color: Colors.red,
              onTap: () =>
                  ref.read(selectedColorProvider.notifier).state = Colors.red),
          // ColorOptionButton(
          //     color: Colors.blue,
          //     onTap: () =>
          //         ref.read(selectedColorProvider.notifier).state = Colors.blue),
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
