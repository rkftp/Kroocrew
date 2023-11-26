import 'package:flutter/material.dart';
import 'find_id.dart' as find_id;
import 'find_pw.dart' as find_pw;
import 'sign_up.dart' as sign_up;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
final TextEditingController idController = TextEditingController();
final TextEditingController pwController = TextEditingController();

class LoginDTO {
  String id;
  String password;

  LoginDTO ({
    required this.id,
    required this.password
  });

  LoginDTO copyWith({
    String? id,
    String? password,
  }) {
    return LoginDTO(
      id: id ?? this.id,
      password: password ?? this.password,
    );
  }
}

class loginService {
  Future<void> login(LoginDTO loginDTO, BuildContext context) async {
    final dio = Dio();
    print('로그인 시도: ${loginDTO.id}, ${loginDTO.password}');

    final response = await dio.post('http://20.39.186.138:1234/login', queryParameters: {
      'Student_id' : loginDTO.id,
      'Student_pw' : loginDTO.password,
    });

    print('로그인 응답: ${response.data}');
    print('로그인 응답2: ${response.data['success']}');
    if (response.data['success'] == true) {
      // 로그인 성공
      await storage.write(key: 'id', value: loginDTO.id);
      await storage.write(key: 'password', value: loginDTO.password);
      Get.snackbar('로그인 성공', '로그인 성공');
      // Navigator.pushNamed(context, '/main');
    } else {
      // 로그인 실패
      Get.snackbar('로그인 실패', '로그인 실패');
    }
  }
}


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
                decoration: InputDecoration(
                )
            ),
          ),
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
        child: TextButton( onPressed: () {final loginDTO = LoginDTO(
          id: idController.text,
          password: pwController.text,
        );

        // 로그인 서비스 호출
        loginService().login(loginDTO, context);}, child: Text("로그인",style: TextStyle(
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
          /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => next_page)
          );*/
        }, child: Text(text ,style: TextStyle(
            color:Colors.grey,
            fontSize: 14,
        ),), )
    );
  }
}

