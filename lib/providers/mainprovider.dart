import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';


class MainData{
  final String studentId;
  final bool retCode;
  final String studentName;
  final String studentNumber;
  final String department;
  final int speed;
  final List<dynamic> timeTable;
  final List<dynamic> scedule;

  MainData({
    required this.studentId,
    required this.retCode,
    required this.studentName,
    required this.studentNumber,
    required this.department,
    required this.speed,
    required this.timeTable,
    required this.scedule,
});

  factory MainData.fromMain(Map<String,dynamic>json){
    final studentId = json["Student_id"];
    final retCode = json["retCode"];
    final studentName = json["Student_name"];
    final studentNumber = json["Student_number"];
    final department = json["department"];
    final speed = json["Speed"];
    final timeTable = json["timeTable"];
    final scedule = json["schedule"];

    return MainData(
        studentId : studentId,
        retCode : retCode,
        studentName : studentName,
        studentNumber : studentNumber,
        department : department,
        speed : speed,
        timeTable : timeTable,
        scedule : scedule,
    );}
}


class mainController extends StateNotifier<List<MainData>> {
  mainController() : super([]);

  Future<void> getMainAPI() async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    print("sansasnasnansas");
    final response = await _dio.get('/main_page',
        options: Options(
            headers : {'Authorization': '${storedToken}'},
          )
    );
    print("asdfasdfasdfasdfasdf\n");

    if (response.statusCode == 200) {
      print("12341234123412341234\n성공해버린..");

      MainData data = MainData.fromMain(response.data);
      print(data);
      state = data as List<MainData>;


    } else {
      print('불러오기 실패' +response.data['success'].toString());
    }
  }

}

final MainProvider = StateNotifierProvider<mainController, List<MainData>>((ref){
  return mainController();
});




