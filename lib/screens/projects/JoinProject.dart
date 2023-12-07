import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_color/random_color.dart';
import  'package:intl/intl.dart';


import '/providers/projectProvider.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:slide_countdown/slide_countdown.dart';



class JoinProject extends ConsumerStatefulWidget{

  final ProjectCardData projectData;

  const JoinProject({
    Key? key,
    required this.projectData,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinProjectState();
}

class _JoinProjectState extends ConsumerState<JoinProject>{



  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();

    DateTime now = DateTime.now();

    // API에서 받아온 finish_time
    String apiFinishTime = widget.projectData.finishTime;

    // API에서 받아온 finish_time을 DateTime 형식으로 파싱
    DateTime finishTime = DateFormat("yyyy-MM-dd HH:mm").parse(apiFinishTime);

    // 차이 계산
    Duration difference = finishTime.difference(now);

    // 남은 시간을 일, 시간, 분, 초로 변환
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
        //border radius only top

        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),


        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
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
                          leading: Icon(
                            CupertinoIcons.circle_grid_hex,
                            color: _randomColor.randomColor(
                              colorBrightness: ColorBrightness.light,
                              colorSaturation: ColorSaturation.lowSaturation,
                            ),
                            size: 40,
                          ),
                          trailing: Row(
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
                      ),
                      Container(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height *  0.15,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 700,
                          axes:<RadialAxis>[
                            RadialAxis(
                              minimum: 0, maximum: 300,
                              showLabels: false,
                              showTicks: false,
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    angle: 90,
                                    positionFactor: 0.17,
                                    widget: Text(
                                      widget.projectData.averageSpeed.toString() + 'km/h',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      ),
                                    )
                                )
                              ],
                              pointers:<GaugePointer> [
                                RangePointer(
                                  value: widget.projectData.averageSpeed.toDouble(),
                                  width: 0.3,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  gradient: const SweepGradient(
                                    colors: <Color>[Color(0xFF7365F8), Color(0xFF7365F8)],
                                    stops: <double>[0.25, 0.75],
                                  ),
                                ),
                              ],
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.3,
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                            )
                          ]
                        )
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                  children: [
                                    Text(
                                      (widget.projectData.maxMember - widget.projectData.currentMember).toString(),
                                      style: TextStyle(
                                        color: Color(0xFF7365F8),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        ' 명이 더 참여할 수 있습니다.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                    )
                                  ]
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.projectData.teamLeader,
                                    style: TextStyle(
                                      color: Color(0xFF7365F8),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' 님의 팀에 참가하세요!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  color: Color(0xffEFEFEF),
                  width: double.infinity,
                  height: 100,
                  child: Text(
                    widget.projectData.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideCountdown(
                        duration: widget.projectData != null
                            ? Duration(
                          days: days,
                          hours: hours,
                          minutes: minutes,
                          seconds: seconds,
                        ) : Duration(),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        separatorStyle: TextStyle(
                          color: Colors.black,
                        ),

                      ),
                      Container(
                        width: 120,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            // joinProject(context, ref, widget.projectData.teamId);
                            final toastText = ref.watch(joinTeamProvider);
                            ref.read(joinTeamProvider.notifier).joinTeam(widget.projectData.teamId);
                            print(toastText);
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(toastText),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('확인'),
                                    ),
                                  ],
                                );
                              },
                            );
                            },
                          child: Text('참여 요청'),

                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF7365F8),
                            onPrimary: Colors.white,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            )
          ]
        ),

    );
  }

}