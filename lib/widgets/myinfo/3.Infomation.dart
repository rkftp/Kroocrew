import 'package:flutter/material.dart';

class imformation extends StatelessWidget {
  const imformation({super.key,this.user_uni_name,this.user_dep_name,this.user_num,this.user_speed});
  final user_uni_name;
  final user_dep_name;
  final user_num;
  final user_speed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 00),
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
            Text("개인정보",style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              ),
            ),

            uni(user_uni_name:user_uni_name),
            dep(user_dep_name:user_dep_name),
            num(user_num:user_num),
            speed(user_speed:user_speed),

            TextButton(onPressed: (){}, child:
              Text("개인정보 다시 불러오기", style: TextStyle(color:Colors.black))),
          ]
      ),
    );
  }
}

class uni extends StatelessWidget {
  const uni({super.key,this.user_uni_name});
  final user_uni_name;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text('학교 : $user_uni_name',style: TextStyle(
          fontSize: 16,
        ))
    );
  }
}
class dep extends StatelessWidget {
  const dep({super.key,this.user_dep_name});
  final user_dep_name;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text('학과 : $user_dep_name',style:TextStyle(
          fontSize: 16,
        ))
    );
  }
}
class num extends StatelessWidget {
  const num({super.key,this.user_num});
  final user_num;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text('학번 : $user_num',style:TextStyle(
          fontSize: 16,
        ))
    );
  }
}
class speed extends StatelessWidget {
  const speed({super.key,this.user_speed});
  final user_speed;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text('속력 : $user_speed km/h',style:TextStyle(
          fontSize: 16,
        ))
    );
  }
}
