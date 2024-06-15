import 'package:flutter/material.dart';

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
        // Scaffold provides a basic structure for the screen
        // Currently, it's empty, which means the screen will be blank
        );
  }
}
