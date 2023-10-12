import 'package:flutter/material.dart';

class BottomNavigate extends StatelessWidget {
  const BottomNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xff473CCE),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: '시간표',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.widgets),
          label: '프로젝트',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          label: '톡',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '내정보',
        ),
      ],
    );
  }
}