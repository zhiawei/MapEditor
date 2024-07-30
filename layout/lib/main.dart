import 'package:flutter/material.dart';
import 'utilities/layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapEditor Layout',
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
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          MenuView_Container(),
          Expanded(
            child: Row(
              children: [
                TileView_Container(),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: GridView_Container()),
                            SettingView_Container()
                          ],
                        ),
                      ),
                      ToolbarView_Container()
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
