import 'package:flutter/material.dart';
import 'utilities/custom.dart';

void main() {
  runApp(MyApp()); // The entry point of the app, runs MyApp widget
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'MapEditor', // Sets the title of the app
      home: HomeScreen(), // Sets HomeScreen as the main screen of the app
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(); // Creates the state for HomeScreen
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          toolbar_container(),
          Expanded(
            child: Row(
              children: [
                TileView_container(),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(children: [
                              Expanded(child: GridView_container())
                            ])),
                            Settings_container()
                          ],
                        ),
                      ),
                      EditView_container()
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
