import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '1.Head.dart' as Head;
import '2.Cal_Test.dart' as Cal_Test;
import '3.List.dart' as Middle_Cal;

import '/screens/login/login.dart' as login;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/providers/mainprovider.dart';





class Middle extends ConsumerStatefulWidget {
  const Middle({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MiddleState();
}
class _MiddleState extends ConsumerState<Middle> {

  @override
  void initState() {
    super.initState();
    ref.read(MainProvider.notifier).getMainAPI();
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Head.Head(app_name: 'Kroocrew', user_uni_name: '중앙대', user_dep_name:'sans'),
          Cal_Test.TableCalendarScreen(),
          Middle_Cal.Middle(),
        ],
      )
    );
  }
}
