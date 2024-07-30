import 'package:flutter/material.dart';
import 'themes.dart';

class MenuView_Container extends StatelessWidget {
  const MenuView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: custonmDeco(),
      child: const Center(
        child: Text(
          'MenuView',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class TileView_Container extends StatelessWidget {
  const TileView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(5.0),
      decoration: custonmDeco(),
      child: const Center(
        child: Text(
          'TileView',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class GridView_Container extends StatelessWidget {
  const GridView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: custonmDeco(),
      child: const Center(
        child: Text(
          'GridView',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SettingView_Container extends StatelessWidget {
  const SettingView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(5.0),
      decoration: custonmDeco(),
      child: const Center(
        child: Text(
          'SettingView',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ToolbarView_Container extends StatelessWidget {
  const ToolbarView_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(5.0),
      decoration: custonmDeco(),
      child: const Center(
        child: Text(
          'ToolbarView',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
