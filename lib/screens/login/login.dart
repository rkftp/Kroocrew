import 'package:flutter/material.dart';
import 'package:contact/providers/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'find_id.dart' as find_id;
import 'find_pw.dart' as find_pw;
import 'sign_up.dart' as sign_up;
import 'email.dart' as email;


final TextEditingController idController = TextEditingController();
final TextEditingController pwController = TextEditingController();



class login extends ConsumerWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body:SingleChildScrollView(
          child:Container(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                    child: Text('Kroocrew',style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff473CCE),
                    ),)
                ),
                box1(),
                login_button(),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: TextButton( onPressed: () {
                              context.push('/login/findid');
                            }, child: Text('아이디 찾기' ,style: TextStyle(
                              color:Colors.grey,
                              fontSize: 14,
                            ),), )
                        ),
                        Container(
                            child: TextButton( onPressed: () {
                              context.push('/login/findpwemail');
                            }, child: Text('비밀번호 재설정' ,style: TextStyle(
                              color:Colors.grey,
                              fontSize: 14,
                            ),), )
                        ),
                        Container(
                            child: TextButton( onPressed: () {
                              context.push('/login/email');
                            }, child: Text('회원가입' ,style: TextStyle(
                              color:Colors.grey,
                              fontSize: 14,
                            ),), )
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
      ),
    );
  }
}

class box1 extends StatefulWidget {
  const box1({super.key});

  @override
  State<box1> createState() => _box1State();
}

class _box1State extends State<box1> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
              children: [
                id_text(),
                Container(
                  height: 30,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(
                      controller: idController,
                      decoration: InputDecoration(
                      )
                  ),
                ),
                pw_text(),
                Container(
                  height: 30,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(
                      controller: pwController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                      )
                  ),
                ),

              ]
          ),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 9, 20, 10),
            child: IconButton(
              icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility,color:  Colors.grey),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class id_text extends StatelessWidget {
  const id_text({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text('아이디',style: TextStyle(
        fontSize: 14,
        color: Colors.grey
      )),
    );
  }
}

class pw_text extends StatelessWidget {
  const pw_text({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text('비밀번호',style: TextStyle(
          fontSize: 14,
          color: Colors.grey
      )),
    );
  }
}



class login_button extends ConsumerWidget {
  const login_button({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
        child: TextButton( onPressed: () {
          final loginDTO = LoginDTO(id: idController.text, password: pwController.text);
          ref.read(loginProvider.notifier).login(loginDTO, context, ref);
          },
          child: Text("로그인",style: TextStyle(
            color:Colors.black
        ),), )
    );
  }
}

class box2 extends ConsumerWidget {
  const box2({super.key});

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          button(text:'아이디 찾기',next_page: find_id.find_id()),
          button(text:'비밀번호 찾기',next_page: find_pw.find_pw()),
          Container(
              child: TextButton( onPressed: () {
                context.go('/login/sign_up');
              }, child: Text('회원가입' ,style: TextStyle(
                color:Colors.grey,
                fontSize: 14,
              ),), )
          )
        ],
      )
    );
  }
}

class button extends StatelessWidget {
  const button({super.key,this.text,this.next_page});
  final text;
  final next_page;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton( onPressed: () {

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => next_page)
          );
        }, child: Text(text ,style: TextStyle(
            color:Colors.grey,
            fontSize: 14,
        ),), )
    );
  }
}

