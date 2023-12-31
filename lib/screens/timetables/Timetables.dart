import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

import '/providers/projectProvider.dart';
import '/providers/timetableProvider.dart';

import 'MatchModal.dart';

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: timetableList.length,
            itemBuilder: (context, index) {
              TimetableData timetableData = timetableList[index];

              return TimetableCard(
                timetableData: timetableData,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(timetableProvider.notifier).getDB(context, ref);
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
                '*시간표를 다시 가져오고 싶다면?',
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
                },
                child: Text('시간표 새로 가져오기'),
                //size 작게하기
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF7365F8),
                  onPrimary: Colors.white,
                  minimumSize: Size(80, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
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
  final TimetableData timetableData;

  TimetableCard({required this.timetableData});

  @override
  ConsumerState<TimetableCard> createState() => _TimetableCardState();
}

class _TimetableCardState extends ConsumerState<TimetableCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.timetableData.isActive) {
          // context.go('/projects/manage', extra: widget.timetableData.CourseId);
        } else {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return MatchModal(timetableData: widget.timetableData);
            }
          );
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 둥근 모서리를 없앰
        ),
        elevation: 0, // 그림자를 없앰
        child: ListTile(
          contentPadding: EdgeInsets.all(0), // 내용의 패딩을 없앰
          visualDensity: VisualDensity(horizontal: 0, vertical: -4), // 아이콘과 텍스트 간격을 조절

          // leading을 직접 정의
          leading: widget.timetableData.isActive ? Icon(
            CupertinoIcons.circle_fill,
            color: Color(0xFF7365F8),
            size: 30,
          ) : Icon(
            CupertinoIcons.circle,
            color: Colors.grey,
            size: 30,
          ),
          trailing: widget.timetableData.isActive ? Icon(
            CupertinoIcons.checkmark_alt_circle,
            color: Color(0xFF7365F8),
            size: 30,
          ) : Icon(
            CupertinoIcons.doc_text_search,
            color: Colors.grey,
            size: 30,
          ),

          title: Text(
            widget.timetableData.CourseName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: widget.timetableData.isActive ? Color(0xFF7365F8) : Colors.grey,
              fontSize: 20,
            ),
          ),
          subtitle: widget.timetableData.isActive ?
          Text(
            widget.timetableData.CourseDay + ' ' + widget.timetableData.CourseStartTime + '~',
            style: TextStyle(
              color: Color(0xFF7365F8),
            ),
          ) : Text(
            widget.timetableData.CourseDay + ' ' + widget.timetableData.CourseStartTime + '~',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}