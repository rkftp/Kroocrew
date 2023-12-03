import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/signup_provider.dart';

final TextEditingController idController = TextEditingController();
final TextEditingController pwController = TextEditingController();
final TextEditingController pwController1 = TextEditingController();
final TextEditingController potalidController = TextEditingController();
final TextEditingController potalpwController = TextEditingController();

var idAccess = false;
idAccesstrue() {
  idAccess = true;
}
idAccessfalse() {
  idAccess = false;
}
var idRule = false;
var pwAccess = false;
var pwRule = false;

class sign_up extends ConsumerStatefulWidget {
  const sign_up({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _sign_upState();
}

class _sign_upState extends ConsumerState<sign_up> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    pwController.addListener(_validatePassword);
    pwController1.addListener(_validatePassword);
  }

  @override
  void dispose() {
    pwController.removeListener(_validatePassword);
    pwController1.removeListener(_validatePassword);
    pwController.dispose();
    pwController1.dispose();
    super.dispose();
  }

  void _validatePassword() {
    String password = pwController.text;
    bool hasMinLength = password.length >= 8;
    bool hasMaxLength = password.length <= 20;
    bool hasNoSpaces = !password.contains(' ');
    bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    bool hasDigit = password.contains(RegExp(r'\d'));
    bool hasSpecialCharacter = password.contains(RegExp(r'[\W_]'));

    setState(() {
      pwRule = hasMinLength && hasMaxLength && hasNoSpaces && hasLetter && hasDigit && hasSpecialCharacter;
      pwAccess = pwController.text == pwController1.text;
    });
  }
  Widget build(BuildContext context, ) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff473CCE),
        ),
        body:SingleChildScrollView(
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
                        controller: idController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '아이디 입력(6~20자 사이)',
                        ),
                      )
                  ),
                  Container(

                      height: 70,
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child:ElevatedButton(
                      onPressed: (){

                        if (idController.text.length >= 6 && idController.text.length <= 20 && !idController.text.contains(' ')) {
                          setState(() {
                            idRule = true;
                          });
                          final idcheckDTO = IDcheckDTO(id: idController.text);
                          setState(() {
                            ref.read(idcheckProvider.notifier).signup(idcheckDTO,context,ref);
                          });


                        } else {
                          setState(() {
                            idRule = false;
                          });
                        }


                      },
                        child: Text('중복확인'),
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
                    controller: pwController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), // 네모난 테두리
                      hintText: '비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)',
                    ),
                  )
              ),
              Container(
                  height: 70,
                  width: 450,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: TextField(
                    obscureText: true,
                    controller: pwController1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '비밀번호 재입력',
                    ),
                  )
              ),
              pw_test(),
              Container(
                  height: 70,
                  width: 450,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: TextField(
                    controller: potalidController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '포탈 아이디',
                    ),
                  )
              ),
              Container(
                  height: 70,
                  width: 450,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: TextField(

                    controller: potalpwController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '포탈 비밀번호',
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
                  child: TextButton( onPressed: () {

                    if(idAccess == true && pwAccess == true) {
                      final signupDTO = SignupDTO(id: idController.text, pw: pwController.text, potalid: potalidController.text, potalpw: potalpwController.text);
                      ref.read(signupProvider.notifier).signup(signupDTO,context,ref);
                    } else{
                      print("애송이");// 밑에 띄워야겠지?
                    }

                  },
                    child: Text("회원가입",style: TextStyle(
                        color:Colors.black
                    ),), )
              )

          ]
        )
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
class id_test  extends StatefulWidget {
  const id_test({super.key});

  @override
  State<id_test> createState() => _id_testState();
}

class _id_testState  extends State<id_test> {
  @override
  Widget build(BuildContext context) {
    if(idController.text.isEmpty) {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
      );
    }else{
      if(idRule == false) {
        return Container(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
          child: Text('사용할 수 없는 아이디입니다.',style: TextStyle(
              color: Colors.red
          ),),
        );
      }else{
        if(idAccess == true) {
          return Container(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
            child: Text('사용 가능한 아이디입니다.',style: TextStyle(
                color: Colors.blue
            ),),
          );
        }else{
          return Container(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
            child: Text('이미 사용중인 아이디입니다.',style: TextStyle(
                color: Colors.red
            ),),
          );
        }
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
    if(pwRule == false){
      return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
      child: Text('형식에 맞지 않는 비밀번호 입니다.',style: TextStyle(
          color: Colors.red
      ),),
      );
    }else{}
    if(pwAccess == false) {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
        child: Text('비밀번호가 일치하지 않습니다.',style: TextStyle(
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
