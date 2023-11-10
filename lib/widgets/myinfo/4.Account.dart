import 'package:flutter/material.dart';

class account extends StatelessWidget {
  const account({super.key,this.user_id});
  final user_id;

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
            Text("계정",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
            id(user_id:user_id),
            TextButton(onPressed: (){}, child:
            Text("비밀번호 변경", style: TextStyle(color:Colors.black))),
            TextButton(onPressed: (){}, child:
            Text("프로필 이미지 변경", style: TextStyle(color:Colors.black))),
          ]
      ),
    );
  }
}

class id extends StatelessWidget {
  const id({super.key,this.user_id});
  final user_id;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text('아이디 : $user_id',style:TextStyle(
          fontSize: 16,
        ))
    );
  }
}