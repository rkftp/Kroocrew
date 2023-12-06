import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dio/dio.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class TimetableData {
  final String CourseId;
  final String CourseName;

  TimetableData({
    required this.CourseId,
    required this.CourseName,
  });

  factory TimetableData.fromJson(Map<String, dynamic> json) {
    final courseId = json['Course_id'];
    final courseName = json['Course_name'];

    return TimetableData(
      CourseId: courseId,
      CourseName: courseName,
    );
  }
}


class timetableController extends StateNotifier<List<TimetableData>> {
  timetableController() : super([]);

  Future<void> getPortal(BuildContext context, WidgetRef ref) async {
    Dio _dio = DioServices().to();

    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/get_timetable_from_portal',

        options: Options(
          headers: {'Authorization' :  '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      print("성공해버린..");
      final List<dynamic> data = response.data['timetable'];

      state = data
          .map((item) => TimetableData.fromJson(item))
          .toList();
      print(data);

    } else {
      print('불러오기 실패' + response.data['success'].toString());
    }
  }

  Future<void> getDB(BuildContext context, WidgetRef ref) async {
    Dio _dio = DioServices().to();

    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/get_timetable_from_db',
        options: Options(
          headers: {'Authorization' :  '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      print("성공해버린..");
      final List<dynamic> data = response.data['timetable'];

      state = data
          .map((item) => TimetableData.fromJson(item))
          .toList();
      print(data);
    } else {
      print('불러오기 실패' + response.data['success'].toString());
    }
  }

}

final timetableProvider = StateNotifierProvider<timetableController, List<TimetableData>>((ref) {
  return timetableController();
});
