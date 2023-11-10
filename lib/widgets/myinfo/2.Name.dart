import 'package:flutter/material.dart';

class name_box extends StatelessWidget {
  const name_box({super.key, this.user_name});
  final user_name;
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
        child: Text('$user_name 님',style:TextStyle(
          fontSize: 20,
          fontWeight:FontWeight.bold,
        ))
    );
  }
}



