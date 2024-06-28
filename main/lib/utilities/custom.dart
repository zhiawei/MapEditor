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

class GridView_container extends StatefulWidget {
  @override
  State<GridView_container> createState() => _GridView_container();
}

class _GridView_container extends State<GridView_container> {
  Offset _offset = Offset.zero;
  Offset _startPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
            onPanStart: (details) {
              setState(() {
                _startPosition = details.localPosition;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                _offset += details.localPosition - _startPosition;
                _startPosition = details.localPosition;
              });
            },
            child: CustomPaint(
                painter: GridPainter(_offset), child: Container())));
  }
}

class GridPainter extends CustomPainter {
  final Offset offset;

  GridPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(82, 94, 165, 115)
      ..strokeWidth = 1;

    double cellSize = 30;

    for (double x = offset.dx % cellSize; x < size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = offset.dy % cellSize; y < size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
