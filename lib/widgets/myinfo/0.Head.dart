import 'package:flutter/material.dart';

class head extends StatelessWidget {
  const head({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

        padding: EdgeInsets.fromLTRB(0, 10, 0,10),
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),

            Text('내 정보',style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),




    );
  }
}
