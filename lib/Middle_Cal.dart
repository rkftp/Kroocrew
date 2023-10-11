import 'package:flutter/material.dart';

class Middle extends StatelessWidget {
  Middle({super.key});
  final a1 = "2주차 일정";
  final b1 = [['10/9(월)', '한글날', '캡스톤디자인(1)', 'Orange'],
    ['10/13(금)', '멘토링 보고서 2차', '캡스톤디자인(1)', 'Orange'],
    ['10/14(토)', '최종발표', '컴퓨터그래픽스', '개인']];

  final a2 = '9월달 일정';
  final b2 = [['10월 29일(일)', '과제마감', '리눅스 시스템 응용 설계', '개인']];

  final a3 = '전체 일정';
  final b3 = [['','','',''],['','','','']];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Subject_Box( state : a1 ),
            Context_Box_W( state : b1 ),
            Subject_Box(state: a2),
            Context_Box_M( state : b2 ),
            Subject_Box(state: a3),
            Context_Box_A( state : b3 ),
          ],
      )
    );
  }
}

class Subject_Box extends StatelessWidget {
  Subject_Box({super.key, this.state});
  final state;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      height: 34,
      width: 120,
      decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(50),
      ),
      child: Row(

        children: [
            Icon(Icons.arrow_drop_down, size: 25),
            Text(state,style: TextStyle(
                color: Color(0xff473CCE),
                fontSize: 14,
                fontWeight: FontWeight.bold
            ),),
        ],
      ),
    );
  }
}
class Context_Box_W extends StatelessWidget {
  Context_Box_W({super.key, this.state});
  final state;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: 174,
        width: 500,

        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff473cce), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Con_today(state:state[0]),
            Con(state:state[1]),
            Con(state:state[2]),

          ],
        )
    );
  }
}

class Context_Box_M extends StatelessWidget {
  Context_Box_M({super.key, this.state});
  final state;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: 74,
        width: 500,

        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff473cce), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Con(state:state[0]),

          ],
        )
    );
  }
}
class Context_Box_A extends StatelessWidget {
  Context_Box_A({super.key, this.state});
  final state;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: 124,
        width: 500,

        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff473cce), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Con(state:state[0]),
            Con(state:state[1]),

          ],
        )
    );
  }
}

class Con_today extends StatelessWidget {
  Con_today({super.key,this.state});
  final state;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(child:Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Icon(Icons.star,size: 15,color: Color(0xff473cce))
          ),
              flex : 1),
          Flexible(child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state[0],style:TextStyle(
                      color: Color(0xff473cce),
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )),
                    Text(state[1],style:TextStyle(
                        color: Color(0xff473cce),
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state[2],style:TextStyle(
                          color: Color(0xff473cce),
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      )),
                      Text(state[3],style:TextStyle(
                          color: Color(0xff473cce),
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      )),
                    ]
                )
              ]
          ) ,
              flex: 10),
        ],
      )
    );
  }
}
class Con extends StatelessWidget {
  Con({super.key, this.state});

  final state;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            Flexible(child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Icon(Icons.star, size: 15, color: Color(0xff000000))
            ),
                flex: 1),
            Flexible(child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state[0], style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                      )),
                      Text(state[1], style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                      )),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state[2], style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 14,
                        )),
                        Text(state[3], style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 14,
                        )),
                      ]
                  )
                ]
            ),
                flex: 10),
          ],
        )
    );
  }
}
