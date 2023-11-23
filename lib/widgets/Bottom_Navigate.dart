import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigate extends GetView<BottomNavController> {
  const BottomNavigate({super.key});


  @override
  Widget build(BuildContext context) {
    return Obx(()=> BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xff473CCE),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.selectedIndex.value,
      onTap: controller.changeIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: '시간표',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.widgets),
          label: '프로젝트',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          label: '톡',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '내정보',
        ),
      ],
    ));
  }
}

class BottomNavController extends GetxController {

  static BottomNavController get to => Get.find();

  final RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex(index);
  }
}

