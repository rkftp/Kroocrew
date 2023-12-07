import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/cupertino.dart';

import '../../providers/mainprovider.dart';
import '/providers/projectProvider.dart';

class list extends StatefulWidget {
  list({super.key,this.b1});
  final b1;

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {



  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 500,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 70,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey,
                width: 1,)
              )
            ),
            child: Text("내 일정",style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),),

          ),
          Expanded(
            child: Container(

              width: double.infinity,
              margin: EdgeInsets.fromLTRB(20, 14, 14, 0),
              alignment: Alignment.centerLeft,

              child : widget.b1.length > 0?ListView.builder(itemCount: widget.b1.length,itemBuilder: (c,i){
                Schedule cardData = widget.b1[i];
                return CustomCard(
                  cardData: cardData,
                );
              },) :
              ListView.builder(itemCount:1,itemBuilder: (c,i){
                return Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text('일정이 없습니다.',style: TextStyle(
                      fontSize: 15,
                    )));
              },
              ),),
          ),
        ],
      ),
    );
  }
}


class CustomCard extends ConsumerStatefulWidget {


  CustomCard({required this.cardData});
  final Schedule cardData;

  @override
  ConsumerState<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCard> {
  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 둥근 모서리를 없앰
      ),
      elevation: 0, // 그림자를 없앰
      child: ListTile(
        contentPadding: EdgeInsets.all(0), // 내용의 패딩을 없앰
        visualDensity: VisualDensity(horizontal: 0, vertical: -4), // 아이콘과 텍스트 간격을 조절

        // leading을 직접 정의
        leading: Icon(
          CupertinoIcons.circle_fill,
          color: _randomColor.randomColor(
            colorBrightness: ColorBrightness.light,
            colorSaturation: ColorSaturation.lowSaturation,
          ),
          size: 30,
        ),

        title: Text(
          widget.cardData.courseName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                widget.cardData.teamName,
                style: TextStyle(
                  color:Colors.indigo,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                widget.cardData.deadLine,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

