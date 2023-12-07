import 'package:contact/providers/mypageProvider.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/utils/token_keybox.dart';
import 'empty.dart'as empty;

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '0.Head.dart' as Head;





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

class Setting extends ConsumerStatefulWidget {

  const Setting({Key? key,this.loginDacc, this.user_name,this.user_uni_name,this.user_dep_name,this.user_num,this.user_speed,this.user_id}) : super(key: key);
  final loginDacc;
  final user_name;
  final user_uni_name;
  final user_dep_name;
  final user_num;
  final user_speed;
  final user_id;
  @override
  ConsumerState createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {


  @override

  Widget build(BuildContext _context) {
    return Scaffold(
      body: Container(
        color: Color(0xffEEEEEE),
        child: ListView(

          children: [
            Head.head(),
            button(text:'개인정보',icon:Icons.person_outlined),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(10),
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    uni(text: '학교',info:widget.user_uni_name),
                    uni(text: '학과',info:widget.user_dep_name),
                    uni(text: '학번',info:widget.user_num),
                    uni(text: '속도',info:widget.user_speed),

                  ]
              ),
            ),

            button(text:'계정', icon:Icons.lock_outline),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    uni(text: '아이디',info: widget.user_id),
                    button_1(text:'비밀번호 변경',front: empty.change_pw(),),
                    button_3( text: '회원탈퇴'),
                    button_2( text: '로그아웃',),

                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class button extends StatelessWidget {
  const button({super.key,this.text,this.icon});
  final text;
  final icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                child: Icon(icon,color: Colors.black,size: 25)),

            Text(text,style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w100
            )),
          ],
        ),
    );
  }
}

class uni extends ConsumerStatefulWidget {
  const uni({Key? key,this.text,this.info}) : super(key: key);
  final text;
  final info;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _uniState();
}

class _uniState extends ConsumerState<uni> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20,0),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.text} : ',style: TextStyle(
              fontSize: 18,
              color: Color(0xff777777)
            )),
            widget.text =='속도' ? Text( '${widget.info} km/h',style: TextStyle(
                fontSize: 15,
                color: Color(0xFF7365F8)
            ))
                : Text( '${widget.info}',style: TextStyle(
                fontSize: 15,
                color: Color(0xFF7365F8)
            )),


          ],
        )
    );
  }
}



class button_1 extends ConsumerWidget {
  const button_1({super.key,this.text,this.front});
  final text;
  final front;
  @override
  Widget build(BuildContext context,WidgetRef ref ) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => front)
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
              color: Color(0xff777777),
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
      height: 60,
      child: ElevatedButton(
          onPressed: (){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              text: '로그아웃 하시겠습니까?',
              confirmBtnText: '네',
              confirmBtnColor: Color(0xFF7365F8),
              onConfirmBtnTap: () {
                context.pop();
                context.go("/login");
              },

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
              color: Color(0xff777777),
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
      height: 60,
      child: ElevatedButton(
          onPressed: (){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.warning,
              text: '정말 탈퇴 하시겠습니까?',
              confirmBtnText: '네',
              confirmBtnColor: Color(0xFF7365F8),
              onConfirmBtnTap: () async{
                await signout();
                KeyBox _keyBox = KeyBox().to();
                _keyBox.deleteToken();
                context.pop();
                context.go("/login");
              },


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
              color: Color(0xff777777),
              fontSize: 18,

            ),),
          )
      ),
    );

  }
}