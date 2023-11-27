import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'front_page.dart' as front;
import '0.Head.dart' as Head;
import '1.Name.dart' as Name;
import 'SpeedChart.dart' as SpeedChart;

import '/screens/login/login.dart' as login;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class getMainApi {
  Future<Map<String, dynamic>?> mainAPI( BuildContext context) async {
    final dio = Dio();

    final response = await dio.get('http://20.39.186.138:1234/my_page',
        queryParameters: {},
        options: Options(
          headers: {
            'Authorization' : await login.storage.read(key: 'token')
          },
        )
    );

    print('응답: ${response.data}');

    print('응답2: ${response.data['success']}');
    if (response.data['success'] == true) {
      print("성공해버린..");
      return response.data;
    } else {
      print('불러오기 실패' + response.data['success'].toString());
      return response.data;
    }
  }

}





class Myinfo extends StatefulWidget {
  Myinfo({Key? key,this.loginDacc,this.user_uni_name,this.user_speed}) : super(key: key);
  final loginDacc;

  final user_uni_name;


  final user_speed;


  @override
  State<Myinfo> createState() => _MyinfoState();
}

class _MyinfoState extends State<Myinfo> {
  Future<Map<String, dynamic>?>? apiResult;

  @override
  void initState() {
    super.initState();
    apiResult = getMainApi().mainAPI(context); // initState에서 API 요청을 수행
  }
  @override
  Widget build(BuildContext _context) {
      return Scaffold(
        body: SafeArea(
          child: Container(
              child:
              FutureBuilder<Map<String, dynamic>?>(
                future: apiResult, // FutureBuilder에 future로 apiResult를 사용
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // 로딩 인디케이터
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (!snapshot.hasData) {
                    return Text("No data received");
                  }

                  var data = snapshot.data!;
                  return Column(
                    children: [

                      header(front: front.Myinfo(loginDacc:widget.loginDacc,user_name: data['Student_name'],user_id: data['Student_id'],user_speed: widget.user_speed,user_dep_name: data['department'],user_num: data['Student_number'],user_uni_name: widget.user_uni_name)),
                      Name.NamePlace(user_name: data['Student_name'],user_speed: widget.user_speed,),
                      SpeedChart.SpeedChart(speed: widget.user_speed),
                      uni(text: '학교',info:widget.user_uni_name),
                      uni(text: '학과',info: data['department']),
                      uni(text: '학번',info:data['Student_number']),
                    ],

                  );
                },
              ),

          ),
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