import 'package:contact/screens/home/3.List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:contact/widgets/flutter_dropdown_page.dart';
import 'package:quickalert/quickalert.dart';

import 'package:dio/dio.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';


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
                            onPressed: () {
                              context.go('/projects');
                            },
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
                              onPressed: () {
                                const Drawer(
                                  child: Text('This is a Drawer'),
                                );
                              },
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
                  ElevatedButton(onPressed: (){
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: '신속 매칭을 하시겠습니까?',
                      confirmBtnText: '확인',
                      cancelBtnText: '취소',
                      confirmBtnColor: Color(0xFF7365F8),
                      onConfirmBtnTap: () {
                        context.pop();
                        editRapidMatch(widget.projectData.teamId, true, context);
                      },
                    );
                  }, child: Row(
                    children: [
                      Icon(CupertinoIcons.forward_end_alt_fill),
                      Text(
                        '신속 매칭'
                      ),
                    ],
                  )),
                  ElevatedButton(onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSchedule();
                      },
                    );
                  }, child: Row(
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 300,
                width: double.infinity,

                child: ListView.builder(
                  itemCount: scheduleList.length,
                  itemBuilder: (c, i){
                    ScheduleData scheduleData = scheduleList[i];
                    return ScheduleCard(scheduleData: scheduleData);
                  }
                ),
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

    return ListTile(
      contentPadding: EdgeInsets.all(0), // 내용의 패딩을 없앰
      visualDensity: VisualDensity(horizontal: 0, vertical: -4), // 아이콘과 텍스트 간격을 조절

      // leading을 직접 정의
      leading: Icon(
        CupertinoIcons.book_solid,
        color: Colors.grey,
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
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),

        ),
        width: 100,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            widget.scheduleData.studentId,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
                ),
        )
      ),
    );
  }
}

class AddSchedule extends ConsumerWidget {
  const AddSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('일정 추가',style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),),
      content: SingleChildScrollView(
        child: Container(
            width: double.maxFinite,
            height: 200 +(50*"asdf".length).toDouble(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 45,
                      child: Text("이름: ",style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                    ),
                    Container(
                      height: 30,
                      width: 170,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: TextField(
                          // controller: nameController,
                          decoration: InputDecoration(
                          )
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      child: FlutterDropdownIcon(),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text('마감 기한',style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 100,
                      child:FlutterDropdownYear(),


                    ),
                    Text("년",style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),
                    Container(
                      height: 60,
                      width: 40,
                      child:FlutterDropdownMonth(),
                    ),
                    Text("월",style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),
                    Container(
                      height: 60,
                      width: 40,
                      child:FlutterDropdownDay(),
                    ),
                    Text("일",style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),

                  ],
                ),
                Container(height: 30),//여백용 Container

              ],
            )
        ),
      ),
      actions: <Widget>[

        TextButton(
          child: Text('추가'),
          onPressed: () {
            Navigator.of(context).pop(); // 팝업 닫기
          },
        ),
        TextButton(
          child: Text('취소'),
          onPressed: () {

            Navigator.of(context).pop(); // 팝업 닫기
          },
        ),
        // 수정된 텍스트 표시
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );;
  }
}

void editRapidMatch(TeamId, rapidValue, BuildContext context) async{
  Dio _dio = DioServices().to();
  KeyBox _keyBox = KeyBox().to();

  late String? storedToken;
  storedToken = await _keyBox.getToken();


  final response = await _dio.get('/rapid_match_on_off',
      queryParameters: {
        'Team_id': TeamId,
        'rapid_match': rapidValue,
      },
      options: Options(
        headers : {'Authorization': '${storedToken}'},
      )
  );

  if (response.statusCode == 200) {
    print(response.data);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: '신속 매칭모드로 전환되었습니다.',
      confirmBtnText: '확인',
      confirmBtnColor: Color(0xFF7365F8),
      onConfirmBtnTap: () {
        context.pop();
      },
    );

  } else {
    print("실패해버린..");
  }
}