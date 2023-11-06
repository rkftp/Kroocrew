import 'package:flutter/material.dart';
import '1Head.dart' as Head;
import '2NamePlace.dart' as NamePlace;
import '3Cal_Test.dart' as Cal_Test;
import '4List.dart' as Middle_Cal;



var app_name = 'Kroocrew';
var user_uni_name = "중앙대";
var user_dep_name = "소프트웨어 학과 소프트웨어 학부";

var user_name = '한진우';
var user_speed = '100';


class Middle extends StatelessWidget {
  Middle({super.key});

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



