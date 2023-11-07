import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import '0.Head.dart' as Head;
import '1.Image.dart' as Image;
import '2.Text.dart' as Text;


class Myinfo extends StatelessWidget {
  Myinfo({Key? key, this.user_name,this.user_uni_name,this.user_dep_name,this.user_num}) : super(key: key);
  final user_name;
  final user_uni_name;
  final user_dep_name;
  final user_num;
  @override
  Widget build(BuildContext _context) {
      return Expanded(
        child: ListView(
          children: [
            Head.head(),
            Container(

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[Image.image_box(),Text.text_box(user_name:user_name,user_uni_name:user_uni_name,user_dep_name:user_dep_name,user_num:user_num)]),
            ),

          ],
        ),
      );
    }
  }





