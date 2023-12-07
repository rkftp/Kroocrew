import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '/providers/projectProvider.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';
import 'package:quickalert/quickalert.dart';
import 'package:go_router/go_router.dart';

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

      final List<dynamic> data = response.data['schedule'];
      state = data
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

class rapidMatchController extends StateNotifier<bool> {
  rapidMatchController() : super(false);

  Future<void> getRapidMatch(int TeamId) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/get_rapid_match',
        queryParameters: {
          'Team_id': TeamId,
        },
        options: Options(
          headers : {'Authorization': '${storedToken}'},
        )
    );

    if(response.statusCode == 200) {
      if(response.data['success']==true)
        state= true;
      else
        state = false;
    }
    else{
      print('불러오기 실패' +response.data['success'].toString());
    }
  }

  Future<void> editRapidMatch(TeamId, rapidValue, BuildContext context) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/rapid_match_on_off',
        queryParameters: {
          'Team_id': TeamId,
          'rapid_match': rapidValue,
        },
        options: Options(
          headers: {'Authorization': '${storedToken}'},
        )
    );

    if (response.data['success'] == true) {
      if(rapidValue == true){
        state = true;
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: '신속 매칭모드로 전환되었습니다.',
          confirmBtnText: '확인',
          confirmBtnColor: Color(0xFF7365F8),
          onConfirmBtnTap: () {
            context.pop();
          },
        );
      }
      else{
        state = false;
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: '신속 매칭모드가 해제되었습니다.',
          confirmBtnText: '확인',
          confirmBtnColor: Color(0xFF7365F8),
          onConfirmBtnTap: () {
            context.pop();
          },
        );
      }
    } else {
      print("실패해버린..");
    }
  }
}

final rapidMatchProvider = StateNotifierProvider<rapidMatchController, bool>((ref) {
  return rapidMatchController();
});