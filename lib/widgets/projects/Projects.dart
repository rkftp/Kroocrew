import 'package:flutter/material.dart';
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
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          elevation: 0,
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
      )
    );
  }
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

