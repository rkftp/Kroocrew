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
authnumAccesstrue() {
  authnumAccess = true;
}
authnumAccessfalse() {
  authnumAccess = false;
}


class email extends ConsumerStatefulWidget {
  const email({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _emailState();
}

class _emailState extends ConsumerState<email> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  @override


  Widget build(BuildContext context, ) {
    final emailController = ref.watch(emailControllerProvider);
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
                      child: Text('회원가입',style:TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 40),
                      child: Text('가입을 통해 더 다양한 서비스를 만나보세요!',style:TextStyle(
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
                                  final EmailDTO = emailDTO(email: emailController.text);
                                  ref.read(emailProvider.notifier).email(EmailDTO,context,ref);
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
                    Container(
                        height: 70,
                        width: 450,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: TextField(
                          obscureText: true,
                          controller: authnumController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(), // 네모난 테두리
                            hintText: '인증번호 입력',
                          ),
                        )
                    ),

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
                        child: TextButton( onPressed: () async{

                          if(emailAccess == true ) {
                            final AuthnumDTO = authnumDTO(email: emailController.text, authnum: authnumController.text);
                            await ref.read(authnumProvider.notifier).authnum(AuthnumDTO,context,ref);
                            if(authnumAccess == true) {Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => sign_up.sign_up())
                            );} else {print('실패~~');}
                          } else{
                            print("애송이");// 밑에 띄워야겠지?
                          }

                        },
                          child: Text("다음",style: TextStyle(
                              color:Colors.black
                          ),), )
                    )

                  ]
              )
          )
      ),


    );
  }
}

class text extends StatelessWidget {
  const text({super.key,this.al});
  final al;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.centerLeft,
      child: Text('${al}: ',style: TextStyle(
          fontSize: 14,
          color: Colors.grey
      )),
    );
  }
}
class box extends StatelessWidget {
  const box({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.fromLTRB(40, 0, 20, 20),
      child: TextField(
          decoration: InputDecoration(
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
          child: Text('email로 인증번호가 발송되었습니다..',style: TextStyle(
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
