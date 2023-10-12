import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Bottom_Navigate.dart' as Bottom;
import 'Top.dart' as Top;
import 'Middle.dart' as Middle;


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Top.Top(),
          Middle.Middle(),
        ],
      ),
      bottomNavigationBar: Bottom.BottomNavigate(),
    );
  }
}