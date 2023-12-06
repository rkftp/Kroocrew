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

class Interceptor {



  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return handler.resolve(response);
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return  handler.reject(dioError);
  }

  void onResponse(DioError err, ErrorInterceptorHandler handler) async {
    // Do something with response data
    KeyBox _keyBox = KeyBox().to();
    late String? storedToken;
    storedToken = await _keyBox.getToken();

    if(storedToken == null){
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;


    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return  handler.reject(dioError);
  }

  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Do something with response error
    return handler.next(err); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return handler.resolve(response);

  }
}

