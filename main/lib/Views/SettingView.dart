import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/ViewModel/Provider.dart';
import 'package:main/Utilities/Themes.dart';
import 'package:main/Model/Coordinate.dart';

class SettingView_Container extends StatelessWidget {
  const SettingView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        padding: const EdgeInsets.all(5.0),
        decoration: ViewDecoration(),
        child: GridDisplay());
  }
}

class GridDisplay extends ConsumerWidget {
  const GridDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = ref.watch(errorMessageProvider);
    final visitedPoints = ref.watch(visitedPointsProvider);
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            errorMessage,
            style: mainTextStyle(),
          ),
          const SizedBox(height: 16),
          if (visitedPoints.isNotEmpty)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Number of columns in the grid
                  crossAxisSpacing: 1.0, // Space between columns
                  mainAxisSpacing: 1.0, // Space between rows
                  childAspectRatio:
                      5, // Aspect ratio of the tiles (width / height)
                ),
                itemCount: visitedPoints.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(43, 224, 224, 224),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Tile: (x: ${visitedPoints[index].x}, y: ${visitedPoints[index].y})',
                        style: gridTextStyle(),
                      ),
                    ),
                  );
                },
              ),

              // child: ListView.builder(
              //     itemCount: visitedPoints.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 4.0),
              //           child: Text(
              //             'Tile: (x: ${visitedPoints[index].x}, y: ${visitedPoints[index].y})',
              //             style: gridTextStyle(),
              //           ));
              //     }),
            )
          // ...gridState.gridColors
          //     .map((row) => Text(row.join(' '), style: GridTextStyle())),
        ],
      ),
    );
  }
}
