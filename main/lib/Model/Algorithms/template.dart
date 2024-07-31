// class Grid_View extends ConsumerWidget {
//   const Grid_View({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final GridState = ref.watch(gridProvider);
//     final gridNotifier = ref.read(gridProvider.notifier);
//     final selectedColor = ref.watch(selectedColorProvider);
//     final ColorMapping = ref.read(colorMappingProvider);

//     double _rowCount = 10;
//     double _colCount = 10;

//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//               child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: _colCount.toInt()),
//                   itemCount: (_rowCount * _colCount).toInt(),
//                   itemBuilder: (context, index) {
//                     int row = index ~/ _colCount.toInt();
//                     int col = index % _colCount.toInt();
//                     String tileColorCode = GridState.gridColors[row][col];
//                     Color tileColor =
//                         ColorMapping.alphabetToColor[tileColorCode]!;
//                     return GestureDetector(
//                         onTap: () {
//                           final selectedColorCode =
//                               ColorMapping.colorToAlphabets[selectedColor]!;
//                           gridNotifier.setColor(row, col, selectedColorCode);
//                         },
//                         onSecondaryTap: () {
//                           gridNotifier.setColor(row, col, 'W');
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.all(1),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               color: tileColor),
//                         ));
//                   })),
//           Positioned(
//               bottom: 300,
//               child: Row(
//                 children: [
//                   Container(
//                     width: 50,
//                     height: 50,
//                     color: Colors.amber,
//                   )
//                 ],
//               ))
//           Positioned(
//               bottom: 500,
//               child: Row(
//                 children: [
//                   Expanded(
//                       child: Slider(
//                           value: _colCount,
//                           min: 10,
//                           max: 50,
//                           divisions: 40,
//                           label: 'Columns: ${_colCount.toInt()}',
//                           onChanged: (value) {
//                             _colCount = value;
//                             ref.refresh(gridProvider);
//                           }))
//                 ],
//               )),
//           Positioned(
//               right: 20,
//               child: RotatedBox(
//                 quarterTurns: 3,
//                 child: Slider(
//                     value: _rowCount,
//                     min: 10,
//                     max: 50,
//                     divisions: 40,
//                     label: 'Columns: ${_rowCount.toInt()}',
//                     onChanged: (value) {
//                       _colCount = value;
//                       ref.refresh(gridProvider);
//                     }),
//               ))
//         ],
//       ),
//     );
//   }
// }
