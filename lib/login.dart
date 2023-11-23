
import 'package:flutter/material.dart';
import 'app.dart';

import 'package:dio/dio.dart';

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

Future<void> loginaction(LoginDTO loginDTO) async {
  final dio = Dio();

  print('로그인 시도: ${loginDTO.id}, ${loginDTO.password}');
  final response = await dio.get( 'http://20.39.186.138:1234/login', queryParameters: {
    'type': 'login',
    'id' : loginDTO.id,
    'pw' : loginDTO.password,
  });



  try {
    if (response.statusCode == 200) {
      print('로그인 성공: ${response}');
    } else {
      print('로그인 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('로그인 실패: ${e}');
  }
}

class login extends StatelessWidget {
  const login({super.key, this.loginAcc});
  final loginAcc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text('Kroocrew',style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
              ),)
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

                    width: 280,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(

                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                child: Text("id")),
                            Container(

                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                child: Text("pw")),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 200,
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'id 입력',

                                  )
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 200,
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'pw 입력',

                                  )
                              ),
                            ),
                            ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 80,
                      height: 50,
                      child: TextButton( onPressed: () {loginAcc();}, child: Text("로그인"), )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}