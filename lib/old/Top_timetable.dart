import 'package:contact/widgets/home/3.List.dart';
import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 30, 30, 0),
        width: double.infinity,

        child:Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: semester(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: table_name(),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                  children: [
                    Expanded(child: Container(
                      child: Text("※팀플 게시판이 개설되지 않았다면?",style:TextStyle(
                          color: Color(0xff707070),
                          fontSize: 14,
                      ))
                    ),flex:13),
                    Expanded(child: Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
                        padding: EdgeInsets.fromLTRB(13, 4, 10, 0),
                        height: 29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xff473cce),
                        border: Border.all(color: Colors.black12, width: 0),
                      ),
                      child: Text("●개설 신청하기",style:TextStyle(

                          color: Color(0xffffffff),
                          fontSize: 11,
                          fontWeight: FontWeight.bold
                      ))

                    ),flex:7),
                  ],
                )
              ),
            ],
          )
    );
  }
}

class semester extends StatelessWidget {
  semester({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(


      height: 15,
      width: 90,
      child: Text('2023년 2학기',style: TextStyle(
          color: Color(0xff473cce),
          fontSize: 12,
          fontWeight: FontWeight.bold
      ),)
    );
  }
}

class table_name extends StatelessWidget {
  table_name({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:Container(
              child: Text('시간표1',style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),),
            ), flex: 7,),
            Expanded(child:Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      Icon(Icons.bug_report),
                      Icon(Icons.settings),
                      Icon(Icons.format_list_bulleted),
                    ]
                )
            ),flex: 3),
          ],
        )
    );
  }
}

