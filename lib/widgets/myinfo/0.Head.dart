import 'package:flutter/material.dart';

class head extends StatelessWidget {
  const head({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        padding: EdgeInsets.fromLTRB(30, 10, 0,30),
        child: Text('내 정보',style:TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ))
    );
  }
}
