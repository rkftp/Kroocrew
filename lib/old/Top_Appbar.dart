import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';

part 'Top_Appbar.g.dart';

@swidget
Widget topAppbar() {
  return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UnivContainer(),
          DepartContainer(),
        ],
      )
    );
}

var univ = "중앙대";
var dpart = "컴퓨터공학";

@swidget
Widget univContainer() {
  return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
      child: Text("$univ",
        style:TextStyle(
            color: Color(0xff473CCE),
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      )
  );
}

@swidget
Widget departContainer() {
  return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(19, 0, 0, 0),
      child: Text("$dpart과",
        style:TextStyle(
            color: Color(0xff000000),
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
      )
  );
}