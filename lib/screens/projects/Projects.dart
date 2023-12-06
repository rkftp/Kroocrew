import 'package:contact/screens/projects/MyProject.dart';
import 'package:contact/screens/projects/AddProject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:random_color/random_color.dart';

import '/providers/projectProvider.dart';
import 'JoinProject.dart';

part 'Projects.g.dart';



class Projects extends ConsumerStatefulWidget{
  const Projects({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectsState();
}


class _ProjectsState extends ConsumerState<Projects> with SingleTickerProviderStateMixin {

  late final Provider<TabController> recentTabStateProvider;

  @override
  void initState() {
    super.initState();
    recentTabStateProvider = Provider<TabController>((ref) {
      return TabController(length: 3, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(recentTabStateProvider);
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
          '내 프로젝트',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Tab(
        child: Text(
          '프로젝트 생성',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // 새로운 높이
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: controller,
            tabs: myTabs,//
            indicatorColor: Color(0xff473CCE),
            labelColor: Color(0xff473CCE),
            unselectedLabelColor: Color(0xff707070),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          WholeProject(),
          MyProject(),
          AddProject(),
        ],
      ),
    );
  }
}


class WholeProject extends ConsumerStatefulWidget {
  const WholeProject({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WholeProjectState();
}

class _WholeProjectState extends ConsumerState<WholeProject> {
  @override
  void initState() {
    super.initState();
    ref.read(projectProvider.notifier).getWholeProject('');
  }

  @override
  Widget build(BuildContext context) {
    final projectList = ref.watch(projectProvider);
    return Container(
      color: Colors.white,
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 14, 14, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                  children:[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: TextField(
                        focusNode: FocusNode(),
                        onChanged: (text) {
                          ref.read(projectProvider.notifier).getWholeProject(text);
                        },
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
                          suffixIcon: GestureDetector(
                            child: Padding(
                              //눌렀을때 provider로 다시 받아오기
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.refresh, color: Colors.grey),
                            ),
                            onTap: () {
                              ref.read(projectProvider.notifier).getWholeProject('');
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      child: ListView.builder(
                        itemCount: projectList.length,
                        itemBuilder: (content, index) {
                          ProjectCardData cardData = projectList[index];
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return JoinProject(projectData: cardData);
                                },
                              );
                            },
                            child: CustomCard(
                              courseName: cardData.courseName,
                              teamName: cardData.teamName,
                            ),
                          );
                        },
                      ),
                    ),
                  ]
              ),
            ),
          ]
      ),
    );
  }
}


@swidget
Widget projects_Study() {
  return Center(
    child: Text("스터디"),
  );
}

class CustomCard extends ConsumerStatefulWidget {
  final String courseName;
  final String teamName;

  CustomCard({required this.courseName, required this.teamName});

  @override
  ConsumerState<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCard> {
  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();
    return Card(
      color: Colors.white,
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
          widget.courseName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          widget.teamName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

