import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:contact/widgets/flutter_dropdown_page.dart';
import 'package:dio/dio.dart';
import '/utils/token_keybox.dart';

List<String> list = ['캡디','인공지능','컴그','컴통'];
bool rapid_match = false;
setmatchtrue(){
  rapid_match = true;
}
setmatchfalse(){
  rapid_match = false;
}

TextEditingController _textFieldController = TextEditingController();

Future<void> addproject(name,subject,num,description,rapid_match) async {
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


  @override
  Widget build(BuildContext context) {

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
                              controller: _textFieldController,
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
                        Container(
                          height: 60,
                          width: 200,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: FlutterDropdownSubject(list: list),
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
                          child: FlutterDropdownTeamnum(),
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
                        /*IconButton(onPressed:
                        rapid_match==true?
                        setState
                        setmatchfalse():setmatchtrue(),
                            icon: Icon(rapid_match==true?Icons.square_outlined:Icons.square))*/
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child:ElevatedButton(
                          onPressed: (){
                          },
                          child: Text('닫기',style: TextStyle(
                            color: Colors.black
                          ),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xffffffff)), // 여기에서 색상을 설정
                          ),
                        )
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child:ElevatedButton(
                          onPressed: (){
                          },
                          child: Text('추가하기'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff473CCE)), // 여기에서 색상을 설정
                          ),
                        )
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}