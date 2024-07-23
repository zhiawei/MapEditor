import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/Utilities/Themes.dart';
import 'package:main/ViewModel/Provider.dart';

class MenuView_Container extends StatelessWidget {
  const MenuView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        decoration: ViewDecoration(),
        child: Menu_View());
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
            icon: Icon(Icons.save),
            onPressed: () async {
              await ref.read(gridProvider.notifier).saveToFile();
            },
          ),
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () async {
              await ref.read(gridProvider.notifier).loadFromFile();
            },
          ),
        ],
      ),
    );
  }
}
