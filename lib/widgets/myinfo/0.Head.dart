import 'package:flutter/material.dart';

class head extends StatelessWidget {
  const head({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // 아래쪽 변에 검은색 테두리를 적용합니다.
            width: 3.0, // 테두리의 두께를 1.0으로 설정합니다.
          ),
        ),
        // Container 내부는 투명으로 설정합니다.
      ),
        padding: EdgeInsets.fromLTRB(30, 10, 0,30),
        child:Text('내 정보',style:TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          ),
        ),


    );
  }
}
