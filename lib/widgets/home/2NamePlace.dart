import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class NamePlace extends StatelessWidget {
  NamePlace({super.key, this.user_name, this.user_speed});
  final user_name;
  final user_speed;

  @override
  Widget build(BuildContext context) {
    return Row( //name
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        name(user_name: user_name,),
        speed(user_speed: user_speed,),
      ],
    );
  }
}


class name extends StatelessWidget {
  name({super.key, this.user_name});
  final user_name;
  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black12, width: 3),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20,0, 0,0),
              child: Text(user_name ,style:TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              )),
            ),
          ],
        )
    );
  }
}
class speed extends StatelessWidget {
  speed({super.key, this.user_speed});
  final user_speed;
  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
        child: Row(
          children: [
            Container(

              child: Text('$user_speed km/h',style:TextStyle(
                  color: Color(0xff000000),
                  fontSize: 13,
                  fontWeight: FontWeight.bold
              )),
            ),
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.fromLTRB(20,0, 0,0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 3),

              ),
            ),
          ],
        )
    );
  }
}


