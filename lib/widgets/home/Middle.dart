import 'package:flutter/material.dart';
import 'Middle_Cal.dart' as Middle_Cal;
import 'Middle_Top.dart' as Middle_Top;
import 'Cal_Test.dart' as Cal_Test;

class Middle extends StatelessWidget {
  Middle({super.key});

  @override

  Widget build(BuildContext context) {
    var now = DateTime.now();

    return Expanded(
        child: ListView(
          children: [
            Middle_Top.Top_Bar(),
            Cal_Test.TableCalendarScreen(),

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

