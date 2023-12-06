import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/providers/projectProvider.dart';

import 'package:dio/dio.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class TimetableData {
  final String CourseId;
  final String CourseName;
  final String CourseDay;
  final String CourseStartTime;
  late bool isActive;
  late String TeamName;
  late int TeamId;

  TimetableData({
    required this.CourseId,
    required this.CourseName,
    required this.CourseDay,
    required this.CourseStartTime,
  }): isActive = false, TeamId = 0, TeamName = "팀이 없습니다.";

  factory TimetableData.fromJson(Map<String, dynamic> json) {
    final courseId = json['Course_id'];
    final courseName = json['Course_name'];
    final courseDay = json['day'];
    final courseStartTime = json['time'];

    return TimetableData(
      CourseId: courseId,
      CourseName: courseName,
      CourseDay: courseDay,
      CourseStartTime: courseStartTime,
    );
  }
}

class TeamData {
  final String TeamName;
  final int TeamId;
  final String CourseId;
  final String CourseName;

  TeamData({
    required this.TeamName,
    required this.TeamId,
    required this.CourseId,
    required this.CourseName,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    final teamName = json['Team_name'];
    final teamId = json['Team_id'];
    final courseId = json['Course_id'];
    final courseName = json['Course_name'];

    return TeamData(
      TeamName: teamName,
      TeamId: teamId,
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
      final List<dynamic> data = response.data['timetable_small'];

      final List<dynamic> teamData = response.data['teams'];



      final List<TeamData> mappedTeamData = teamData
          .map((item) => TeamData.fromJson(item))
          .toList();

      final List<TimetableData> mappedTimetableData = data
          .map((item) => TimetableData.fromJson(item))
          .toList();

      final teamList = ref.read(myProjectProvider.notifier).getMyProject();

      for(var timetableItem in mappedTimetableData) {
        for(var teamItem in mappedTeamData) {
          if(timetableItem.CourseId == teamItem.CourseId) {
            timetableItem.isActive = true;


            break;
          }
        }
      }
      state = mappedTimetableData;
      print(mappedTimetableData);
    } else {
      print('불러오기 실패' + response.data['success'].toString());
    }
  }

}

final timetableProvider = StateNotifierProvider<timetableController, List<TimetableData>>((ref) {
  return timetableController();
});
