import 'package:flutter/material.dart';

import 'Top_timetable.dart' as Top;
import '../widgets/home/Middle.dart' as Middle;
import 'Bottom.dart' as Bottom;

void main() {
  runApp(
      MaterialApp(
          home :Timetable()
      )
  );
}

class Timetable extends StatelessWidget {
  Timetable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Top.Top(),
        ],
      ),
      bottomNavigationBar: Bottom.Bottom(),
    );
  }
}



