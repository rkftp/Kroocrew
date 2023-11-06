import 'package:flutter/material.dart';

class Middle extends StatelessWidget {
  Middle({super.key});


  var count_w = 3;
  var count_m = 1;
  var count_all = 0;
  bool week_box = true;
  bool month_box = true;
  bool all_box = true;



  final week = "이번주 일정";
  final month = '이번달 일정';
  final all = '전체 일정';

  final b1 = [['10/9(월)', '한글날', '캡스톤디자인(1)', 'Orange'],
    ['10/13(금)', '멘토링 보고서 2차', '캡스톤디자인(1)', 'Orange'],
    ['10/14(토)', '최종발표', '컴퓨터그래픽스', '개인']];
  final b2 = [['10월 29일(일)', '과제마감', '리눅스 시스템 응용 설계', '개인']];
  final b3 = [['','','',''],['','','','']];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Subject_Box( state : week  ),
            Context_Box_W( state : b1, count_w: count_w ),
            Subject_Box(state: month,),
            Context_Box_M( state : b2,count_m: count_m),
            Subject_Box(state: all,),
            Context_Box_A( state : b3, count_all: count_all ),
          ],
      )
    );
  }
}

class Subject_Box extends StatefulWidget {
  final String state;

  Subject_Box({Key? key, required this.state,}) : super(key: key);

  @override
  State<Subject_Box> createState() => _Subject_BoxState();
}

class _Subject_BoxState extends State<Subject_Box> {

  bool isArrowUp = false;
  // 아이콘의 상태를 추적하는 변수

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: EdgeInsets.all(5),
      height: 34,
      width: 120,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Align children in the center of the row
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isArrowUp = !isArrowUp;
              });
            },
            child: Icon(
              isArrowUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 25,
              color: Color(0xff473CCE),
            ),
          ),
          SizedBox(width: 8), // Add some space between icon and text
          Text(
            widget.state,
            style: TextStyle(
              color: Color(0xff473CCE),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Context_Box_W extends StatelessWidget {
  Context_Box_W({super.key, this.state, this.count_w});
  final state;
  final count_w;
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: count_w*45+10,
        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff473cce), width: 2),
        ),
        child: ListView.builder(itemCount:count_w,itemBuilder: (c,i){
          return Con(state:state[i]);
        },)

    );


  }
}

class Context_Box_M extends StatelessWidget {
  Context_Box_M({super.key, this.state, this.count_m});
  final state;
  final count_m;
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: count_m*45+10,
        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff473cce), width: 2),
        ),
        child: ListView.builder(itemCount:count_m,itemBuilder: (c,i){
          return Con(state:state[i]);
        },)

    );
  }
}
class Context_Box_A extends StatelessWidget {
  Context_Box_A({super.key, this.state, this.count_all});
  final state;
  final count_all;
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: count_all*45+10,
        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff473cce), width: 2),
        ),
        child: ListView.builder(itemCount:count_all,itemBuilder: (c,i){
          return Con(state:state[i]);
        },)

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
