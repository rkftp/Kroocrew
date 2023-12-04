import 'package:contact/screens/login/sign_up.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'auth.dart';
import '/utils/dio_service.dart';
import 'dart:convert';


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

    Dio _dio = Dio(); // dio_service에서 생성한 객체를 가져옵니다.



    final response = await _dio.post('http://20.39.186.138:1234/signup', data: {
      "Student_id" : signupDTO.id,
      "Student_pw" : signupDTO.pw,
      "portal_id" : signupDTO.potalid,
      "portal_pw" : signupDTO.potalpw,
    }); // baseOption에 url을 미리 세팅해두었기에, 이어질 url만 사용합니다.
    print("\n토큰저장 성공, ${response}");

    print('회원가입 시도: ${signupDTO.id}, ${signupDTO.pw},${signupDTO.potalid}, ${signupDTO.potalpw}');

    try {
      if (response.statusCode == 200) {
        print("성공");
        Navigator.pop(context);

        print("찐성공");

      } else {
        print("되겠냐 ㅋ");
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}