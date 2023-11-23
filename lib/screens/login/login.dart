import 'package:flutter/material.dart';
import 'find_id.dart' as find_id;
import 'find_pw.dart' as find_pw;
import 'sign_up.dart' as sign_up;


class login extends StatelessWidget {
  const login({super.key, this.loginAcc});
  final loginAcc;
  @override
  Widget build(BuildContext context) {
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
                        color: Colors.blue
                    ),)
                ),
                box1(),
                login_button(loginAcc: loginAcc,),
                box2(),
              ],
            ),
          ),
      ),
    );
  }
}

class box1 extends StatelessWidget {
  const box1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          id_text(),
          id_box(),
          pw_text(),
          pw_box(),
        ],
      )
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

class id_box extends StatelessWidget {
  const id_box({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
          decoration: InputDecoration(
          )
      ),
    );
  }
}

class pw_box extends StatelessWidget {
  const pw_box({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
          obscureText: true,
          decoration: InputDecoration(
          )
      ),
    );
  }
}

class login_button extends StatelessWidget {
  const login_button({super.key,this.loginAcc});
  final loginAcc;
  @override
  Widget build(BuildContext context) {
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
        child: TextButton( onPressed: () {loginAcc();}, child: Text("로그인",style: TextStyle(
            color:Colors.black
        ),), )
    );
  }
}

class box2 extends StatelessWidget {
  const box2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          button(text:'아이디 찾기',next_page: find_id.find_id()),
          button(text:'비밀번호 찾기',next_page: find_pw.find_pw()),
          button(text: '회원가입', next_page:sign_up.sign_up())
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

