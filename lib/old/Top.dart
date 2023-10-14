import 'package:flutter/material.dart';


class Top extends StatelessWidget {
  Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Title(),
          University(),
          Department(),
        ],
      )
    );
  }
}

class Title extends StatelessWidget {
  Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
        child: Text("제목을 입력하세요",
          style:TextStyle(
              color: Color(0xff000000),
              fontSize: 32,
              fontWeight: FontWeight.bold
          ),
        )
    );
  }
}
class University extends StatelessWidget {
  University({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text("중앙대",
          style:TextStyle(
              color: Color(0xff473CCE),
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        )
    );
  }
}
class Department extends StatelessWidget {
  Department({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text("소프트웨어 학부 소프트웨어 학과",
          style:TextStyle(
              color: Color(0xff000000),
              fontSize: 13,
              fontWeight: FontWeight.bold
          ),
        )
    );
  }
}
