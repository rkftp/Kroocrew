import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

import '/providers/timetableProvider.dart';

class Timetables extends ConsumerStatefulWidget{
  const Timetables({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimetablesState();
}

class _TimetablesState extends ConsumerState<Timetables> {

  @override
  void initState() {
    super.initState();
    //run getDB
    ref.read(timetableProvider.notifier).getDB(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    final timetableList = ref.watch(timetableProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: timetableList.length,
          itemBuilder: (context, index) {
            TimetableData timetableData = timetableList[index];

            return TimetableCard(
              courseName: timetableData.CourseName,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // "시간표 추가" 버튼을 눌렀을 때 수행할 동작 추가
        },
        child: Icon(Icons.refresh, color:Colors.white),
        backgroundColor: Color(0xFF7365F8),
      ),
    );
  }
}

class CustomAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              '23년 2학기',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
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
                '*시간표가 보이지 않는다면?',
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
                  ref.read(timetableProvider.notifier).getPortal(context, ref);
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

class TimetableCard extends ConsumerStatefulWidget {
  final String courseName;

  TimetableCard({required this.courseName});

  @override
  ConsumerState<TimetableCard> createState() => _TimetableCardState();
}

class _TimetableCardState extends ConsumerState<TimetableCard> {
  @override
  Widget build(BuildContext context) {
    final bool isActive;
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.white, width: 2),
      ),

      color: Colors.white,
      child: ListTile(
        leading: Icon(CupertinoIcons.circle, size: 30, color: Color(0xFF7365F8)),
        title: Text(
          widget.courseName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color:  Color(0xFF7365F8) ,
          ),
        ),
        subtitle: Text(
         '샌즈',
          style: TextStyle(
            color:  Color(0xFF7365F8) ,
          ),
        ),
      ),
    );
  }
}