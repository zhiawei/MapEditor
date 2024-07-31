import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';
import 'package:main/Utilities/Themes.dart';

class SettingView_Container extends StatelessWidget {
  const SettingView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        padding: const EdgeInsets.all(5.0),
        decoration: ViewDecoration(),
        child: GridDisplay());
  }
}

class GridDisplay extends ConsumerWidget {
  const GridDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridState = ref.watch(gridProvider);

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Grid State:', style: GridTextStyle()),
          ...gridState.gridColors
              .map((row) => Text(row.join(' '), style: GridTextStyle())),
        ],
      ),
    );
  }
}
