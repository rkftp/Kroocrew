import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class Top_Bar extends StatelessWidget {
  Top_Bar({super.key});
  final my_name = '한진우';

  @override
  Widget build(BuildContext context) {
    return Row( //name
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        name(),
        speed(),
      ],
    );
  }
}
class Mid_Bar extends StatelessWidget {
  const Mid_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row( //callinder
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          week(),
          arrow(),
        ]
    );
  }
}
class Day_name extends StatelessWidget {
  const Day_name({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("월",style: TextStyle(
                color: Color(0xffff0000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("화",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("수",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("목",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("금",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("토",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("일",style: TextStyle(
                color: Color(0xffff0000),
                fontSize: 13))),
      ],
    );
  }
}
class Day_num extends StatelessWidget {
  const Day_num({super.key, this.now});
  final now;

  @override
  Widget build(BuildContext context) {

   DateTime firstTime = DateTime(now.year, now.month, now.day - (now.weekday - 1));
    var lastTime = DateTime(now.year, now.month, now.day + (7 - now.weekday));
    String first = DateFormat('d').format(firstTime);
    String second = (int.parse(first)+1).toString();
   String third = (int.parse(first)+2).toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
            decoration: BoxDecoration(
              color: Color(0xff473CCE),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Color(0xff473CCE), width: 1),
            ),
            child: Text(first,style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 12),
                textAlign: TextAlign.center,)),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text(second,style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12),
              textAlign: TextAlign.center,)),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(3, 2, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text(third,style: TextStyle(
                color: Color(0xff000000),
                fontSize: 12),
              textAlign: TextAlign.center,)),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(3, 2, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              //border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("12",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(3, 2, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("13",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(3, 2, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("14",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),
        Container(
            height: 23,
            width: 23,
            padding: EdgeInsets.fromLTRB(3, 2, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              // border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text("15",style: TextStyle(
                color: Color(0xff000000),
                fontSize: 13))),

      ],
    );
  }
}




class name extends StatelessWidget {
  name({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black12, width: 3),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20,0, 0,0),
              child: Text("한진우",style:TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              )),
            ),
          ],
        )
    );
  }
}
class speed extends StatelessWidget {
  speed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
        child: Row(
          children: [

            Container(

              child: Text('375km/h',style:TextStyle(
                  color: Color(0xff000000),
                  fontSize: 13,
                  fontWeight: FontWeight.bold
              )),
            ),
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.fromLTRB(20,0, 0,0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 3),
              ),
            ),
          ],
        )
    );
  }
}

class week extends StatelessWidget {
  week({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,

      margin: EdgeInsets.fromLTRB(25, 20, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text("2023년 10월 2주차", style: TextStyle(
          color: Color(0xff000000),
          fontSize: 14,
          fontWeight: FontWeight.bold
      ),),



    );
  }
}
class arrow extends StatelessWidget {
  arrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [

          Container(

              margin: EdgeInsets.fromLTRB(0, 20,0, 0),
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_left)
          ),
          Container(

              margin: EdgeInsets.fromLTRB(0, 20, 25, 0),
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_right)
          ),
        ],
      ),);
  }
}