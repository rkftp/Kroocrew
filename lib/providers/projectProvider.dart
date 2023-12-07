import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class ProjectCardData{
  final bool rapidMatch;
  final String teamName;
  final String courseName;
  final int teamId;
  final String courseId;
  final int maxMember;
  final int currentMember;
  final String teamLeader;
  final String description;
  final String finishTime;
  final int averageSpeed;



  ProjectCardData({
    required this.rapidMatch,
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
    final rapidMatch = json["rapid_match"];
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
      rapidMatch: rapidMatch,
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


  Future<void> getWholeProject(String value, WidgetRef ref) async {
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
      ref.read(myProjectProvider.notifier).getMyProject();
      final List<ProjectCardData> myProjectList = ref.watch(myProjectProvider);

      final List<ProjectCardData> projectList = data
          .map((item) => ProjectCardData.fromProjects(item))
          .toList();

      for(int i = 0; i < projectList.length; i++){
        for(int j = 0; j < myProjectList.length; j++){
          if(projectList[i].teamId == myProjectList[j].teamId){
            projectList.removeAt(i);
          }
        }
      }


      state = projectList;

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

class joinTeamController extends StateNotifier<String> {
  joinTeamController() : super('');

  Future<void> joinTeam(int teamId) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/join_team_request',
        queryParameters: {
          'Team_id' : teamId,
        },
        options: Options(
          headers: {'Authorization': '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      print('성공');
      print(response.data);
      if(response.data['message'] == "already requested")
        state = '이미 신청을 완료했습니다.';
      else if(response.data['messeage'] == "requested")
        state = '신청에 성공했습니다.';
      else
        state = response.data['message'];
      // return response.data;
    } else {
      print('불러오기 실패' + response.data['success'].toString());
      state = '신청에 실패했습니다.';
      // return response.data;
    }
  }
}

final joinTeamProvider = StateNotifierProvider<joinTeamController, String>((ref) {
  return joinTeamController();
});

