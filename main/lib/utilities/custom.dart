import 'package:flutter/material.dart';
import 'themes.dart';

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

class TileView_container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: custonmDeco(),
      child: Center(
        child: Text('Tile View', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class GridView_container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color of the screen
      body: Padding(
        padding: EdgeInsets.all(2.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 50, // Number of columns in the grid
              crossAxisSpacing: 1.0, // Horizontal space between cells
              mainAxisSpacing: 1.0, // Vertical space between cells
            ),
            itemCount: 1550, // Number of cells in the grid
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  border: Border.all(
                    color: Color.fromARGB(82, 94, 165, 115),
                    width: 1,
                  ),
                ),
              );
            }),
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
