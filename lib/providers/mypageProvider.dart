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
  MyinfoData({
    required this.studentId,
    required this.retCode,
    required this.studentName,
    required this.studentNumber,
    required this.department,
    required this.speed,
});

  factory MyinfoData.fromMyinfo()
}