import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';
import 'package:quickalert/quickalert.dart';

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

  Future<void> joinTeam(int teamId, BuildContext context) async {
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
      if(response.data['message'] == "already requested"){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          text: '이미 신청을 완료했습니다.',
          confirmBtnText: '확인',
          confirmBtnColor: Color(0xFF7365F8),
        );
      }
      else if(response.data['message'] == "requested")
        {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: '신청에 성공했습니다.',
            confirmBtnText: '확인',
            confirmBtnColor: Color(0xFF7365F8),
          );
        }
      else
        {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            text: '신청에 실패했습니다.',
            confirmBtnText: '확인',
            confirmBtnColor: Color(0xFF7365F8),
          );
        }
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



class reviewController extends StateNotifier<List<ProjectCardData>> {
  reviewController() : super([]);

  Future<void> getExpiredTeam() async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/vote_my_team_list_expired_teams',
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

final reviewProvider = StateNotifierProvider<reviewController, List<ProjectCardData>>((ref) {
  return reviewController();
});

class studentDTO{
  final String studentId;
  final String studentName;

  studentDTO({
    required this.studentId,
    required this.studentName,
  });

  factory studentDTO.fromProjects(Map<String,dynamic> json) {
    final studentId = json["Student_id"];
    final studentName = json["Student_name"];

    return studentDTO(
      studentId: studentId,
      studentName: studentName,
    );}
}

class voteMemberController extends StateNotifier<List<studentDTO>> {
  voteMemberController() : super([]);

  Future<void> getVoteMember(int teamId) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/vote_my_team_list_team_people',
        queryParameters: {
          'Team_id' : teamId,
        },
        options: Options(
          headers: {'Authorization': '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['people'];

      print(data);
      state = data
          .map((item) => studentDTO.fromProjects(item))
          .toList();

      // return response.data;
    } else {
      print('불러오기 실패' + response.data['success'].toString());
      // return response.data;
    }
  }
}

final voteMemberProvider = StateNotifierProvider<voteMemberController, List<studentDTO>>((ref) {
  return voteMemberController();
});