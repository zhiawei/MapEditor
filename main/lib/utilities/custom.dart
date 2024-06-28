import 'package:flutter/material.dart';
import 'themes.dart';

Color _selectedColor = Colors.green;

class toolbar_container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: custonmDeco(),
      child: Center(
        child: Text('Toolbar Menu', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class TileView_container extends StatefulWidget {
  const TileView_container({super.key});

  @override
  State<TileView_container> createState() => _TileView_container();
}

class _TileView_container extends State<TileView_container> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: custonmDeco(),
      child: Column(
        children: [
          ColorBlock(
              color: Colors.green,
              isSelected: _selectedColor == Colors.green,
              onTap: () {
                setState(() {
                  _selectedColor = Colors.green;
                });
              }),
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
    );
  }
}

class GridView_container extends StatefulWidget {
  @override
  State<GridView_container> createState() => _GridView_container();
}

class _GridView_container extends State<GridView_container> {
  // Number of columns and rows in the grid
  final int _crossAxisCount = 50;
  final int _itemCount = 1550;
  // List to track the color of each cell
  late List<Color> _cellColors;

  @override
  void initState() {
    super.initState();
    // Initialize the cell colors to black
    _cellColors = List<Color>.filled(_itemCount, Colors.black, growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color of the screen
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount, // Number of columns in the grid
            crossAxisSpacing: 0.5, // Horizontal space between cells
            mainAxisSpacing: 0.5, // Vertical space between cells
          ),
          itemCount: _itemCount, // Number of cells in the grid
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  // Change the color of the cell when it is tapped
                  _cellColors[index] = _selectedColor;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _cellColors[index], // Use the color from the list
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

class Settings_container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: custonmDeco(),
      child: Center(
        child: Text('Setting View', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class EditView_container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: custonmDeco(),
      child: Center(
        child: Text('Edit View', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
