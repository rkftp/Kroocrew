import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:quickalert/quickalert.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/quickalert.dart';



import 'MyProject_manage.dart';
import '/providers/timetableProvider.dart';
import '/providers/projectProvider.dart';

import '/utils/token_keybox.dart';
import 'package:dio/dio.dart';
import '/utils/dio_service.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:slide_countdown/slide_countdown.dart';


class manageController extends StateNotifier<int> {
  manageController() : super(0);

  Future<void> vote(int teamId, int voteValue) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.post('/vote_my_team',
        options: Options(
          headers: {'Authorization': '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      print('투표 성공');
      // return response.data;
    } else {
      print('투표 실패' + response.data['success'].toString());
      // return response.data;
    }
  }
}

class memberManage extends ConsumerStatefulWidget{

  final List<dynamic> memberData;

  const memberManage({Key? key, required this.memberData}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _memberManageState();
}

class _memberManageState extends ConsumerState<memberManage>{

  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();
    double value = 100;
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        //border radius only top
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),

      ),
      height: MediaQuery.of(context).size.height * 0.45,

      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 둥근 모서리를 없앰
                          ),
                          elevation: 0, // 그림자를 없앰
                          child: ListTile(
                            contentPadding: EdgeInsets.all(0), // 내용의 패딩을 없앰
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4), // 아이콘과 텍스트 간격을 조절

                            // leading을 직접 정의
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Colors.black,
                              size: 40,
                            ),
                            title: Text(
                              '참가 요청',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    color: Colors.transparent,
                    width: double.infinity,
                    height: 250,
                    child: ListView.builder(
                      itemCount: widget.memberData.length,
                      itemBuilder: (context, index) {
                        RequestDTO memberData = widget.memberData[index];
                        return Container(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // 둥근 모서리를 없앰
                            ),
                            elevation: 0, // 그림자를 없앰
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0), // 내용의 패딩을 없앰
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4), // 아이콘과 텍스트 간격을 조절

                              // leading을 직접 정의
                              title: Text(
                                memberData.studentId,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Container(
                                  color: Colors.transparent,
                                  width: 200,
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Color(0xFF7365F8),

                                    ),
                                    onRatingUpdate: (rating){
                                      print(rating);
                                    },
                                  )
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ElevatedButton(
                        onPressed:() {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: '평가가 완료되었습니다.',
                            confirmBtnText: '확인',
                            confirmBtnColor: Color(0xFF7365F8),
                            onConfirmBtnTap: () {
                              context.pop();
                              context.pop();
                              context.pop();
                            },
                          );},
                        child: Text('확인', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF7365F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(70, 40),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ]
      ),

    );
  }
}