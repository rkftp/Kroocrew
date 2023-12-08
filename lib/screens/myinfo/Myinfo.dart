import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'front_page.dart' as front;
import '/providers/mypageProvider.dart';

import 'package:flutter/cupertino.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';





class Myinfo extends ConsumerStatefulWidget {
  const Myinfo({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyinfoState();
}
class _MyinfoState extends ConsumerState<Myinfo> {

  @override
  void initState() {
    super.initState();
    ref.read(MyinfoProvider.notifier).getMainAPI();
  }

  @override

  Widget build(BuildContext _context) {

    final myinfoState = ref.watch(MyinfoProvider);

    MyinfoData myinfoData = myinfoState;
    String _editedText = myinfoData.description;

    TextEditingController _textFieldController = TextEditingController(text:_editedText);

    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
            color: Color(0xffEEEEEE),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(front: front.Setting(user_name: myinfoData.studentName,user_id: myinfoData.studentId,user_speed: myinfoData.speed,user_dep_name: myinfoData.department,user_num: myinfoData.studentNumber,user_uni_name: '중앙대')),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                          height: 250,

                          alignment: Alignment.centerLeft,
                          child: NamePlace(user_name: myinfoData.studentName,user_speed: myinfoData.speed,)),flex: 1
                    ),
                    Flexible(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),

                          child: speedchart(user_speed: myinfoData.speed)),flex: 2
                    ),
                  ],
                ),


                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,

                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("소개 글 ",style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Text("${ _textFieldController.text.length}",style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff473CCE),
                                            fontWeight: FontWeight.w800,
                                          ),),
                                          Text("/2000자 ",style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text("(※연락처 필수기입!)",style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1.5, color: Color(0xffEEEEEE))
                                )
                              ),
                            ),
                            Expanded(
                              child: Container(

                                child: ListView(
                                    children: [Text(_editedText, style: TextStyle(
                                      fontSize: 16,
                                    ),),]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            /*QuickAlert.show(
                              context: context,
                              type: QuickAlertType.custom.,
                              text: 'ID 또는 PW 가 틀렸습니다.',
                              confirmBtnText: '확인',
                              confirmBtnColor: Color(0xFF7365F8),
                              onConfirmBtnTap: () {
                                context.pop();
                              },

                            );*/

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('내용 수정'),
                                  content: Container(
                                    width: double.maxFinite, // 팝업의 너비를 최대로 설정
                                    child: TextField(
                                      controller: _textFieldController,
                                      maxLines: null,
                                      minLines: 5, // 최소 줄 수를 증가시켜 넓이를 확보
                                      decoration: InputDecoration(
                                        hintText: "텍스트를 입력하세요",
                                        border: OutlineInputBorder(), // 네모난 테두리 적용
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('취소'),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // 팝업 닫기
                                      },
                                    ),
                                    TextButton(
                                      child: Text('저장'),
                                      onPressed: () async{
                                        await ref.read(MyinfoProvider.notifier).description(_textFieldController.text);
                                        if(_textFieldController.text.length > 2000) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Text("2000자 이하로 작성해 주세요",style: TextStyle(
                                                    color: Color(0xffD95D5D),
                                                    fontWeight: FontWeight.w400,
                                                  ),),
                                                  insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('확인',style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400,
                                                      ),),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }
                                          );
                                        }
                                        else{
                                          ref.read(MyinfoProvider.notifier).getMainAPI();
                                          Navigator.of(context).pop();
                                        }
                                        // 팝업 닫기
                                      },
                                    ),
                                    // 수정된 텍스트 표시
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff473CCE)),
                            // 여기에서 색상을 설정
                          ),
                          child: Text('수정하기'),

                        ),
                      ),
                    ],
                  ),
                ),




              ],
          )

            ),


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
            fontWeight: FontWeight.w700,
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


class NamePlace extends ConsumerStatefulWidget {
  const NamePlace({Key? key, this.user_name, this.user_speed}) : super(key: key);

  final user_name;
  final user_speed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NamePlaceState();
}
class _NamePlaceState extends ConsumerState<NamePlace> {


  @override
  Widget build(BuildContext context, ) {
    return Container(

      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),


      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
            alignment: Alignment.centerLeft,
            child: Text('이름 : ',style:TextStyle(
                color: Color(0xff000000),
                fontSize: 20,
                fontWeight: FontWeight.w700
            )),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            alignment: Alignment.center,
            child: Text('${widget.user_name}',style:TextStyle(
                color: Color(0xff000000),
                fontSize: 25,
                fontWeight: FontWeight.w700
            )),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffEEEEEE),width: 2)
              )
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
            alignment: Alignment.centerLeft,
            child: Text('속도 : ',style:TextStyle(
                color: Color(0xff000000),
                fontSize: 20,
                fontWeight: FontWeight.w700
            )),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text('${widget.user_speed}',style:TextStyle(
                    color:(Color(0xFF7365F8)),
                    fontSize: 25,
                    fontWeight: FontWeight.w700
                )),
                Text('km/h',style:TextStyle(
                    color: Color(0xff000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class speedchart extends ConsumerStatefulWidget{
  const speedchart({Key? key,this.user_speed}) : super(key: key);
  final user_speed;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _speedchartState();
}


class _speedchartState extends ConsumerState<speedchart> {
  @override
  Widget build(BuildContext context) {
    return Container(

        width: 250,
        height:250,
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 700,
            axes:<RadialAxis>[
              RadialAxis(
                minimum: 0, maximum: 300,
                showLabels: true,
                showTicks: true,
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.17,
                      widget: Text(
                        widget.user_speed.toString() + 'km/h',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      )
                  )
                ],
                pointers:<GaugePointer> [
                  RangePointer(
                    value: widget.user_speed.toDouble(),
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                    gradient: const SweepGradient(
                      colors: <Color> [Colors.blue,Color(0xFF7365F8)],
                      stops: <double>[0.25, 0.75],
                    ),
                  ),
                ],
                axisLineStyle: AxisLineStyle(
                  thickness: 0.2,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              )
            ]
        )
    );
  }
}
