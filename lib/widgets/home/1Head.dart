import 'package:flutter/material.dart';

class Head extends StatelessWidget {
  Head({super.key, this.app_name, this.user_uni_name, this.user_dep_name});
  final app_name;
  final user_uni_name;
  final user_dep_name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appName(app_name: app_name,),
          uniName(user_uni_name: user_uni_name),
          depName(user_dep_name: user_dep_name),
        ],
      )
    );
  }
}

class appName extends StatelessWidget {
  appName({super.key, this.app_name});
  final app_name;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
        child: Text(app_name,style: TextStyle(
            color:Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w800
            ),
        ),
    );
  }
}

class uniName extends StatelessWidget {
  uniName({super.key, this.user_uni_name});
  final user_uni_name;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Text(user_uni_name,style: TextStyle(
            color:Color(0xff473CCE),
            fontSize: 20,
            fontWeight: FontWeight.w700
        ),)
    );
  }
}

class depName extends StatelessWidget {
  depName({super.key, this.user_dep_name});
  final user_dep_name;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Text(user_dep_name,style: TextStyle(
            color:Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold
        ),)
    );
  }
}

