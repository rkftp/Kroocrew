import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:quickalert/quickalert.dart';


import '/providers/timetableProvider.dart';
import '/providers/projectProvider.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:slide_countdown/slide_countdown.dart';


class MatchModal extends ConsumerStatefulWidget{

  final TimetableData timetableData;

  const MatchModal({Key? key, required this.timetableData}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchModalState();
}

class _MatchModalState extends ConsumerState<MatchModal>{



  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();

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
      height: MediaQuery.of(context).size.height * 0.45,

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
                              CupertinoIcons.doc_text_search,
                              color: Colors.black,
                              size: 40,
                            ),
                            title: Text(
                              '인공지능',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '함께할 크루를 찾아보세요!',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,

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
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  color: Color(0xffEFEFEF),
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.loading,
                                  text: '신속 매칭모드로 검색을 시작합니다.',
                                  confirmBtnText: '확인',
                                  confirmBtnColor: Color(0xFF7365F8),

                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.bolt_sharp, color:Color(0xFF7365F8)),
                                  Text('신속 매칭', style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold))
                                ]
                              )
                          ),
                          Container(
                              color: Colors.white,
                              child: Text(
                                  '가장 빠르게 훌륭한 크루를 매칭해드립니다.'
                              )
                          )

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                context.go('/projects');
                                ref.read(projectProvider.notifier).getWholeProject(widget.timetableData.CourseName, ref);
                              },
                              child: Row(
                                  children: [
                                    Icon(Icons.person_search, color:Color(0xFF7365F8)),
                                    Text('일반 매칭', style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold))
                                  ]
                              )
                          ),
                          Container(
                            color: Colors.white,
                            child: Text(
                              '크루원들의 정보와 속도를 확인하고 매칭에 참여해보세요.'
                            )
                          )
                        ],
                      ),
                    ]
                  )
                ),
              ],
            ),
          ]
      ),

    );
  }

}