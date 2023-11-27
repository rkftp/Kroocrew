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


  var user_speed = '100';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: BottomNavController.to.selectedIndex.value,
          children: [
            _home.Middle(app_name:app_name,user_uni_name : user_uni_name, user_speed:user_speed),//home
            Timetables(),
            Projects(),//projects
            Chat(),
            Myinfo(loginDacc:loginDacc,user_uni_name:user_uni_name,user_speed: user_speed,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigate(),
    );
  }
}

