import 'package:flutter/material.dart';

class appset extends StatelessWidget {
  const appset({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color:Color(0xff473CCE), // 테두리 색상을 검은색으로 설정합니다.
          width: 2, // 테두리 선의 두께를 설정합니다.
        ),
        color:Color(0xffdddddd),
        borderRadius: BorderRadius.circular(15),

      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("앱 설정",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
            TextButton(onPressed: (){}, child:
            Text("테마", style: TextStyle(color:Colors.black))),
            TextButton(onPressed: (){}, child:
            Text("알림설정", style: TextStyle(color:Colors.black))),
          ]
      ),
    );
  }
}