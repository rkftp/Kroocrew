import 'package:flutter/material.dart';

import 'Top.dart' as Top;
import 'Middle.dart' as Middle;
import 'Bottom.dart' as Bottom;

void main() {
  runApp(
      MaterialApp(
          home : MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
          Top.Top(),
          Middle.Middle(),
        ]
      ),
      bottomNavigationBar: Bottom.Bottom(),
    );
  }
}



