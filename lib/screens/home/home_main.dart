import 'package:flutter/material.dart';
import '1.Head.dart' as Head;
import '2.Cal_Test.dart' as Cal_Test;
import '3.List.dart' as Middle_Cal;

import '/screens/login/login.dart' as login;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';


class getMainApi {
  Future<Map<String, dynamic>?> mainAPI( BuildContext context) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/main_page',
      queryParameters: {
        'year_semester' : '2023-3',
      },
      options: Options(
        headers: {'Authorization' :  '${storedToken}'},
      )
    );

    if (response.statusCode == 200) {
      print("성공해버린..");
      return response.data;
    } else {
      print('불러오기 실패' + response.data['success'].toString());
      return response.data;
    }
  }

}

class Middle extends StatefulWidget {
  Middle({super.key, this.app_name, this.user_uni_name, this.user_name, this.user_speed, this.responce});
  final app_name;
  final user_uni_name;

  final user_name;
  final user_speed;
  final responce;

  @override
  State<Middle> createState() => _MiddleState();
}

class _MiddleState extends State<Middle> {
  Future<Map<String, dynamic>?>? apiResult;

  @override
  void initState() {
    super.initState();
    apiResult = getMainApi().mainAPI(context); // initState에서 API 요청을 수행
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          FutureBuilder<Map<String, dynamic>?>(
            future: apiResult, // FutureBuilder에 future로 apiResult를 사용
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // 로딩 인디케이터
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (!snapshot.hasData) {
                return Text("No data received");
              }

              var data = snapshot.data!;
              return Head.Head(
                app_name: widget.app_name,
                user_uni_name: widget.user_uni_name,
                user_dep_name: data['department'], // API 호출 결과 사용
                // 다른 데이터도 이와 같이 사용
              );
            },
          ),
          Cal_Test.TableCalendarScreen(),
          Middle_Cal.Middle(),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  apiResult = getMainApi().mainAPI(context); // 버튼 클릭 시 API 다시 요청
                });
              },
              child: Text('불러오기')
          ),
        ],
      ),
    );
  }
}
