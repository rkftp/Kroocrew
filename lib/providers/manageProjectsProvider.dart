import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '/providers/projectProvider.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class ScheduleData{
  final int teamId;
  final String deadline;
  final String description;
  final String studentId;

  ScheduleData({
    required this.teamId,
    required this.deadline,
    required this.description,
    required this.studentId,
  });

  factory ScheduleData.fromSchedule(Map<String, dynamic> json) {
    final teamId = json['Team_id'];
    final deadline = json['Deadline'];
    final description = json['description'];
    final studentId = json['Student_id'];

    return ScheduleData(
      teamId: teamId,
      deadline: deadline,
      description: description,
      studentId: studentId,
    );
  }
}

class manageController extends StateNotifier<List<ScheduleData>> {
  manageController() : super([]);

  Future<void> getSchedule(BuildContext context, WidgetRef ref, int TeamId) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();


    final response = await _dio.get('/get_schedule',
        queryParameters: {
          'Team_id': TeamId,
        },
        options: Options(
          headers : {'Authorization': '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      print("성공해버린..");
      state = response.data['schedule']
          .map((item) => ScheduleData.fromSchedule(item))
          .toList();

    } else {
      print('불러오기 실패' +response.data['success'].toString());
    }

  }
}

final manageProvider = StateNotifierProvider<manageController, List<ScheduleData>>((ref) {
  return manageController();
});