import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/signup_provider.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

final TextEditingController emailController2 = TextEditingController();
String id ='';
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
      }else{
        print("불가능");
        id = '';

      }
    } else {
      print("이미있다 아가야");
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}
final TextEditingController authnumController = TextEditingController();
bool isEmailValid(String email) {
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    caseSensitive: false,
    multiLine: false,
  );

  return emailRegExp.hasMatch(email);
}

var emailAccess = false;
emailAccesstrue() {
  emailAccess = true;
}
emailAccessfalse() {
  emailAccess = false;
}
var emailRule = false;
var authnumAccess = false;



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
                                      emailRule = true;
                                    });
                                    await duplicatedId(emailController2.text);
                                     showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Id 확인'),
                                          content: Container(
                                            width: double.maxFinite, // 팝업의 너비를 최대로 설정
                                            child: id !='' ? Text('등록된 ID는 ${id} 입니다.') :Text('이메일과 연동된 ID 가 없습니다.')
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('확인'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                context.go('/login');                                              },
                                            ),

                                            // 수정된 텍스트 표시
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    setState(() {
                                      emailRule = false;
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
                      id_test(),


                    ]
                )
            )
        ),
      ),


    );
  }
}



class id_test  extends ConsumerStatefulWidget {
  const id_test({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _id_testState();
}

class _id_testState  extends ConsumerState<id_test> {
  @override
  Widget build(BuildContext context) {
    final emailController = ref.watch(emailControllerProvider);
    if(emailController.text.isEmpty) {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
      );
    }else{
      if(emailRule == false) {
        return Container(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
          child: Text('이메일 형식이 아닙니다..',style: TextStyle(
              color: Colors.red
          ),),
        );
      }else{
        return Container(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
          child: Text('이건 뜨면 안됨 ㅋ',style: TextStyle(
              color: Colors.blue
          ),),
        );
      }
    }

  }

}
class pw_test  extends StatefulWidget {
  const pw_test({super.key});

  @override
  State<pw_test> createState() => _pw_testState();
}

class _pw_testState  extends State<pw_test> {
  @override
  Widget build(BuildContext context) {
    if(authnumAccess == false) {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
        child: Text('인증번호가 일치하지 않습니다.',style: TextStyle(
            color: Colors.red
        ),),
      );
    }else{
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),

      );
    }
  }
}
