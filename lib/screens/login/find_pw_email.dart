import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

final TextEditingController idController2 = TextEditingController();
bool check = false;

setchecktrue(){
 check = true;
}
setcheckfalse(){
  check = false;
}
Future<void> duplicatedId(text) async {
  Dio _dio = Dio();
  final response = await _dio.get('http://20.39.186.138:1234/find_pw_by_email_token_insert?Student_id=${text}');
  print("\n토큰저장 성공, ${response}");
  print('id: ${text}');

  try {
    if (response.statusCode == 200) {
      print("성공");
      if(response.data['success'] == true){
          setchecktrue();
      }else{
        setcheckfalse();
      }
    } else {
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}





class find_pw_email extends ConsumerStatefulWidget {
  const find_pw_email({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _find_pw_emailState();
}

class _find_pw_emailState extends ConsumerState<find_pw_email> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  @override


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
                        child: Text('비밀번호 재설정',style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 40),
                        child: Text('ID 정보를 입력하면 연동된 이메일로 인증코드를 보내드립니다.',style:TextStyle(
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
                                controller: idController2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'ID',
                                ),
                              )
                          ),
                          Container(

                              height: 70,
                              padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child:ElevatedButton(
                                onPressed: ()async{
                                    await duplicatedId(idController2.text);
                                    if(check == true) {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: '인증번호가 전송되었습니다.',
                                        confirmBtnText: '확인',
                                        confirmBtnColor: Color(0xFF7365F8),
                                        onConfirmBtnTap: () {
                                          idController2.text = '';
                                          context.pop();
                                          context.go('/login/findpwemail/findpw');
                                        },

                                      );

                                    } else {
                                      QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: '인증 요청이 실패했습니다. 다시 시도해 주세요.',
                                      confirmBtnText: '확인',
                                      confirmBtnColor: Color(0xFF7365F8),
                                      onConfirmBtnTap: () {
                                      context.pop();
                                      },
                                      );
                                    }
                                },
                                child: Text('인증 요청'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xff473CCE)), // 여기에서 색상을 설정
                                ),
                              )
                          )
                        ],
                      ),
                    ]
                )
            )
        ),
      ),


    );
  }
}



