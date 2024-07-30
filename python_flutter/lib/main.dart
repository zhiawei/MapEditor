import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter & Python Integration')),
        body: PlotWidget(),
      ),
    );
  }
}

class PlotWidget extends StatefulWidget {
  const PlotWidget({super.key});

  @override
  _PlotWidgetState createState() => _PlotWidgetState();
}

class _PlotWidgetState extends State<PlotWidget> {
  late Future<Uint8List> _plotImage;

  @override
  void initState() {
    super.initState();
    _plotImage = fetchPlotImage();
  }

  Future<Uint8List> fetchPlotImage() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/plot'));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load plot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Uint8List>(
        future: _plotImage,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Image.memory(snapshot.data!);
          }
        },
      ),
    );
  }
}
