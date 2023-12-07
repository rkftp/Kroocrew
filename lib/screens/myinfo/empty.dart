import 'package:contact/screens/login/find_pw_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/signup_provider.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import '/utils/token_keybox.dart';
final TextEditingController oldpwController = TextEditingController();
final TextEditingController newpwControllerA = TextEditingController();
final TextEditingController newpwControllerA1 = TextEditingController();


var pwAccess = false;
var pwRule = false;

bool checknew = false;

setchecknewtrue(){
  checknew = true;
}
setchecknewfalse(){
  checknew = false;
}

Future<void> Changepw(oldpw,newpw) async {
  Dio _dio = Dio();
  late String? storedToken;
  KeyBox _keyBox = KeyBox().to();
  storedToken = await _keyBox.getToken();
  final response = await _dio.post('http://20.39.186.138:1234/set_new_pw', data:{
    "current_password" : oldpw,
    "new_password" : newpw,
  }, options: Options(
    headers: {'Authorization': '${storedToken}'},
  ));
  print("\n토큰저장 성공, ${response}");
  print(response.data);



  try {
    if (response.statusCode == 200) {
      print("성공");
      if(response.data['success'] == true){
        print("쌉가능");
        setchecktrue();
      }else{
        print("불가능");
        setcheckfalse();
      }
    } else {
      print("이미있다 아가야");
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}






class change_pw extends ConsumerStatefulWidget {
  const change_pw({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _change_pwState();
}

class _change_pwState extends ConsumerState<change_pw> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    newpwControllerA.addListener(_validatePassword);
    newpwControllerA1.addListener(_validatePassword);
  }
  @override
  void dispose() {
    newpwControllerA.removeListener(_validatePassword);
    newpwControllerA1.removeListener(_validatePassword);

    newpwControllerA.dispose();
    newpwControllerA1.dispose();
    super.dispose();
  }
  void _validatePassword() {
    String password = newpwControllerA.text;
    bool hasMinLength = password.length >= 8;
    bool hasMaxLength = password.length <= 20;
    bool hasNoSpaces = !password.contains(' ');
    bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    bool hasDigit = password.contains(RegExp(r'\d'));
    bool hasSpecialCharacter = password.contains(RegExp(r'[\W_]'));

    setState(() {
      pwRule = hasMinLength && hasMaxLength && hasNoSpaces && hasLetter && hasDigit && hasSpecialCharacter;
      pwAccess = newpwControllerA.text == newpwControllerA1.text;
    });
  }

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
                        child: Text('비밀번호 변경',style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 40),
                        child: Text('현재 비밀번호와 새 비밀번호를 입력하세요.',style:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                      Container(

                          height: 70,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
                            controller: oldpwController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '현재 비밀번호',
                            ),
                          )
                      ),
                      Container(

                          height: 70,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
                            controller: newpwControllerA,
                            obscureText:true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '새 비밀번호(문자, 숫자, 특수문자 포함 8~20자)',
                            ),
                          )
                      ),
                      Container(

                          height: 70,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
                            controller: newpwControllerA1,
                            obscureText:true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '비밀번호 재확인',
                            ),
                          )
                      ),
                      pw_test(),
                      Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),

                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 0,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ]
                          ),
                          child: TextButton( onPressed: ()async{
                            if(pwAccess == true) {
                              await Changepw(oldpwController.text,newpwControllerA.text) ;
                              if(check == true) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: '변경에 성공했습니다.',
                                  confirmBtnText: '확인',
                                  confirmBtnColor: Color(0xFF7365F8),
                                  onConfirmBtnTap: () {
                                    oldpwController.text = '';
                                    newpwControllerA.text = '';
                                    newpwControllerA1.text = '';
                                    context.pop();
                                    context.go("/myinfo");
                                  },

                                );

                              } else {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: '현재 비밀번호를 확인해 주세요.',
                                  confirmBtnText: '확인',
                                  confirmBtnColor: Color(0xFF7365F8),
                                  onConfirmBtnTap: () {
                                    context.pop();
                                  },
                                );

                              }
                            } else{
                              print("애송이");
                            }

                          },
                            child: Text("변경",style: TextStyle(
                                color:Colors.black
                            ),), )
                      )



                    ]
                )
            )
        ),
      ),


    );
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
    if(pwRule == false){
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
        child: Text('형식에 맞지 않는 비밀번호 입니다.',style: TextStyle(
            color: Colors.red
        ),),
      );
    }else{}
    if(pwAccess == false) {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
        child: Text('비밀번호가 일치하지 않습니다.',style: TextStyle(
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