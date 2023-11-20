import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'front_page.dart' as front;
import '0.Head.dart' as Head;
import '1.Name.dart' as Name;


class Myinfo extends StatelessWidget {
  Myinfo({Key? key, this.user_name,this.user_uni_name,this.user_dep_name,this.user_num,this.user_speed,this.user_id}) : super(key: key);
  final user_name;
  final user_uni_name;
  final user_dep_name;
  final user_num;
  final user_speed;
  final user_id;
  @override
  Widget build(BuildContext _context) {
      return Expanded(
        child: Container(
          child: Column(
            children: [
              header(front: front.Myinfo(user_name: user_name,user_id: user_id,user_speed: user_speed,user_dep_name: user_dep_name,user_num: user_num,user_uni_name: user_uni_name)),
              Name.name_box(user_name: user_name),
              uni(text: '학교',info:user_uni_name),
              uni(text: '학과',info:user_dep_name),
              uni(text: '학번',info:user_num),
              uni(text: '속력',info:user_speed),
            ],
          )
        ),
      );
    }
  }

class button extends StatelessWidget {
  const button({super.key,this.text,this.icon,this.next_page});
  final text;
  final icon;
  final next_page;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => next_page)
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
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
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                child: Icon(icon,color: Colors.black,size: 25)),

            Text(text,style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w100
            )),
          ],
        ),
      ),
    );
  }
}



class header extends StatelessWidget {
  const header({super.key,this.front});
  final front;
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.fromLTRB(30, 10, 0,10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          Text('내 정보',style:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
          ),
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => front)
            );
          }, icon: Icon(Icons.settings)),
        ],
      ),




    );
  }
}

class uni extends StatelessWidget {
  const uni({super.key,this.text,this.info});
  final text;
  final info;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 15, 20,15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$text : ',style: TextStyle(
              fontSize: 18,
            )),
            text =='속력' ? Text( '$info km/h',style: TextStyle(
                fontSize: 15,
                color: Colors.blue
            ))
                : Text( '$info',style: TextStyle(
                fontSize: 15,
                color: Colors.blue
            )),


          ],
        )
    );
  }
}