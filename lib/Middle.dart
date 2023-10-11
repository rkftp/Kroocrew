import 'package:flutter/material.dart';
import 'Middle_Cal.dart' as Middle_Cal;
import 'Middle_Top.dart' as Middle_Top;

class Middle extends StatelessWidget {
  Middle({super.key});



  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
          children: [
            Middle_Top.Top_Bar(),
            Middle_Top.Mid_Bar(),
            Middle_Top.Day_name(),
            Middle_Top.Day_num(),
            Middle_Cal.Middle(),

          ],
        ),

    );
  }
}






class day_icon extends StatelessWidget {
  day_icon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

