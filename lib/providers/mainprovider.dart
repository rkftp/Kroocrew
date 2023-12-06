import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class Schedule{
  final String courseName;
  final String courseId;
  final String teamName;
  final String deadLine;
  final String description;

  Schedule({
    required this.courseName,
    required this.courseId,
    required this.teamName,
    required this.deadLine,
    required this.description,
});

  factory Schedule.fromSchedule(Map<String, dynamic> json) {
    return Schedule(
        courseName: json["Course_name"],
        courseId: json["Course_id"],
        teamName: json["Team_name"],
        deadLine: json["Deadline"],
        description: json["description"]
    );
  }

}

class MainData{
  final bool retCode;
  final String department;
  final List<Schedule>? schedule;



  MainData({

    required this.retCode,
    required this.department,
    required this.schedule,
});

  factory MainData.fromMain(Map<String, dynamic> json) {
    final List<dynamic> scheduleJson = json['schedule'];
    List<Schedule> scheduleList = scheduleJson.map((item) => Schedule.fromSchedule(item)).toList();
    return MainData(
      retCode: json['retCode'] ,
      department: json['department'] ,
      schedule: scheduleList ,
    );
  }



}


class mainController extends StateNotifier<MainData> {
  mainController() : super(MainData(retCode: true, department: '',  schedule: null ));

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

      final MainData data = MainData.fromMain(response.data);
      state = data;

      print(state);


    } else {
      print('불러오기 실패' +response.data['success'].toString());
    }
  }

}

final MainProvider = StateNotifierProvider<mainController, MainData>((ref){
  return mainController();
});




