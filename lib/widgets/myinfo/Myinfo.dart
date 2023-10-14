import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';

part 'Myinfo.g.dart';

@swidget
Widget myinfo() {
  return Center(child: Text('내정보'));
}
