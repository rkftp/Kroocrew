import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/cupertino.dart';

import '/providers/projectProvider.dart';

class MyProject extends ConsumerStatefulWidget {
  const MyProject({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyProjectState();
}

class _MyProjectState extends ConsumerState<MyProject> {

  @override
  void initState() {
    super.initState();
    ref.read(myProjectProvider.notifier).getMyProject();
  }

  @override
  Widget build(BuildContext context) {
    final myProjectList = ref.watch(myProjectProvider);
    return Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 14, 14, 0),
            alignment: Alignment.centerLeft,
            child: Column(
                children:[
                  Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: myProjectList.length,
                      itemBuilder: (content, index) {
                        ProjectCardData cardData = myProjectList[index];
                        return InkWell(
                          onTap: () {
                            context.go('/projects/schedule');
                          },
                          child: CustomCard(
                            courseName: cardData.courseName,
                            teamName: cardData.teamName,
                          ),
                        );
                      },
                    ),
                  ),
                ]
            ),
          ),
        ]
    );
  }
}


class CustomCard extends ConsumerStatefulWidget {
  final String courseName;
  final String teamName;

  CustomCard({required this.courseName, required this.teamName});

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
          CupertinoIcons.circle_fill,
          color: _randomColor.randomColor(
            colorBrightness: ColorBrightness.light,
            colorSaturation: ColorSaturation.lowSaturation,
          ),
          size: 30,
        ),

        title: Text(
          widget.courseName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          widget.teamName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

