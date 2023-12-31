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
import 'package:intl/intl.dart';

import 'Member_manage.dart';

import '/providers/projectProvider.dart';
import '/providers/manageProjectsProvider.dart';
import '/providers/auth.dart';

class RequestDTO{
  final int joinRequest_id;
  final String studentId;
  final int teamId;
  final String reqStudentId;
  final String description;

  RequestDTO({
    required this.joinRequest_id,
    required this.studentId,
    required this.teamId,
    required this.reqStudentId,
    required this.description,
  });

  factory RequestDTO.fromJson(Map<String, dynamic> json){
    return RequestDTO(
      joinRequest_id: json['JoinRequest_id'],
      studentId: json['Student_id'],
      teamId: json['Team_id'],
      reqStudentId: json['req_Student_id'],
      description: json['description'],
    );
  }
}

class requestController extends StateNotifier<List<RequestDTO>>{

  requestController() : super([]);
  Future<void> getRequest(BuildContext context, int teamId) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/join_team_request_list',
        options: Options(
          headers: {'Authorization': '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      print('팀원 요청 조회 성공');
      print(response.data);
      state = response.data['requested_list']
          .map((item) => RequestDTO.fromJson(item))
          .toList();
    } else {
      print('팀원 요청 조회 실패' + response.data['success'].toString());
    }
  }
}

final requestProvider = StateNotifierProvider<requestController, List<dynamic>>((ref) {
  return requestController();
});

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
    ref.read(rapidMatchProvider.notifier).getRapidMatch(widget.projectData.teamId);
    ref.read(requestProvider.notifier).getRequest(context, widget.projectData.teamId);
  }

  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();
    final scheduleList = ref.watch(manageProvider);
    final rapidValue = ref.watch(rapidMatchProvider);
    final idState = ref.watch(authStateProvider);
    final requestList = ref.watch(requestProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
          backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
        ),
        endDrawer: Drawer(

        ),
        body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
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
                      Flexible(
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
                        ),flex: 1
                      ),
                      Flexible(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

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
                        ),flex:2
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Container(
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
                                ),flex: 1,
                              ),
                              Flexible(
                                  child: Container(
                                      height: 60,
                                      width: 120,

                                      alignment: Alignment.center,
                                      padding: EdgeInsets.fromLTRB(0, 10,0, 10),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return memberManage(memberData: requestList);
                                                });
                                          },
                                          child: Text('팀원 관리'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF7365F8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          )
                                      )
                                  ),flex: 1
                              )
                            ],
                          ),
                        ),flex: 1
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
                      Container(
                        child: Row(
                          children: [
                            Container(child: Icon(CupertinoIcons.bolt_fill)),

                            widget.projectData.teamLeader == idState  ? CupertinoSwitch(
                              value: rapidValue,
                              onChanged: (value) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: rapidValue ? '신속 매칭을 해제하시겠습니까?' : '신속 매칭을 하시겠습니까?',
                                  confirmBtnText: '확인',
                                  cancelBtnText: '취소',
                                  confirmBtnColor: Color(0xFF7365F8),
                                  onConfirmBtnTap: () {
                                    context.pop();
                                    rapidValue ? ref.read(rapidMatchProvider.notifier).editRapidMatch(widget.projectData.teamId, false, context)
                                        : ref.read(rapidMatchProvider.notifier).editRapidMatch(widget.projectData.teamId, true, context);
                                  },
                                );
                              },
                            ) :
                            CupertinoSwitch(
                              value: false,
                              onChanged: (value){
                                QuickAlert.show(
                                  context: context,
                                  type:QuickAlertType.error,
                                  text:'팀장만이 신속 매칭을 설정할 수 있습니다.',
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ElevatedButton(onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Addschedule();
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  height: MediaQuery.of(context).size.height*0.5,
                  width: double.infinity,

                  child: scheduleList.isEmpty ?
                      Center(
                        child: Text(
                          '생성된 일정이 없습니다.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                      : ListView.builder(
                      itemCount: scheduleList.length,
                      itemBuilder: (c, i){
                        ScheduleData scheduleData = scheduleList[i];
                        return ScheduleCard(scheduleData: scheduleData);
                      }
                  ),
                ),
              ),


            ]
          ),
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

class Addschedule extends ConsumerStatefulWidget {
const Addschedule({Key? key}) : super(key: key);


@override
ConsumerState<ConsumerStatefulWidget> createState() => _AddscheduleState();
}

class _AddscheduleState extends ConsumerState<Addschedule> {
  DateTime today = DateTime.now();
  Widget build(BuildContext context) {
    String formattDate = DateFormat('yyyy-MM-dd HH:mm').format(today);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('일정 추가',style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),),
      content: SingleChildScrollView(
        child: Container(
            width: double.maxFinite,
            height: 200,
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
                Container(
                    height: 60,

                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextButton(onPressed: (){

                      showCupertinoDialog(context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context){
                            return Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.white,
                                  height:300,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    onDateTimeChanged: (DateTime date){
                                      setState(() {
                                        today = date;
                                      });
                                    },

                                  ),
                                )
                            );
                          });
                    },child: Text(formattDate,style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,

                    ),))
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

