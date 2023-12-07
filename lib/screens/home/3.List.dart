import 'package:flutter/material.dart';
import '/providers/mainprovider.dart';
import '/widgets/box.dart';
class list extends StatefulWidget {
  list({super.key,this.b1});
  final b1;

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {


  bool week_box = true;

  onoff_week() {
    if(week_box == true) {
      setState((){week_box = false;});
    }else{
      setState((){week_box = true;});
    }
  }

  bool isArrowUp = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                onoff_week();
                setState(() {
                  isArrowUp = !isArrowUp;
                });
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 34,
                width: 120,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isArrowUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 25,
                      color: Color(0xff473CCE),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '전체 일정',
                      style: TextStyle(
                        color: Color(0xff473CCE),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            week_box == true ? Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xff473cce), width: 2),
                ),
                child: widget.b1.length > 0?ListView.builder(itemCount: widget.b1.length,itemBuilder: (c,i){
                  return Con(schedule: widget.b1[i]);
                },) :
                ListView.builder(itemCount:1,itemBuilder: (c,i){
                  return Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text('일정이 없습니다.',style: TextStyle(
                        fontSize: 15,
                      )));
                },)
            ) :
            Container(),
          ],
      )
    );
  }
}







class Con extends StatelessWidget {
  Con({super.key, required this.schedule});
  final Schedule schedule;

  @override

  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            Flexible(child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Icon(Icons.star, size: 15, color: Color(0xff000000))
            ),
                flex: 1),
            Flexible(child: Container(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 10),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("${DateTime.parse(schedule.deadLine).month.toString().padLeft(2, '0')}월${DateTime.parse(schedule.deadLine).day.toString().padLeft(2, '0')}일", style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 15,
                        )),
                        Text(schedule.description, style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 15,
                        )),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(schedule.courseName, style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 15,
                          )),
                          Text(schedule.teamName, style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 15,
                          )),
                        ]
                    )
                  ]
              ),
            ),
                flex: 10),
          ],
        )
    );
  }
}
