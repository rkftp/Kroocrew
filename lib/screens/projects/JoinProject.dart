import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_color/random_color.dart';

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

    return Container(
      decoration: BoxDecoration(
        //border radius only top
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
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
                        Row(
                          children: [
                            SlideCountdown(
                              duration: const Duration(days: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              separatorStyle: TextStyle(
                                color: Colors.black,
                              ),

                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )

          ]
        ),
      )
    );
  }

}