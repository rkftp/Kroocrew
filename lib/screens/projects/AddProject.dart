import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:contact/widgets/flutter_dropdown_page.dart';
import 'package:dio/dio.dart';
import '/utils/token_keybox.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '/providers/timetableProvider.dart';



TextEditingController _nameFieldController = TextEditingController();
TextEditingController _textFieldController = TextEditingController();

Future<void> addproject(name,subject,formattDate,num,description,rapid_match) async {
  Dio _dio = Dio();
  KeyBox _keyBox = KeyBox().to();

  late String? storedToken;
  storedToken = await _keyBox.getToken();
  final response = await _dio.get('http://20.39.186.138:1234/create_team',options: Options(
      headers : {'Authorization': '${storedToken}'},
      ),
      queryParameters: {
        "Student_id" : storedToken,
        "Course_id" : subject,
        "finish_time" : formattDate,
        "Team_name" : name,
        "max_member" : num,
        "description" : description,
        "rapid_match" : rapid_match,
      });
      print("\n토큰저장 성공, ${response}");
      print(response.data);


  try {
    if (response.statusCode == 200) {
      print("성공");
      if(response.data['success'] == true){
        print("쌉가능");

      }else{
        print("불가능");

      }
    } else {
      print("이미있다 아가야");
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}


class AddProject extends ConsumerStatefulWidget {
  const AddProject({Key? key}) : super(key: key);


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProjectState();
}

class _AddProjectState extends ConsumerState<AddProject> {
  bool rapid_match = false;
  int num =2;
  String subject = '';

  DateTime today = DateTime.now();

  void _handleDropdownChanged(int newValue) {
    setState(() {
      num = newValue;
    });
  }
  void _handleDropdownChanged1(String newValue) {
    setState(() {
      subject = newValue;
    });
  }
  @override
  void initState() {
    super.initState();
    ref.read(timetableProvider.notifier).getDB(context, ref);
  }

  @override
  Widget build(BuildContext context) {

    final List<TimetableData> timetableList = ref.watch(timetableProvider);
    List<String> list = timetableList.map((item) {
      return item.CourseId;
    }).toList();

    String formattDate = DateFormat('yyyy-MM-dd HH:mm').format(today);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text('프로젝트 생성',style:TextStyle(
                  fontSize: 20,
                  fontWeight:FontWeight.w800,
                )),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffD9D9D9),
                      width: 0.5,
                    ),
                  ),
                  //
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Text('팀명',style:TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.w500,
                          ),),
                        ),
                        Container(
                          height: 60,
                          width: 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextField(
                              controller: _nameFieldController,
                              decoration: InputDecoration(
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Text('해당 과목',style:TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.w500,
                          ),),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,

                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(20, 10, 60, 10),
                            child: FlutterDropdownSubject(list: list,onDropdownChanged: _handleDropdownChanged1,),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Text('최대 인원 :',style:TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.w500,
                          ),),
                        ),
                        Container(
                          height: 60,
                          width: 100,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: FlutterDropdownTeamnum(
                            onDropdownChanged: _handleDropdownChanged,
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 100,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Text('명',style:TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.w500,
                          ),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Text('마감시간',style:TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.w500,
                          ),),
                        ),
                        Expanded(
                          child: Container(
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
                        ),

                      ],
                    ),
                  ],
                ),


                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffD9D9D9),
                      width: 0.5,
                    ),
                  ),
                  //
                ),
              ),
              Container(
                height: 290,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text("팀 소개글 (추후 수정 가능합니다.)",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      width: double.infinity,
                      height: 140,
                      child: ListView(
                          children: [TextField(
                            controller: _textFieldController,
                            maxLines: null,
                            minLines: 5,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),]
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          child: IconButton(
                            icon: Icon(
                              rapid_match ? Icons.square : Icons.square_outlined, // 상태에 따라 아이콘 변경
                            ),
                            onPressed: () {
                              setState(() {
                                rapid_match = !rapid_match; // 상태 토글
                              });
                            },
                          ),
                        ),
                        Container(
                          child: Text("빠른 매칭을 허용합니다.",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),),
                        )
                      ],
                    )

                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffD9D9D9),
                      width: 0.5,
                    ),

                  ),
                ),
              ),

              Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child:ElevatedButton(
                    onPressed: ()async{
                      await addproject (_nameFieldController.text,subject,formattDate,num,_textFieldController.text,rapid_match);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('프로젝트 생성'),
                            content: Container(
                                width: double.maxFinite, // 팝업의 너비를 최대로 설정
                                child: Text("새 팀 생성에 성공하였습니다.")
                            ),
                            actions: <Widget>[
                              TextButton(
                                  child: Text('확인'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }
                              ),

                              // 수정된 텍스트 표시
                            ],
                          );
                        },
                      );
                    },
                    child: Text('추가하기'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff473CCE)),
                      // 여기에서 색상을 설정
                    ),
                  )
              )
            ],
          )
        ),
      )
    );
  }
}
class CuDatePicker extends StatelessWidget {
  const CuDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      maximumDate: new DateTime.now(),
      minimumYear: 2010,
      maximumYear: 2030,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (DateTime value) {},
    );
  }
}


