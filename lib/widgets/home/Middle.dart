import 'package:flutter/material.dart';
import '1Head.dart' as Head;
import '2NamePlace.dart' as NamePlace;
import '3Cal_Test.dart' as Cal_Test;
import '4List.dart' as Middle_Cal;






class Middle extends StatelessWidget {
  Middle({super.key,this.app_name, this.user_uni_name,this.user_dep_name,this.user_name,this.user_speed});
 final app_name;
 final user_uni_name;
 final user_dep_name;
 final user_name;
 final user_speed;
  @override

  Widget build(BuildContext context) {
    var now = DateTime.now();

    return Expanded(
        child: ListView(
          children: [
            Head.Head(app_name: app_name,user_uni_name:user_uni_name, user_dep_name:user_dep_name),
            NamePlace.NamePlace(user_name: user_name,user_speed:user_speed),
            Cal_Test.TableCalendarScreen(),
            Middle_Cal.Middle(),

          ],
        ),

    );
  }
}



