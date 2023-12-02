import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class ProjectCardData{
  final String teamName;
  final String courseName;

  ProjectCardData({
    required this.teamName,
    required this.courseName,
  });

  factory ProjectCardData.fromProjects(Map<String,dynamic> json) {
    final courseName = json["Course_name"];
    final teamName = json["Team_name"];


    return ProjectCardData(
      courseName: courseName,
      teamName: teamName,
    );}

}
class projectController extends StateNotifier<List<ProjectCardData>> {
  projectController() : super([]);

  Future<void> getWholeProject() async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/list_whole_team',
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