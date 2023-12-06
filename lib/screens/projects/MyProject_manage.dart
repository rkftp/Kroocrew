import 'package:contact/screens/home/3.List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/cupertino.dart';

import '/providers/projectProvider.dart';
import '/providers/manageProjectsProvider.dart';


class ManageMyProjects extends ConsumerStatefulWidget {
  final ProjectCardData projectData;

  const ManageMyProjects({Key? key, required this.projectData}) : super(key: key);

  @override
  ConsumerState createState() => _ManageMyProjectsState();
}

class _ManageMyProjectsState extends ConsumerState<ManageMyProjects> {

  @override
  void initState() {
    super.initState();
    ref.read(manageProvider.notifier).getSchedule(context, ref, widget.projectData.teamId);
  }

  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();

    final scheduleList = ref.watch(manageProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
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
                  CupertinoIcons.circle_grid_hex,
                  color: _randomColor.randomColor(
                    colorBrightness: ColorBrightness.light,
                    colorSaturation: ColorSaturation.lowSaturation,
                  ),
                  size: 40,
                ),
                trailing: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.projectData.currentMember.toString(),
                          style: TextStyle(
                            color: Color(0xFF7365F8),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' / ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.projectData.maxMember.toString(),
                          style: TextStyle(
                            color: Color(0xFF7365F8),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 30)
                      ],
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        child: Text('팀원 관리'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF7365F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                    )
                  ],
                ),
                title: Text(
                  widget.projectData.courseName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                subtitle: //add two text widget
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '팀 ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,

                      ),
                    ),
                    Text(
                      widget.projectData.teamName,
                      style: TextStyle(
                        color: Color(0xFF7365F8),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(onPressed: (){}, child: Row(
                  children: [
                    Icon(CupertinoIcons.forward_end_alt_fill),
                    Text(
                      '신속 매칭'
                    ),
                  ],
                )),
                ElevatedButton(onPressed: (){}, child: Row(
                  children: [
                    Icon(CupertinoIcons.add),
                    Text(
                        '일정 추가'
                    ),
                  ],
                ))
              ]
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // 둥근 모서리를 없앰
              ),
              elevation: 0, // 그림자를 없앰
              child: ListView.builder(
                itemCount: scheduleList.length,
                itemBuilder: (context, index){
                  ScheduleData scheduleData = scheduleList[index];
                  return ScheduleCard(scheduleData: scheduleData);
                }
              )
            )

          ]
        )
      )
    );
  }
}

class ScheduleCard extends ConsumerStatefulWidget {
  final ScheduleData scheduleData;

  const ScheduleCard({Key? key, required this.scheduleData}) : super(key: key);

  @override
  ConsumerState<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends ConsumerState<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();

    return ListTile(
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
        widget.scheduleData.description,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        widget.scheduleData.deadline,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      trailing: Container(
        width: 30,
        child: Text(
          widget.scheduleData.studentId,
          style: TextStyle(
            color: Colors.black,
          ),
      )
      ),
    );
  }
}