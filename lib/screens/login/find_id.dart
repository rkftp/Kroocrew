import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/signup_provider.dart';
import 'sign_up.dart' as sign_up;


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
    final emailController = ref.watch(emailControllerProvider);
    final emailState = ref.watch(findidProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff473CCE),
      ),
      body:isLoading
          ? Center(child: CircularProgressIndicator()) // 로딩 중이면 인디케이터 표시
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
                              controller: emailController,
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
                              onPressed: (){

                                if (isEmailValid(emailController.text)==true) {
                                  setState(() {
                                    emailRule = true;
                                  });
                                  final findidDTO = emailDTO(email: emailController.text);
                                  ref.read(findidProvider.notifier).email(findidDTO,context,ref);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('내용 수정'),
                                        content: Container(
                                          width: double.maxFinite, // 팝업의 너비를 최대로 설정
                                          child: Text('니 아이디는')
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

                                              Navigator.of(context).pop(); // 팝업 닫기
                                            },
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
                              child: Text('인증요청'),
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
