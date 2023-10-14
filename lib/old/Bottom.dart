
import 'package:flutter/material.dart';


class Bottom extends StatelessWidget {
  Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Container(

          height: 60,
          width: double.maxFinite,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: BoxDecoration(
              color: Color(0xffD9D9D9).withOpacity(0.13),
              border: Border.all(color: Color(0xff707070), width: 1)),
          child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Home_button(),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
                ElevatedButton(
                  child: TimeTable_button(),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
                ElevatedButton(
                  child: Project_button(),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
                ElevatedButton(
                  child: Chat_button(),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
                ElevatedButton(
                  child: MyPage_button(),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ]
          ),
        )
    );
  }
}

class Home_button extends StatelessWidget {
  Home_button({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
            children: [
              Icon(Icons.home, color:Color(0xff473CCE)),
              Text('홈', style: TextStyle(color: Color(0xffADA8F0)),),
            ]
        )
    );

  }
}

class TimeTable_button extends StatelessWidget {
  TimeTable_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.calendar_today, color:Color(0xff000000)),
          Text('시간표', style: TextStyle(color: Color(0xff707070)),),
        ]
      )
    );
  }
}

class Project_button extends StatelessWidget {
  Project_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: [
              Icon(Icons.widgets,color:Color(0xff000000)),
              Text('프로젝트',style: TextStyle(color: Color(0xff707070)),),
            ]
        )
    );
  }
}

class Chat_button extends StatelessWidget {
  Chat_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: [
              Icon(Icons.question_answer,color:Color(0xff000000)),
              Text('채팅',style: TextStyle(color: Color(0xff707070)),),
            ]
        )
    );
  }
}

class MyPage_button extends StatelessWidget {
  MyPage_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: [
              Icon(Icons.person,color:Color(0xff000000)),
              Text('My',style: TextStyle(color: Color(0xff707070)),),
            ]
        )
    );
  }
}
