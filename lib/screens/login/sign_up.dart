import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/signup_provider.dart';
import '/utils/token_keybox.dart';
import '/utils/dio_service.dart';
import 'package:go_router/go_router.dart';



final TextEditingController idController = TextEditingController();
final TextEditingController pwController = TextEditingController();
final TextEditingController potalidController = TextEditingController();
final TextEditingController potalpwController = TextEditingController();







class sign_up extends ConsumerWidget {
  const sign_up({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body:Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
            children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(al: '아이디'),
                Container(
                  height: 50,
                  width: 250,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(40, 0, 20, 20),
                  child: TextField(
                      controller: idController,
                      decoration: InputDecoration(
                      )
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(al: '비밀번호'),
                Container(
                  height: 50,
                  width: 250,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(40, 0, 20, 20),
                  child: TextField(
                      controller: pwController,
                      decoration: InputDecoration(
                      )
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(al: '포탈 아이디'),
                Container(
                  height: 50,
                  width: 250,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(40, 0, 20, 20),
                  child: TextField(
                      controller: potalidController,
                      decoration: InputDecoration(
                      )
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(al: '포탈 비밀번호'),
                Container(
                  height: 50,
                  width: 250,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(40, 0, 20, 20),
                  child: TextField(
                      controller: potalpwController,
                      decoration: InputDecoration(
                      )
                  ),
                ),
              ],
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
                  child: TextButton( onPressed: () {
                    final signupDTO = SignupDTO(id: idController.text, pw: pwController.text, potalid: potalidController.text, potalpw: potalpwController.text);
                    ref.read(signupProvider.notifier).signup(signupDTO,context,ref);
                  },
                    child: Text("회원가입",style: TextStyle(
                        color:Colors.black
                    ),), )
              )

          ]
        )
      )
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
