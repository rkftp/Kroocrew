import 'package:flutter/material.dart';


class image_box extends StatelessWidget {
  const image_box({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      height: 60,
      width: 60,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black12, width: 3),
      ),
    );
  }
}

