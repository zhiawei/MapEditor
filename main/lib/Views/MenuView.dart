import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Utilities/Themes.dart';
import 'package:main/ViewModel/Provider.dart';

class MenuView_Container extends StatelessWidget {
  const MenuView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        decoration: ViewDecoration(),
        child: const Menu_View());
  }
}

class Menu_View extends ConsumerWidget {
  const Menu_View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final gridState = ref.watch(gridProvider);
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              await ref.read(gridProvider.notifier).saveGridToFile();
            },
          ),
          IconButton(
            icon: const Icon(Icons.upload, color: Colors.white),
            onPressed: () async {
              await ref.read(gridProvider.notifier).loadGridFromFile();
            },
          ),
        ],
      ),
    );
  }
}
