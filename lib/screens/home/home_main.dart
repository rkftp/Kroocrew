import 'package:flutter/material.dart';
import '1.Head.dart' as Head;
import '2.Cal_Test.dart' as Cal_Test;
import '3.List.dart' as Middle_Cal;

import '/screens/login/login.dart' as login;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class getMainApi {
  Future<void> mainAPI( BuildContext context) async {
    final dio = Dio();
    final storage = login.storage;
    final response = await dio.get('http://20.39.186.138:1234/main_page',
        queryParameters: {
      'year_semester': '2023-3'
    },
    options: Options(
      headers: {
        'Authorization' : await login.storage.read(key: 'token')
      },
    )
    );
    print('응답: ${response.data}');
    print('응답2: ${response.data['success']}');
    if (response.data['success'] == true) {
      print("성공해버린..");
    } else {
      print('불러오기 실패' + response.data['success'].toString());
    }
  }

}

class Middle extends StatelessWidget {
  Middle({super.key,this.app_name, this.user_uni_name,this.user_dep_name,this.user_name,this.user_speed});
  final app_name;
  final user_uni_name;
  final user_dep_name;
  final user_name;
  final user_speed;
  @override

  Widget build(BuildContext context) {
    var now = DateTime.now();

    return Expanded(
        child: ListView(
        children: [
            Head.Head(app_name: app_name,user_uni_name:user_uni_name, user_dep_name:user_dep_name),
            Cal_Test.TableCalendarScreen(),
            Middle_Cal.Middle(),
            ElevatedButton(onPressed: (){getMainApi().mainAPI(context);}, child: Text('불러오기')),
          ],
        ),

    );
  }
}
