import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth.dart';
import '/utils/token_keybox.dart';
import '/utils/dio_service.dart';
import 'package:go_router/go_router.dart';


final TextEditingController idController = TextEditingController();
final TextEditingController pwController = TextEditingController();
final TextEditingController potalidController = TextEditingController();
final TextEditingController potalpwController = TextEditingController();

class SignupDTO {
  String id;
  String pw;
  String potalid;
  String potalpw;

  SignupDTO ({
    required this.id,
    required this.pw,
    required this.potalid,
    required this.potalpw
  });

  SignupDTO copyWith({
    String? id,
    String? pw,
    String? potalid,
    String? potalpw,
  }) {
    return SignupDTO(
      id: id ?? this.id,
      pw: pw ?? this.pw,
      potalid: potalid ?? this.potalid,
      potalpw: potalpw ?? this.potalpw,
    );
  }
}

final signupProvider = StateNotifierProvider<SignupController, SignupDTO>((ref) {
  return SignupController();
});

class SignupController extends StateNotifier<SignupDTO> {
  SignupController() : super(SignupDTO(id: '', pw: '',potalid: '', potalpw: ''));

  void setId(String id) {
    state = state.copyWith(id: id);
  }

  void setPw(String pw) {
    state = state.copyWith(pw: pw);
  }

  void setpotalId(String potalid) {
    state = state.copyWith(potalid: potalid);
  }
  void setpotalpw(String potalpw) {
    state = state.copyWith(potalpw: potalpw);
  }
  Future<void> signup(SignupDTO signupDTO, BuildContext context, WidgetRef ref) async {

    Dio _dio = DioServices().to(); // dio_service에서 생성한 객체를 가져옵니다.
    KeyBox _keyBox = KeyBox().to(); // token_keybox에서 생성한 객체를 가져옵니다.



    final response = await _dio.post('/signup', data: {
      "Student_id" : signupDTO.id,
      "Student_pw" : signupDTO.pw,
      "portal_id" : signupDTO.potalid,
      "portal_pw" : signupDTO.potalpw,
    }); // baseOption에 url을 미리 세팅해두었기에, 이어질 url만 사용합니다.


    print('회원가입 시도: ${signupDTO.id}, ${signupDTO.pw},${signupDTO.potalid}, ${signupDTO.potalpw}');

    try {
      if (response.statusCode == 200) {
        ref.read(authStateProvider.notifier).setAuthState(true);
        context.go('/');

      } else {
        //snackbar
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}





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
