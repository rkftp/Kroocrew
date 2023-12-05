import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'front_page.dart' as front;
import '0.Head.dart' as Head;
import '1.Name.dart' as Name;
import 'SpeedChart.dart' as SpeedChart;

import '/screens/login/login.dart' as login;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/providers/mypageProvider.dart';


import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';



Future<void> description(text) async {
  Dio _dio = Dio(); // dio_service에서 생성한 객체를 가져옵니다.
  KeyBox _keyBox = KeyBox().to();
  late String? storedToken;
  storedToken = await _keyBox.getToken();
  print("2");
  final response = await _dio.get('http://20.39.186.138:1234/add_student_description?description=${text}',
      options: Options(
        headers : {'Authorization': '${storedToken}'},
      ));
  print("3");
  try {
    if (response.statusCode == 200) {
      print("성공");
      print(response.data['success']);
      if (response.data['success'] == true) {
        print("찐성공");
      } else {
        print("미친 실패");
      }
    } else {}
  } catch (e) {
    print('오류 발생: $e');
  }
}
class Myinfo extends ConsumerStatefulWidget {
  const Myinfo({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyinfoState();
}
class _MyinfoState extends ConsumerState<Myinfo> {

  @override
  void initState() {
    super.initState();
    ref.read(MyinfoProvider.notifier).getMainAPI();
  }

  @override

  Widget build(BuildContext _context) {

    final myinfoState = ref.watch(MyinfoProvider);

    MyinfoData myinfoData = myinfoState;
    String _editedText = myinfoData.description;

    TextEditingController _textFieldController = TextEditingController(text:_editedText);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                header(front: front.Myinfo(user_name: myinfoData.studentName,user_id: myinfoData.studentId,user_speed: myinfoData.speed,user_dep_name: myinfoData.department,user_num: myinfoData.studentNumber,user_uni_name: '중앙대')),
                Name.NamePlace(user_name: myinfoData.studentName,user_speed: myinfoData.speed,),
                SpeedChart.SpeedChart(speed: myinfoData.speed),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text("내 소개 글",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xff000000), width: 1.5),
                  ),
                  child: ListView(
                    children: [Text(_editedText, style: TextStyle(
                      fontSize: 16,
                    ),),]
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('내용 수정'),
                            content: Container(
                              width: double.maxFinite, // 팝업의 너비를 최대로 설정
                              child: TextField(
                                controller: _textFieldController,
                                maxLines: null,
                                minLines: 5, // 최소 줄 수를 증가시켜 넓이를 확보
                                decoration: InputDecoration(
                                  hintText: "텍스트를 입력하세요",
                                  border: OutlineInputBorder(), // 네모난 테두리 적용
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('취소'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // 팝업 닫기
                                },
                              ),
                              TextButton(
                                child: Text('저장'),
                                onPressed: () {
                                 description(_textFieldController.text);
                                 ref.read(MyinfoProvider.notifier).getMainAPI();
                                  Navigator.of(context).pop(); // 팝업 닫기
                                },
                              ),
                               // 수정된 텍스트 표시
                            ],
                          );
                        },
                      );
                    },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff473CCE)), // 여기에서 색상을 설정
                      ),
                    child: Text('수정하기'),

                  ),
                ),

              ],

            ),


          ),
        ),
      ),
    );
  }
}


class button extends StatelessWidget {
  const button({super.key,this.text,this.icon,this.next_page});
  final text;
  final icon;
  final next_page;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => next_page)
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.grey.withOpacity(0.2);
              }
              return null;
            },
          ),
        ),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                child: Icon(icon,color: Colors.black,size: 25)),

            Text(text,style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w100
            )),
          ],
        ),
      ),
    );
  }
}



class header extends StatelessWidget {
  const header({super.key,this.front});
  final front;
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.fromLTRB(30, 10, 0,10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          Text('내 정보',style:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          ),
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => front)
            );
          }, icon: Icon(Icons.settings)),
        ],
      ),




    );
  }
}

class uni extends StatelessWidget {
  const uni({super.key,this.text,this.info});
  final text;
  final info;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 15, 20,15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$text : ',style: TextStyle(
              fontSize: 18,
            )),
            text =='속력' ? Text( '$info km/h',style: TextStyle(
                fontSize: 15,
                color: Colors.blue
            ))
                : Text( '$info',style: TextStyle(
                fontSize: 15,
                color: Colors.blue
            )),


          ],
        )
    );
  }
}