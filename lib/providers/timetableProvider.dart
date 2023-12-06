import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dio/dio.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class CustomCardData {
  final String CourseId;
  final String time;

  CustomCardData({
    required this.CourseId,
    required this.time,
  });

  factory CustomCardData.fromTimetableSmall(Map<String,dynamic> json) {
    final courseId = json['Course_id'];

    return CustomCardData(
      CourseId: extractCourseId(courseId),
      time: extractTime(courseId),
    );
  }

  static String extractCourseId(String courseId) {
    return courseId.substring(12); // Extract from the 13th character onward
  }

  static String extractTime(String courseId) {
    return courseId.substring(7, 12); // Extract from the 8th to 12th characters
  }
}

class timetableController extends StateNotifier<List<CustomCardData>> {
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
      final List<dynamic> data = response.data['timetable_small'];

      state = data
          .map((item) => CustomCardData.fromTimetableSmall(item))
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
      final List<dynamic> data = response.data['timetable_small'];

      state = data
          .map((item) => CustomCardData.fromTimetableSmall(item))
          .toList();
      print(data);
    } else {
      print('불러오기 실패' + response.data['success'].toString());
    }
  }

}

final timetableProvider = StateNotifierProvider<timetableController, List<CustomCardData>>((ref) {
  return timetableController();
});
