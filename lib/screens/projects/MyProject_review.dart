import 'package:contact/screens/home/3.List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:contact/widgets/flutter_dropdown_page.dart';
import 'package:quickalert/quickalert.dart';

import 'VoteModal.dart';


import 'package:dio/dio.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';


import '/providers/projectProvider.dart';
import '/providers/manageProjectsProvider.dart';
import '/providers/auth.dart';

class ReviewMyProjects extends ConsumerStatefulWidget {


  const ReviewMyProjects({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ReviewMyProjectsState();
}

class _ReviewMyProjectsState extends ConsumerState<ReviewMyProjects> {

  @override
  void initState() {
    super.initState();
    ref.read(reviewProvider.notifier).getExpiredTeam();
  }

  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();
    final teamList = ref.watch(reviewProvider);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // 둥근 모서리를 없앰
                  ),
                  elevation: 0, // 그림자를 없앰
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Container(
                            width: 80,
                            alignment: Alignment.center,

                            child: Icon(
                              Icons.rate_review,
                              color:Color(0xFF7365F8),
                              size: 50,
                            ),
                          ),flex: 1
                      ),
                      Flexible(
                          child: Container(

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '완료된 프로젝트',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),flex:2
                      ),
                    ],
                  ),
                ),
              ),
              Container(

                height: 20,
                width: double.infinity,
                alignment: Alignment.center,
                child: Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Container(height: 10),
              Container(
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 14, 14, 0),
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  itemCount: teamList.length,
                  itemBuilder: (content, index) {
                    ProjectCardData cardData = teamList[index];
                    print(cardData);
                    return InkWell(
                      onTap: () {
                        final List<dynamic> memberData=  ref.watch(voteMemberProvider);
                        ref.read(voteMemberProvider.notifier).getVoteMember(cardData.teamId);
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return VoteModal(memberData: memberData);
                            },
                        );
                      },
                      child: CustomCard(
                        cardData: cardData,
                      ),
                    );
                  },
                ),
              ),
            ]
        )
    );
  }
}

class CustomCard extends ConsumerStatefulWidget {
  final ProjectCardData cardData;

  CustomCard({required this.cardData});

  @override
  ConsumerState<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCard> {
  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();
    return Card(
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
          color: _randomColor.randomColor(
            colorBrightness: ColorBrightness.light,
            colorSaturation: ColorSaturation.lowSaturation,
          ),
          size: 30,
        ),

        title: Text(
          widget.cardData.courseName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          widget.cardData.teamName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}





