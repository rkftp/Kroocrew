import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'token_keybox.dart';

class DioServices {
  static final DioServices _dioServices = DioServices._internal();
  factory DioServices() => _dioServices;
  Map<String, dynamic> dioInformation= {};

  KeyBox _keyBox = KeyBox().to();
  late String? storedToken;

  static Dio _dio = Dio();

  DioServices._internal() {
    _initializeDio(); // 비동기 메서드 호출을 위한 초기화 메서드 호출
  }

  Future<void> _initializeDio() async {
    /*print('\ndio실행이 시작됐습니다\n');
    storedToken = await _keyBox.getToken();
    print('토큰 저장이 성공했습니다: $storedToken');*/
    BaseOptions _options = BaseOptions(
        baseUrl: 'http://20.39.186.138:1234',
    );

    _dio = Dio(_options);
    print('dio실행이 끝났습니다\n');
    // _dio.interceptors.add(DioInterceptor()); --> 인터셉터 추가 (추후 구현)
  }

  Dio to() => _dio;
}


