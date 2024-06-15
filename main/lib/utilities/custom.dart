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
    return Container(
      decoration: custonmDeco(),
      child: Center(
        child: Text('Grid View', style: TextStyle(color: Colors.white)),
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
      height: 200,
      decoration: custonmDeco(),
      child: Center(
        child: Text('Edit View', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
