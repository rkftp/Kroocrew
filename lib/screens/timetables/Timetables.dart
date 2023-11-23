import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

part 'Timetables.g.dart';

class CustomCardData {
  final String subjectName;
  final String time;
  final bool isActive;

  CustomCardData({
    required this.subjectName,
    required this.time,
    required this.isActive,
  });
}

@swidget
Widget timetables() {
  List<CustomCardData> cardDataList = [
    CustomCardData(subjectName: "컴퓨터통신", time: "월 2교시, 수1~2교시", isActive: true),
    CustomCardData(subjectName: "샌즈", time: "월 2교시, 수1~2교시", isActive: false),
    CustomCardData(subjectName: "인공지능", time: "월 2교시, 수1~2교시", isActive: true),
    CustomCardData(subjectName: "오토마타와 샌즈", time: "월 2교시, 수1~2교시", isActive: false),
  ];


  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(130.0),
      child: CustomAppBar(),
    ),
    body: SafeArea(
      child: ListView.builder(
        itemCount: cardDataList.length,
        itemBuilder: (context, index) {
          CustomCardData cardData = cardDataList[index];

          return CustomCard(
            subjectName: cardData.subjectName,
            time: cardData.time,
            isActive: cardData.isActive,
          );
        },
      ),
    ),
    floatingActionButton:  CustomFloatingButton(),
  );
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2023년',
                //색 정하기
                style: TextStyle(
                  color: Color(0xff473CCE),
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 5),
              Text(
                '2학기',
                style: TextStyle(
                  color: Color(0xff473CCE),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            '시간표1',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.bug_report),
          onPressed: () {
            // 버그 아이콘을 눌렀을 때 수행할 동작 추가
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // 설정 아이콘을 눌렀을 때 수행할 동작 추가
          },
        ),
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            // 목록 아이콘을 눌렀을 때 수행할 동작 추가
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // 원하는 높이로 조절
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Text(
                '*팀플 게시판이 개설되지 않았다면?',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // 빈 공간을 만들어서, 텍스트와 버튼 사이에 공간 존재하게 하여 양옆으로 떨어지게 하기
            Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () {
                  // "개설 신청하기" 버튼을 눌렀을 때 수행할 동작 추가
                },
                child: Text('시간표 가져오기'),
                //size 작게하기
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF7365F8),
                  onPrimary: Colors.white,
                  minimumSize: Size(80, 30),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20, // 하단 여백을 제거
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              // "가져오기" 버튼을 눌렀을 때 수행할 동작 추가
            },
            child: Container(
              height: 55,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFDFD9EC), width: 3),
                color: Color(0xFF7365F8), // 버튼 배경색상
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded, color: Colors.white), // 아이콘 추가
                  SizedBox(width: 5), // 아이콘과 텍스트 간격 조정
                  Text(
                    '가져오기', // 버튼 텍스트 추가
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // "직접 추가" 버튼을 눌렀을 때 수행할 동작 추가
            },
            child: Container(
              height: 55,
              width: 105,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFDFD9EC), width: 3),
                color: Color(0xFF7365F8), // 버튼 배경색상
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(50.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white), // 아이콘 추가
                  SizedBox(width: 5), // 아이콘과 텍스트 간격 조정
                  Text(
                    '직접 추가', // 버튼 텍스트 추가
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String subjectName;
  final String time;
  final bool isActive;

  CustomCard({required this.subjectName, required this.time, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.white, width: 2),
      ),

      color: isActive ? Color(0xff8983ee) :
      Color(0xffe8e4e4),
      child: ListTile(
        leading: Icon(CupertinoIcons.list_dash, size: 30, color: isActive ? Colors.white : Colors.black,),
        title: Text(
          subjectName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          time,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}