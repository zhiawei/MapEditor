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
      body: Container(
          width: 500,
          height: 500,
          padding: EdgeInsets.all(16),
          child: Grid_View()),
    );
  }
}

class Grid_View extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GridState = ref.watch(gridProvider);
    final gridNotifier = ref.read(gridProvider.notifier);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, childAspectRatio: 1),
      itemCount: 10 * 10,
      itemBuilder: (context, index) {
        int row = index ~/ 10;
        int col = index % 10;
        Color tileColor = GridState.gridColors[row][col];
        return GestureDetector(
          onTap: () {
            gridNotifier.setColor(row, col, Colors.red);
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
