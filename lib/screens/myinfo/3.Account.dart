
import 'package:flutter/material.dart';
import 'package:contact/providers/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/utils/token_keybox.dart';
import 'package:dio/dio.dart';

import 'empty.dart';

KeyBox _keyBox = KeyBox().to();

Future<void> signout() async {
  Dio _dio = Dio(); // dio_service에서 생성한 객체를 가져옵니다.

  late String? storedToken;
  storedToken = await _keyBox.getToken();
  print("2");
  final response = await _dio.get('http://20.39.186.138:1234/signout',
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

class account extends StatelessWidget {
  const account({super.key,this.user_id,this.loginDacc});
  final user_id;
  final loginDacc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subject(text: '계정'),
              uni(text: 'id',info: user_id),
              button(text:'비밀번호 변경',next_page: empty(),),
              button_3( text: '회원탈퇴'),
              button_2( text: '로그아웃',),

            ]
        ),
      ),
    );


  }
}
class subject extends StatelessWidget {
  const subject({super.key,this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0,10),
      child: Row(
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back)),
          Text('$text',style:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffD9D9D9), // 아래쪽 변에 검은색 테두리를 적용합니다.
            width: 0.5, // 테두리의 두께를 1.0으로 설정합니다.
          ),
        ),
        // Container 내부는 투명으로 설정합니다.
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
class button extends StatelessWidget {
  const button({super.key,this.text,this.next_page});
  final text;
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
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 15, 20,15),
            alignment: Alignment.centerLeft,
            child: Text(text,style: TextStyle(
              color: Colors.black,
              fontSize: 18,

            ),),
          )
      ),
    );

  }
}
class button_2 extends ConsumerWidget {
  const button_2({super.key,this.text,});
  final text;
  @override
  Widget build(BuildContext context,WidgetRef ref ) {
    return Container(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
          onPressed: (){
            showDialog(
                context: context,
                barrierDismissible:true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      height: 50,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text('로그아웃 하시겠습니까?'),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: const Text('네'),
                            onPressed: () {
                              _keyBox.deleteToken();
                              context.go('/login');
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('아니오'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],

                  );
                }
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
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 15, 20,15),
            alignment: Alignment.centerLeft,
            child: Text(text,style: TextStyle(
              color: Colors.black,
              fontSize: 18,

            ),),
          )
      ),
    );

  }
}
class button_3 extends ConsumerWidget {
  const button_3({super.key,this.text,});
  final text;
  @override
  Widget build(BuildContext context,WidgetRef ref ) {
    return Container(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
          onPressed: (){
            showDialog(
                context: context,
                barrierDismissible:true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text('정말 탈퇴 하시겠습니까?'),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: const Text('네'),
                            onPressed: () async {
                              await signout();
                              KeyBox _keyBox = KeyBox().to();
                              _keyBox.deleteToken();
                              context.go('/login');
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('아니오'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],

                  );
                }
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
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 15, 20,15),
            alignment: Alignment.centerLeft,
            child: Text(text,style: TextStyle(
              color: Colors.black,
              fontSize: 18,

            ),),
          )
      ),
    );

  }
}