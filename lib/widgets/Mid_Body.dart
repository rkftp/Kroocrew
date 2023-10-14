import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'Bottom_Navigate.dart';
import 'home/Middle.dart';

class MidBody extends GetView<BottomNavController> {
  const MidBody({super.key});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: controller.selectedIndex.value,
      children: [
        Middle(),
        Center(
            child: Text('시간표')
        ),
        Center(
            child: Text('프로젝트')
        ),
        Center(
            child: Text('톡')
        ),
        Center(
            child: Text('내정보')
        )
      ],
    );
  }

}