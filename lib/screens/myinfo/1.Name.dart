import 'package:flutter/material.dart';
import 'empty.dart';
class NamePlace extends StatelessWidget {
  NamePlace({super.key, this.user_name, this.user_speed});
  final user_name;
  final user_speed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row( //name
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            name(user_name: user_name,),

            speed(user_speed: user_speed,),
          ],
        ),
        button(text: '프로필 수정', next_page: empty()),
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
              height: 60,
              width: 60,
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

class button extends StatelessWidget {
  const button({super.key,this.text,this.next_page});
  final text;
  final next_page;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child:Container(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => next_page)
              );
            },
            style: ButtonStyle(

              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
              shadowColor: MaterialStateProperty.all(Colors.grey),
              elevation: MaterialStateProperty.all(0),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.withOpacity(0.2);
                  }
                  return null;
                },
              ),
            ),
            child: Container(

              alignment: Alignment.center,
              child: Text(text,style: TextStyle(
                color: Colors.white,
                fontSize: 18,

              ),),
            )
        ),
      ),
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
