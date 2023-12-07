import 'package:contact/screens/login/email.dart';
import 'package:contact/screens/login/sign_up.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'auth.dart';
import '/utils/dio_service.dart';
import 'dart:convert';


final emailControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

class emailDTO {
  String email;

  emailDTO({
    required this.email,
});
  emailDTO copyWith({
    String? email,
}) {
    return emailDTO(
      email: email ?? this.email,
    );
  }
}


final emailProvider = StateNotifierProvider<emailController, emailDTO>((ref) {
  return emailController();
});
class emailController extends StateNotifier<emailDTO> {
  emailController() : super(emailDTO(email: ''));

  void setemail(String email) {
    state = state.copyWith(email: email);
  }
  Future<void> email(emailDTO emailDTO, BuildContext context, WidgetRef ref) async {
    Dio _dio = Dio();
    final response = await _dio.get('http://20.39.186.138:1234/verify1?email=${emailDTO.email}');
    print("\n토큰저장 성공, ${response}");

    print('email 전송: ${emailDTO.email}');

    try {
      if (response.statusCode == 200) {
        print("성공");
        if(response.data['success'] == true){
          print("쌉가능");
          emailAccesstrue();
        }else{
          print("불가능");
          emailAccessfalse();
        }

      } else {
        print("이미있다 아가야");
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}

class authnumDTO {
  String email;
  String authnum;

  authnumDTO({
    required this.email,
    required this.authnum,
  });
  authnumDTO copyWith({
    String? email,
    String? authnum,
  }) {
    return authnumDTO(
      email:email ?? this.email,
      authnum:authnum ?? this.authnum,
    );
  }
}
final authnumProvider = StateNotifierProvider<authnumController, authnumDTO>((ref) {
  return authnumController();
});
class authnumController extends StateNotifier<authnumDTO> {
  authnumController() : super(authnumDTO(email: '',authnum: ''));

  void setemail(String email) {
    state = state.copyWith(email:email);
  }
  void setauthnum(String authnum) {
    state = state.copyWith(authnum: authnum);
  }
  Future<void> authnum(authnumDTO authnumDTO, BuildContext context, WidgetRef ref) async {
    Dio _dio = Dio();
    final response = await _dio.post('http://20.39.186.138:1234/verify2',data: {

      "email": authnumDTO.email,
      "user_token": authnumDTO.authnum
    });
    print("\n토큰저장 성공, ${response}");

    print('authnum 전송: ${authnumDTO.email},${authnumDTO.authnum}');

    try {
      if (response.statusCode == 200) {
        print("성공");
        if(response.data['success'] == true){
          print("쌉가능");
          authnumAccesstrue();
        }else{
          print("불가능");
          authnumAccessfalse();
        }

      } else {
        print("이미있다 아가야");
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}

class IDcheckDTO {
  String id;

  IDcheckDTO({
    required this.id,
  });

  IDcheckDTO copyWith({
    String? id,
  }) {
    return IDcheckDTO(
      id: id ?? this.id,
    );
  }
}
final idcheckProvider = StateNotifierProvider<IdcheckController, IDcheckDTO>((ref) {
  return IdcheckController();
});
class IdcheckController extends StateNotifier<IDcheckDTO> {
  IdcheckController() : super(IDcheckDTO(id: ''));

  void setId(String id) {
    state = state.copyWith(id: id);
  }
  Future<void> signup(IDcheckDTO IDcheckDTO, BuildContext context, WidgetRef ref) async {

    Dio _dio = Dio(); // dio_service에서 생성한 객체를 가져옵니다.



    final response = await _dio.get('http://20.39.186.138:1234/id_duplicate_check?Student_id=${IDcheckDTO.id}');
    print("\n토큰저장 성공, ${response}");

    print('ID 중복확인: ${IDcheckDTO.id}');

    try {
      if (response.statusCode == 200) {
        print("성공");
        if(response.data['success'] == true){
          print("쌉가능");
          idAccesstrue();
        }else{
          print("불가능");
          idAccessfalse();
        }

      } else {
        print("이미있다 아가야");
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}

class SignupDTO {
  String id;
  String pw;
  String potalid;
  String potalpw;
  String email;

  SignupDTO ({
    required this.id,
    required this.pw,
    required this.potalid,
    required this.potalpw,
    required this.email,
  });

  SignupDTO copyWith({
    String? id,
    String? pw,
    String? potalid,
    String? potalpw,
    String? email,
  }) {
    return SignupDTO(
      id: id ?? this.id,
      pw: pw ?? this.pw,
      potalid: potalid ?? this.potalid,
      potalpw: potalpw ?? this.potalpw,
      email:email ?? this.email,
    );
  }
}
final signupProvider = StateNotifierProvider<SignupController, SignupDTO>((ref) {
  return SignupController();
});
class SignupController extends StateNotifier<SignupDTO> {
  SignupController() : super(SignupDTO(id: '', pw: '',potalid: '', potalpw: '',email: ''));

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
  void setemail(String email) {
    state = state.copyWith(email:email);
  }
  Future<void> signup(SignupDTO signupDTO, BuildContext context, WidgetRef ref) async {

    Dio _dio = Dio(); // dio_service에서 생성한 객체를 가져옵니다.


    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      text: '회원가입이 진행 중 입니다. ',

      confirmBtnColor: Color(0xFF7365F8),
      onConfirmBtnTap: () {
        context.pop();
      },

    );

    final response = await _dio.post('http://20.39.186.138:1234/signup', data: {
      "Student_id" : signupDTO.id,
      "Student_pw" : signupDTO.pw,
      "portal_id" : signupDTO.potalid,
      "portal_pw" : signupDTO.potalpw,
      "email" : signupDTO.email,
    }); // baseOption에 url을 미리 세팅해두었기에, 이어질 url만 사용합니다.
    print("\n토큰저장 성공, ${response}");

    print('회원가입 시도: ${signupDTO.id}, ${signupDTO.pw},${signupDTO.potalid}, ${signupDTO.potalpw},${signupDTO.email}');

    try {
      if (response.statusCode == 200) {
        print("성공");
        if(response.data['success'] == true){
          print("쌉가능");
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: '회원가입을 성공적으로 완료하였습니다.',
            confirmBtnText: '확인',
            confirmBtnColor: Color(0xFF7365F8),
            onConfirmBtnTap: () {
              context.pop();
              context.go('/login');
            },

          );

        }else{
          print("불가능");

        }
        print("찐성공");

      } else {
        print("되겠냐 ㅋ");
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}