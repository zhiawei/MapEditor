import 'package:flutter/material.dart';
import 'package:main/Utilities/Themes.dart';
import 'package:main/Views/MenuView.dart';
import 'package:main/Views/TileView.dart';
import 'package:main/Views/GridView.dart';
import 'package:main/Views/ToolbarView.dart';
import 'package:main/Views/SettingView.dart';

class Layout_Scaffold extends StatefulWidget {
  const Layout_Scaffold({super.key});

  @override
  State<Layout_Scaffold> createState() => _Layout_ScaffoldState();
}

class _Layout_ScaffoldState extends State<Layout_Scaffold> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: MainBackgroundColor,
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
                    )),
                    ToolbarView_Container()
                  ],
                ))
              ],
            ))
          ],
        ));
  }
}
