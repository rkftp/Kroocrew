import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '1.Head.dart' as Head;
import '2.Cal_Test.dart' as Cal_Test;
import '3.List.dart' as Middle_Cal;
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
    final middleState = ref.watch(MainProvider);
    MainData mainData = middleState;
    final scheduleData = middleState.schedule;

    List<Schedule> scheduleList = [];
    if (scheduleData != null) {
      scheduleList = scheduleData.map((item) => Schedule(
        courseName: item.courseName,
        courseId: item.courseId,
        teamName: item.teamName,
        deadLine: item.deadLine,
        description: item.description,
      )).toList();
      print(scheduleList);
    }



    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Head.Head(app_name: 'Kroocrew', user_uni_name: '중앙대', user_dep_name:mainData.department),

              Cal_Test.TableCalendarScreen(scheduleList: scheduleList),
              Middle_Cal.list(b1: scheduleList),
            ],
          ),
        ),
      )
    );
  }
}
