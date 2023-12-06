import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class ProjectCardData{
  final String teamName;
  final String courseName;
  final int teamId;
  final String courseId;
  final int maxMember;
  final int currentMember;
  final String teamLeader;
  final String? description;
  final String finishTime;
  final int averageSpeed;



  ProjectCardData({
    required this.teamName,
    required this.courseName,
    required this.teamId,
    required this.courseId,
    required this.maxMember,
    required this.currentMember,
    required this.teamLeader,
    required this.description,
    required this.finishTime,
    required this.averageSpeed,
  });

  factory ProjectCardData.fromProjects(Map<String,dynamic> json) {
    final courseName = json["Course_name"];
    final teamName = json["Team_name"];
    final teamId = json["Team_id"];
    final courseId = json["Course_id"];
    final maxMember = json["max_member"];
    final currentMember = json["current_member"];
    final teamLeader = json["head"];
    final description = json["description"];
    final finishTime = json["finish_time"];
    final averageSpeed = json["average_speed"];


    return ProjectCardData(
      courseName: courseName,
      teamName: teamName,
      teamId: teamId,
      courseId: courseId,
      maxMember: maxMember,
      currentMember: currentMember,
      teamLeader: teamLeader,
      description: description,
      finishTime: finishTime,
      averageSpeed: averageSpeed,
    );}
}

class projectController extends StateNotifier<List<ProjectCardData>> {
  projectController() : super([]);

  Future<void> getWholeProject(String value) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    if (value == null) {
      value = '';
    }

    final response = await _dio.get('/list_whole_team',
        queryParameters: {
          'search' : value,
        },
        options: Options(
          headers: {'Authorization': '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['teams'];

      state = data
          .map((item) => ProjectCardData.fromProjects(item))
          .toList();

      // return response.data;
    } else {
      print('불러오기 실패' + response.data['success'].toString());
      // return response.data;
    }
  }
}

final projectProvider = StateNotifierProvider<projectController, List<ProjectCardData>>((ref) {
  return projectController();
});


class myProjectController extends StateNotifier<List<ProjectCardData>> {
  myProjectController() : super([]);

  Future<void> getMyProject() async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/list_my_team',
        options: Options(
          headers: {'Authorization': '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['teams'];

      print(data);
      state = data
          .map((item) => ProjectCardData.fromProjects(item))
          .toList();

      // return response.data;
    } else {
      print('불러오기 실패' + response.data['success'].toString());
      // return response.data;
    }
  }
}

final myProjectProvider = StateNotifierProvider<myProjectController, List<ProjectCardData>>((ref) {
  return myProjectController();
});