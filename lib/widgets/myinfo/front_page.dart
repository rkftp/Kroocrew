import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '0.Head.dart' as Head;
import '1.Name.dart' as Name;
import '2.Infomation.dart' as Infornation;
import '3.Account.dart' as Account;
import '4.AppSet.dart' as AppSet;
import '5.Etc.dart' as Etc;



class Myinfo extends StatelessWidget {
  Myinfo({Key? key,this.loginDacc, this.user_name,this.user_uni_name,this.user_dep_name,this.user_num,this.user_speed,this.user_id}) : super(key: key);
  final loginDacc;
  final user_name;
  final user_uni_name;
  final user_dep_name;
  final user_num;
  final user_speed;
  final user_id;
  @override
  Widget build(BuildContext _context) {
    return Scaffold(
      body: ListView(
        children: [
          Head.head(),
          Name.name_box(user_name: user_name),
          button(text:'개인정보',icon:Icons.person_outlined,next_page: Infornation.imformation(user_uni_name:user_uni_name,user_dep_name:user_dep_name,user_num:user_num,user_speed:user_speed) ),
          button(text:'계정', icon:Icons.lock_outline, next_page:Account.account(user_id: user_id)),
          button(text: '개인 설정', icon:Icons.settings,next_page:AppSet.appset()),
          button(text: '기타', icon:Icons.more_horiz_outlined,next_page: Etc.etc(loginDacc:loginDacc),),
        ],
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




