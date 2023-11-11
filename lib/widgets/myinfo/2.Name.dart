import 'package:flutter/material.dart';

class name_box extends StatelessWidget {
  const name_box({super.key, this.user_name});
  final user_name;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffD9D9D9),
            width: 0.5,
          ),
        ),

      ),

      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[image_box(),name(user_name:user_name)]),
    );
  }
}


class image_box extends StatelessWidget {
  const image_box({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.fromLTRB(20, 0, 10, 10),

      height: 60,
      width: 60,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black12, width: 3),
      ),
    );
  }
}

class name extends StatelessWidget {
  const name({super.key, this.user_name});
  final user_name;
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text('$user_name',style:TextStyle(
          fontSize: 18,
        ))
    );
  }
}