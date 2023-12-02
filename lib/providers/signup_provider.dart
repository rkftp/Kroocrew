import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import '/utils/token_keybox.dart';
import '/utils/dio_service.dart';




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
class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier() : super(false);

  void setAuthState(bool isLoggedIn) {
    state = isLoggedIn;
  }
}
final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) => AuthStateNotifier());

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