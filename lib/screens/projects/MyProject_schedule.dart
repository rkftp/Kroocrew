import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';

final TextEditingController nameController = TextEditingController();

List<String> dropDownList = ['1', '2', '3'];
List<String> dayList = ['1', '2', '3','4','5'];
String selectedDay = '';

final team_name = ['김효준','이주형','한진우'];
final team_color = [Color(0xffEF9191),Color(0xff91EFBC),Color(0xff91C7EF)];
final sub_name = ['API 수정','데모 영상 제작','최종 보고서'];
final icon = [Icons.video_camera_back,Icons.monitor,Icons.file_copy_outlined];
final deadline = ['2023/12/2(토)','2023/12/6(수)','2023/12/8(금)'];
final ontime = [[true,false,false],[false,false,true],[true,true,false]];







class MyProjectSchedule extends ConsumerStatefulWidget {
  const MyProjectSchedule({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyProjectScheduleState();
}

class _MyProjectScheduleState extends ConsumerState<MyProjectSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            headBox(),
            contextBox(),
          ],
        ),
      ),
    );
  }
}

class headBox extends ConsumerWidget {
  const headBox ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 140,
      width: double.infinity,

        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black, // 테두리 색상
              width: 2.0, // 테두리 두께
            ),
          ),
          color: Color(0xffADBED7),
          // 다른 스타일링 옵션들...
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed:(){
                context.go('/projects');
              }, icon: Icon(Icons.arrow_back),padding: EdgeInsets.all(4),),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text("Team: Orange",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),)),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: Text("과목: 캡스톤디자인(1)",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),)),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                popUp(),
                Container(
                    width: 140,

                    alignment: Alignment.centerRight,
                    child: Text("3/3",style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),)),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('나가기',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xffDB3E3E)),
                    minimumSize: MaterialStateProperty.all(Size(100, 40)), // 최소 크기 설정
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

class contextBox extends ConsumerWidget {
  const contextBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(itemCount:3,itemBuilder: (c,i){
        return Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white, // 배경색
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // 그림자 색상
                spreadRadius: 5, // 그림자의 범위
                blurRadius: 4, // 흐림 정도
                offset: Offset(0, 3), // 그림자의 방향과 거리
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon[i]),
                    Container(
                      width: 200,
                      alignment: Alignment.centerLeft,
                      child: Text('${sub_name[i]}',style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )),
                    ),
                    Text('${deadline[i]}',style: TextStyle(
                        fontWeight: FontWeight.w700
                    )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Row(
                  children: [
                    Icon(Icons.square_outlined),
                    Text('Check Box',style:TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16
                    )),
                  ],
                ),
              ),
              Row(
                  children: [
                    box(isOn: ontime[i][0],name:'${team_name[0]}',color:team_color[0]),
                    box(isOn: ontime[i][1],name:'${team_name[1]}',color:team_color[1]),
                    box(isOn: ontime[i][2],name:'${team_name[2]}',color:team_color[2]),
                  ]
              ),
            ],
          ),
        );
      },),
    );
  }
}
class box extends StatelessWidget {
  const box({super.key,this.isOn,this.name,this.color});
  final isOn;
  final name;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 70,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: isOn != false ? color : Colors.white,
          border:isOn != false ? Border(

          ) :
           Border(
            top: BorderSide(
              color: Colors.black, // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
            bottom: BorderSide(
              color: Colors.black, // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
            left: BorderSide(
              color: Colors.black, // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
            right: BorderSide(
              color: Colors.black, // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
          )
      ),
      alignment: Alignment.center,
      child: Text('${name}'),
    );
  }
}

class popUp extends ConsumerStatefulWidget {
  popUp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _popUpState();
}
class _popUpState extends ConsumerState<popUp> with SingleTickerProviderStateMixin{
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('일정 추가',style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),),
            content: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  height: 200 +(50*team_name.length).toDouble(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 45,
                            child: Text("이름: ",style:TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )),
                          ),
                          Container(
                            height: 30,
                            width: 170,
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                )
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 40,
                            child: DropdownButton(
                              items: dropDownList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value){},
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text('마감 기한',style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            width: 40,
                            child: DropdownButton(
                              items: dropDownList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value){},
                            ),
                          ),
                          Text("년",style:TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                          Container(
                            height: 60,
                            width: 40,
                            child: DropdownButton(
                              items: dropDownList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value){},
                            ),
                          ),
                          Text("월",style:TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                          Container(
                            height: 60,
                            width: 40,
                            child:DropdownButtonFormField(
                              value: selectedDay,
                              items: dayList.map((String item) {
                                return DropdownMenuItem<String>(
                                  child: Text('$item'),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                setState(() {
                                  selectedDay = value;
                                });
                              },
                            )
                          ),
                          Text("일",style:TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),

                        ],
                      ),
                      Container(height: 30),//여백용 Container
                      Container(
                        height: (50*team_name.length).toDouble(),
                        child: ListView.builder(
                            itemCount: team_name.length,
                            itemBuilder: (c, i) {
                              return nameBox(name : '${team_name[i]}');
                            }
                        ),
                      )

                    ],
                  )
              ),
            ),
            actions: <Widget>[

              TextButton(
                child: Text('추가'),
                onPressed: () {
                  Navigator.of(context).pop(); // 팝업 닫기
                },
              ),
              TextButton(
                child: Text('취소'),
                onPressed: () {

                  Navigator.of(context).pop(); // 팝업 닫기
                },
              ),
              // 수정된 텍스트 표시
            ],
            actionsAlignment: MainAxisAlignment.spaceEvenly,
          );
        },
      );
    },
      child: Text('+ 일정추가',style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      )),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff473CCE)),
        minimumSize: MaterialStateProperty.all(Size(110, 40)),
      ),
    );
  }
}


class nameBox extends ConsumerWidget {
  const nameBox ({super.key,this.name});
  final name;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(Icons.square_outlined)),
          Text("${name}",style:TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          )),
        ],
      ),
    );
  }
}
