import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/signup_provider.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
final TextEditingController emailController2 = TextEditingController();
String id ='';
bool target = false;
settargettrue(){
  target = true;
}
settargetfalse(){
  target = false;
}

Future<void> duplicatedId(text) async {
  Dio _dio = Dio();
  final response = await _dio.get('http://20.39.186.138:1234/find_id_by_email?email=${text}');
  print("\n토큰저장 성공, ${response}");

  print('email: ${text}');
  print('아이디: ${response.data["Student_id"]}');

  try {
    if (response.statusCode == 200) {
      print("성공");
      if(response.data['success'] == true){
        print("쌉가능");
        id = response.data['Student_id'];
        print(id);
        settargettrue();

      }else{
        print("불가능");
        id = '';
        settargetfalse();

      }
    } else {
      print("이미있다 아가야");
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}

bool isEmailValid(String email) {
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    caseSensitive: false,
    multiLine: false,
  );

  return emailRegExp.hasMatch(email);
}

var emailAccess1 = false;
emailAccesstrue() {
  emailAccess1 = true;
}
emailAccessfalse() {
  emailAccess1 = false;
}
var emailRule1 = false;



class find_id extends ConsumerStatefulWidget {
  const find_id({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _find_idState();
}

class _find_idState extends ConsumerState<find_id> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  @override


  Widget build(BuildContext context, ) {


    return Scaffold(
      body:SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
            child:Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Text('아이디 찾기',style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 40),
                        child: Text('이메일과 연동된 아이디를 알려드립니다.',style:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(

                              height: 70,
                              width: 300,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: TextField(
                                controller: emailController2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'email 입력',
                                ),
                              )
                          ),
                          Container(

                              height: 70,
                              padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child:ElevatedButton(
                                onPressed: ()async{
                                  if (isEmailValid(emailController2.text)==true) {
                                    setState(() {
                                      emailRule1 = true;
                                    });
                                    await duplicatedId(emailController2.text);
                                    target == true
                                        ?
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: '등록된 ID는 ${id} 입니다.',
                                      confirmBtnText: '확인',
                                      confirmBtnColor: Color(0xFF7365F8),
                                      onConfirmBtnTap: () {
                                        context.pop();
                                        context.go('/login');
                                      } ):
                                      QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: '등록된 ID 가 없습니다.',
                                      confirmBtnText: '확인',
                                      confirmBtnColor: Color(0xFF7365F8),
                                      onConfirmBtnTap: () {
                                      context.pop();
                                      },

                                    );

                                  } else {
                                    setState(() {
                                      emailRule1 = false;
                                    });
                                  }
                                },
                                child: Text('Id 찾기'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xff473CCE)), // 여기에서 색상을 설정
                                ),
                              )
                          )
                        ],
                      ),

                    ]
                )
            )
        ),
      ),


    );
  }
}



