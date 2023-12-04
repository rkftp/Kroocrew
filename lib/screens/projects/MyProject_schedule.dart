import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

class MyProjectSchedule extends ConsumerStatefulWidget {
  const MyProjectSchedule({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyProjectScheduleState();
}

class _MyProjectScheduleState extends ConsumerState<MyProjectSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('팀 스케쥴'),
      ),
    );
  }
}