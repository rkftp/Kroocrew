import 'package:flutter/material.dart';

class etc extends StatelessWidget {
  const etc({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color:Color(0xff473CCE), // 테두리 색상을 검은색으로 설정합니다.
          width: 2,
          // 테두리 선의 두께를 설정합니다.
        ),
        color:Color(0xffdddddd),
        borderRadius: BorderRadius.circular(15),

      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("기타",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
            TextButton(onPressed: (){}, child:
            Text("회원 탈퇴", style: TextStyle(color:Colors.black),)),
            TextButton(onPressed: (){}, child:
            Text("로그아웃", style: TextStyle(color:Colors.black))),
          ]
      ),
    );
  }
}