import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Grid with Sidebar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GridViewContainer(),
    );
  }
}

class GridViewContainer extends StatefulWidget {
  @override
  _GridViewContainerState createState() => _GridViewContainerState();
}

class _GridViewContainerState extends State<GridViewContainer> {
  final int _crossAxisCount = 50;
  final int _itemCount = 1550;
  late List<Color> _cellColors;
  Color _selectedColor = Colors.green;

  @override
  void initState() {
    super.initState();
    _cellColors = List<Color>.filled(_itemCount, Colors.black, growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Sidebar with color selection
          Container(
            width: 100,
            color: Colors.grey[800],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorBlock(
                  color: Colors.green,
                  isSelected: _selectedColor == Colors.green,
                  onTap: () {
                    setState(() {
                      _selectedColor = Colors.green;
                    });
                  },
                ),
                ColorBlock(
                  color: Colors.blue,
                  isSelected: _selectedColor == Colors.blue,
                  onTap: () {
                    setState(() {
                      _selectedColor = Colors.blue;
                    });
                  },
                ),
                ColorBlock(
                  color: Colors.red,
                  isSelected: _selectedColor == Colors.red,
                  onTap: () {
                    setState(() {
                      _selectedColor = Colors.red;
                    });
                  },
                ),
              ],
            ),
          ),
          // Grid view
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _cellColors[index] = _selectedColor;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _cellColors[index],
                        border: Border.all(
                          color: Color.fromARGB(82, 94, 165, 115),
                          width: 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorBlock extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  ColorBlock(
      {required this.color, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
      ),
    );
  }
}
