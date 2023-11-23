import 'package:contact/screens/myinfo/empty.dart';
import 'package:flutter/material.dart';

class imformation extends StatelessWidget {
  const imformation({super.key,this.user_uni_name,this.user_dep_name,this.user_num,this.user_speed});
  final user_uni_name;
  final user_dep_name;
  final user_num;
  final user_speed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subject(text: '개인정보'),

              uni(text: '학교',info:user_uni_name),
              uni(text: '학과',info:user_dep_name),
              uni(text: '학번',info:user_num),
              uni(text: '속력',info:user_speed),
              button(text: '개인정보 다시 불러오기',next_page: empty()),


            ]
        ),
      ),
    );
  }
}

class subject extends StatelessWidget {
  const subject({super.key,this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0,10),
      child: Row(
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back)),
          Text('$text',style:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffD9D9D9), // 아래쪽 변에 검은색 테두리를 적용합니다.
            width: 0.5, // 테두리의 두께를 1.0으로 설정합니다.
          ),
        ),
        // Container 내부는 투명으로 설정합니다.
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
class button extends StatelessWidget {
  const button({super.key,this.text,this.next_page});
  final text;
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
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 15, 20,15),
          alignment: Alignment.centerLeft,
          child: Text(text,style: TextStyle(
            color: Colors.black,
            fontSize: 18,

          ),),
        )
        ),
      );

  }
}