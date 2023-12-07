import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';


class MyinfoData{
  final String studentId;
  final bool retCode;
  final String studentName;
  final String studentNumber;
  final String department;
  final int speed;
  // 사진정보
  final String description;
  MyinfoData({
    required this.studentId,
    required this.retCode,
    required this.studentName,
    required this.studentNumber,
    required this.department,
    required this.speed,
    required this.description,
  });
  factory MyinfoData.fromMain(Map<String, dynamic> json) {
    final studentId = json['Student_id'];
    final retCode = json['retCode'];
    final studentName = json['Student_name'];
    final studentNumber = json['Student_number'];
    final department = json['department'];
    final speed = json['Speed'];
    final description = json['description'];

    return MyinfoData(
      studentId : studentId,
      retCode : retCode,
      studentName : studentName,
      studentNumber : studentNumber,
      department : department,
      speed : speed,
      description: description,
    );}


}
class myinfoController extends StateNotifier<MyinfoData> {
  myinfoController() : super(MyinfoData(studentId : '', retCode : true, studentName: '',studentNumber: '',department: '',  speed: 0,description: '' ));

  Future<void> getMainAPI() async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();


    final response = await _dio.get('/my_page',
        options: Options(
          headers : {'Authorization': '${storedToken}'},
        )
    );


    if (response.statusCode == 200) {
      print("성공해버린..");

      final MyinfoData data = MyinfoData.fromMain(response.data);
      state = data;

      print(state);


    } else {
      print('불러오기 실패' +response.data['success'].toString());
    }
  }
  Future<void> description(text) async {
    Dio _dio = Dio(); // dio_service에서 생성한 객체를 가져옵니다.
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('http://20.39.186.138:1234/add_student_description?description=${text}',
        options: Options(
          headers : {'Authorization': '${storedToken}'},
        ));
    try {
      if (response.statusCode == 200) {
        print("성공");
        if (response.data['success'] == true) {
          print("찐성공");
          print(response.data);
        } else {
          print("미친 실패");
        }
      } else {}
    } catch (e) {
      print('오류 발생: $e');
    }
  }

}

final MyinfoProvider = StateNotifierProvider<myinfoController, MyinfoData>((ref){
  return myinfoController();
});