import 'package:flutter/material.dart';

class text_box extends StatelessWidget {
  text_box({super.key,this.user_name,this.user_uni_name,this.user_dep_name,this.user_num});
  final user_name;
  final user_uni_name;
  final user_dep_name;
  final user_num;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 20, 0),

      width: 300,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          name(user_name:user_name),
          uni(user_uni_name:user_uni_name),
          dep(user_dep_name:user_dep_name),
          num(user_num:user_num),

        ],
      ),
    );
  }
}

class name extends StatelessWidget {
  const name({super.key,this.user_name});
 final user_name;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text('$user_name 님',style:TextStyle(
        fontSize: 20,
        fontWeight:FontWeight.bold,
      ))
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



