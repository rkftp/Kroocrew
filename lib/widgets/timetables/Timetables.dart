import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';

part 'Timetables.g.dart';

@swidget
Widget timetables() {
  List<String> list = List.generate(4, (index) => "Text $index");

  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(130.0),
      child: CustomAppBar(),
    ),
    body: SafeArea(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Color(0xFF7365F8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.00, 0.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              '강의 이름 ',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            '강의실',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
                          child: Text(
                            '요일과 시간',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ),
    floatingActionButton:  CustomFloatingButton(),

    /*Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            // Handle search button press
          },
          label: Text("시간표 가져오기"),
          icon: Icon(Icons.search),
        ),
        SizedBox(width: 10), // Add some spacing between buttons
        FloatingActionButton.extended(
          onPressed: () {
            // Handle plus button press
          },
          icon: Icon(Icons.search_rounded),
          label: Text("직접 추가"),
        ),
      ],
    ),*/
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
