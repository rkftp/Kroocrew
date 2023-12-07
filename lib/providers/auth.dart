import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

import '/utils/token_keybox.dart';

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

class AuthStateNotifier extends StateNotifier<String> {
  AuthStateNotifier() : super('');

  Future<void> setIdState(String ID) async {
    KeyBox _keyBox = KeyBox().to();
    String? token = await _keyBox.getToken();
    if (token != null) {
      state = ID;
    } else {
    }
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, String>((ref) => AuthStateNotifier());

final loginProvider = StateNotifierProvider<LoginController, LoginDTO>((ref) {
  return LoginController();
});


class LoginController extends StateNotifier<LoginDTO> {
  LoginController() : super(LoginDTO(id: '', password: ''));

  void setId(String id) {
    state = state.copyWith(id: id);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> login(LoginDTO loginDTO, BuildContext context, WidgetRef ref) async {

    Dio _dio = Dio();
    KeyBox _keyBox = KeyBox().to(); // token_keybox에서 생성한 객체를 가져옵니다.

    final response = await _dio.post('http://20.39.186.138:1234/login', data: {
      "Student_id" : loginDTO.id,
      "Student_pw" : loginDTO.password
    });
    print("\n토큰저장 성공, ${response}");

    print('로그인 시도: ${loginDTO.id}, ${loginDTO.password}');

    try {
      if (response.statusCode == 200 && response.data['success'] == true ) {
        String? token = response.data['token'];

          _keyBox.deleteToken();
          _keyBox.setToken(token!);

          print('토큰 저장 완료: $token');
          ref.read(authStateProvider.notifier).setIdState(loginDTO.id);
          context.go('/');
              }  else{
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'ID 또는 PW 가 틀렸습니다.',
          confirmBtnText: '확인',
          confirmBtnColor: Color(0xFF7365F8),
          onConfirmBtnTap: () {
            context.pop();
          },
        );
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}