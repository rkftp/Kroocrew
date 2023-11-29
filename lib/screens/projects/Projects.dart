import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';

part 'Projects.g.dart';

List subject_list = [];

class Projects extends GetView<ProjectsController> {
  Projects({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectsController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // 새로운 높이
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: Column(
            children:[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
                child: TextField(
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                    hintText: '검색',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none, // 테두리 선 없음
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              )
            ]
          ),
          bottom: TabBar(
            controller: controller.tabController,
            tabs: controller.myTabs,
            indicatorColor: Color(0xff473CCE),
            labelColor: Color(0xff473CCE),
            unselectedLabelColor: Color(0xff707070),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          Projects_Subject(),
          Projects_Activity(),
          Projects_Study(),
        ],
      ),
    );
  }
}

@swidget
Widget SearchWidget() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(Icons.search, color: Colors.grey),
        SizedBox(width: 5),
        Text('검색', style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}


class ProjectsController extends GetxController with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        '수강 과목',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    Tab(
      child: Text(
        '대외활동',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    Tab(
      child: Text(
        '스터디',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ];
  late TabController tabController = TabController(length: myTabs.length, vsync: this);
}


@swidget
Widget projects_Subject() {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20, 14, 14, 0),
        alignment: Alignment.centerLeft,
        child: Text(
          "Tip! 수강과목은 시간표에 추가한 과목만 표기됩니다.",
          style: TextStyle(
            fontSize: 12,
            color: Color(0xff707070),
          ),
        ),
      ),

    ]
  );
}

@swidget
Widget projects_Activity() {
  return Center(
    child: Text("대외활동"),
  );
}

@swidget
Widget projects_Study() {
  return Center(
    child: Text("스터디"),
  );
}

class CustomCard extends StatelessWidget {
  final String subjectName;
  final String time;
  final bool isActive;

  CustomCard({required this.subjectName, required this.time, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isActive ? Color(0xff8983ee) :
      Color(0xffe8e4e4),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Color(0xffe8e4e4),
            shape: BoxShape.circle,
          ),
        ),
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

