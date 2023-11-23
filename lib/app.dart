import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/Bottom_Navigate.dart';
import 'screens/home/home_main.dart' as _home;
import 'screens/timetables/Timetables.dart';
import 'screens/projects/Projects.dart';
import 'screens/chat/Chat.dart';
import 'screens/myinfo/Myinfo.dart';

class App extends StatelessWidget {

  App({super.key,this.loginDacc});

  final loginDacc;
  var app_name = 'Kroocrew';
  var user_uni_name = "중앙대";
  var user_dep_name = "소프트웨어 학과 소프트웨어 학부";
  var user_name = '한진우';
  var user_speed = '100';
  var user_num = '20213949';
  var user_id = 'idididid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: BottomNavController.to.selectedIndex.value,
          children: [
            _home.Middle(app_name:app_name,user_uni_name : user_uni_name, user_dep_name:user_dep_name,user_name:user_name,user_speed:user_speed),//home
            Timetables(),
            Projects(),//projects
            Chat(),
            Myinfo(loginDacc:loginDacc,user_name:user_name,user_uni_name:user_uni_name,user_dep_name:user_dep_name,user_num:user_num,user_speed: user_speed,user_id:user_id),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigate(),
    );
  }
}

