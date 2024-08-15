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
        padding: const EdgeInsets.all(0.0),
        decoration: ViewDecoration(),
        child: Sidebar());
  }
}

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridNotifier = ref.read(gridProvider.notifier);
    // final rowCount = ref.watch(rowCountProvider.state).state;
    final colCount = ref.watch(colCountProvider);
    final isChecked = ref.watch(visibleGridTextProvider);

    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorOptionButton(
              color: startColor,
              onTap: () =>
                  ref.read(selectedColorProvider.notifier).state = startColor),
          ColorOptionButton(
              color: wallColor,
              onTap: () =>
                  ref.read(selectedColorProvider.notifier).state = wallColor),
          ColorOptionButton(
              color: goalColor,
              onTap: () =>
                  ref.read(selectedColorProvider.notifier).state = goalColor),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                gridNotifier.resetGrid(colCount);
              },
              child: const Text('Reset Grid')),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    ref.read(visibleGridTextProvider.notifier).state = value!;
                  }),
              Text('Visible GridText', style: mainTextStyle())
            ],
          )
        ],
      ),
    );
  }
}

class ColorOptionButton extends ConsumerWidget {
  final Color color;
  final VoidCallback onTap;

  const ColorOptionButton(
      {super.key, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(selectedColorProvider);
    final isSelected = selectedColor == color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: color,
            border: isSelected
                ? Border.all(color: highlightBorderColor, width: 2)
                : null),
      ),
    );
  }
}
