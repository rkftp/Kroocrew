import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import '/utils/token_keybox.dart';
import '/utils/dio_service.dart';

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

class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier() : super(false);

  void setAuthState(bool isLoggedIn) {
    state = isLoggedIn;
  }
}
final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) => AuthStateNotifier());

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

    Dio _dio = DioServices().to(); // dio_service에서 생성한 객체를 가져옵니다.
    KeyBox _keyBox = KeyBox().to(); // token_keybox에서 생성한 객체를 가져옵니다.

    print("\n1111111111");

    final response = await _dio.post('/login', queryParameters: {
      'Student_id' : loginDTO.id,
      'Student_pw' : loginDTO.password,
    }); // baseOption에 url을 미리 세팅해두었기에, 이어질 url만 사용합니다.

    print('로그인 시도: ${loginDTO.id}, ${loginDTO.password}');

    try {
      if (response.statusCode == 200) {
        String? token = response.data['token'];

        if(token != null) {
          print("token success: ${token}");

          _keyBox.deleteToken();
          _keyBox.setToken(token);

          ref.read(authStateProvider.notifier).setAuthState(true);
          context.go('/');

        }else {
          print("token fail");
          token = null;
          _keyBox.deleteToken();
        }

      } else {
        //snackbar
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}