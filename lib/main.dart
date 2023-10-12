import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'Top.dart' as Top;
import 'Middle.dart' as Middle;
import 'Bottom.dart' as Bottom;
import 'app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kroocrew',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: App(),
    );
  }
}



