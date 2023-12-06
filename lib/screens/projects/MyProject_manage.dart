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
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // 둥근 모서리를 없앰
                ),
                elevation: 0, // 그림자를 없앰
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 40,

                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                            splashRadius: 1,
                          ),
                        ),
                        Expanded(
                          child: Container(


                            width: 80,
                            alignment: Alignment.center,

                            child: Icon(
                              CupertinoIcons.circle_grid_hex,
                              color: _randomColor.randomColor(
                                colorBrightness: ColorBrightness.light,
                                colorSaturation: ColorSaturation.lowSaturation,
                              ),
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(

                        child: Column(
                          children: [
                            Container(height: 50,),
                            Container(
                              height: 30,

                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                            Container(
                              height: 30,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.projectData.courseName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 120,
                            height: 40,

                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.menu),
                              splashRadius: 1,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 120,

                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child:Text('${widget.projectData.currentMember.toString()}/${widget.projectData.maxMember.toString()}',
                              style: TextStyle(
                                color: Color(0xFF7365F8),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(

                              height: 60,
                              width: 120,

                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0, 10,0, 10),
                              child: ElevatedButton(
                                onPressed: (){},
                                child: Text('팀원 관리'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF7365F8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(

              height: 20,
              width: double.infinity,
              alignment: Alignment.center,
              child: Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Container(
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            ),
            Container(height: 10),
            Container(
              height: 300,
              width: double.infinity,

              child: ListView.builder(
                itemCount: scheduleList.length,
                itemBuilder: (c, i){
                  ScheduleData scheduleData = scheduleList[i];
                  return ScheduleCard(scheduleData: scheduleData);
                }
              ),
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

    return Container(
      child: Text("sdfwe"),
    );


      /*ListTile(
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
    );*/
  }
}