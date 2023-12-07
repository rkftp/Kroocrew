import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:quickalert/quickalert.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


import '/providers/timetableProvider.dart';
import '/providers/projectProvider.dart';

import '/utils/token_keybox.dart';
import 'package:dio/dio.dart';
import '/utils/dio_service.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:slide_countdown/slide_countdown.dart';

class Vote {
  final String studentId;
  final String voteValue;

  Vote({
    required this.studentId,
    required this.voteValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'Student_id': studentId,
      'vote_value': voteValue,
    };
  }
}

class TeamVotes {
  final int teamId;
  final List<Vote> votes;

  TeamVotes({
    required this.teamId,
    required this.votes,
  });

  Map<String, dynamic> toJson() {
    return {
      'Team_id': teamId,
      'votes': votes.map((vote) => vote.toJson()).toList(),
    };
  }
}

class voteController extends StateNotifier<int> {
  voteController() : super(0);

  Future<void> vote(int teamId, int voteValue) async {
    Dio _dio = DioServices().to();
    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.post('/vote_my_team',
        data: TeamVotes(
          teamId: teamId,
          votes: [
          ],
        ).toJson(),
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

class VoteModal extends ConsumerStatefulWidget{

  final List<dynamic> memberData;

  const VoteModal({Key? key, required this.memberData}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoteModalState();
}

class _VoteModalState extends ConsumerState<VoteModal>{

  void onGaugeValueChanged(double newValue, studentDTO studentData, teamId) {
    // Create a list of Vote objects
    final List<Vote> votes = widget.memberData.map((member) {
      return Vote(
        studentId: member.studentId,
        voteValue: newValue.toInt().toString(),
      );
    }).toList();

    // Create a TeamVotes object
    final TeamVotes teamVotes = TeamVotes(
      teamId: teamId,
      votes: votes,
    );

    // Send the API POST request using voteController
  }

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
                              CupertinoIcons.star_circle,
                              color: Colors.black,
                              size: 40,
                            ),
                            title: Text(
                              '평가하기',
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
                  color: Color(0xffEFEFEF),
                  width: double.infinity,
                  height: 250,
                  child: ListView.builder(
                      itemCount: widget.memberData.length,
                      itemBuilder: (context, index) {
                        studentDTO memberData = widget.memberData[index];
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
                                memberData.studentName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Container(
                                width: 200,
                                child: SfLinearGauge(
                                  showTicks: false,
                                  minimum: 0,
                                  maximum: 300,
                                  markerPointers: [
                                    LinearShapePointer(
                                      value: value,
                                      width: 10,
                                      color: Color(0xFF7365F8),
                                      position: LinearElementPosition.cross,
                                      enableAnimation: true,
                                      animationDuration: 1000,
                                      onChanged: (value) {
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                  )
                ),
              ],
            ),
          ]
      ),

    );
  }

}