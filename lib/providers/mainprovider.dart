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
  final Map<String,dynamic>? scedule;

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

  factory MainData.fromMain(Map<String, dynamic> json) {
    return MainData(
      studentId: json['Student_id'] as String,  // String 타입으로 변환
      retCode: json['retCode'] as bool,         // bool 타입으로 변환
      studentName: json['Student_name'] as String,
      studentNumber: json['Student_number'] as String,
      department: json['department'] as String,
      speed: json['Speed'] as int,              // int 타입으로 변환
      timeTable: json['timeTable'] as List<dynamic>,
      scedule: json['schedule'] as Map<String, dynamic>,
    );
  }
}


class mainController extends StateNotifier<List<MainData>> {
  mainController() : super([]);

  Future<void> getMainAPI() async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();


    final response = await _dio.get('/main_page',
        options: Options(
            headers : {'Authorization': '${storedToken}'},
          )
    );


    if (response.statusCode == 200) {
      print("성공해버린..");

      MainData data = MainData.fromMain(response.data);



      print(state);


    } else {
      print('불러오기 실패' +response.data['success'].toString());
    }
  }

}

final MainProvider = StateNotifierProvider<mainController, List<MainData>>((ref){
  return mainController();
});




