import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import '0.Head.dart' as Head;
import '1.Image.dart' as Image;
import '2.Name.dart' as Name;
import '3.Infomation.dart' as Infornation;
import '4.Account.dart' as Account;
import '5.AppSet.dart' as AppSet;
import '6.Etc.dart' as Etc;
import '3.Text.dart' as Text;


class Myinfo extends StatelessWidget {
  Myinfo({Key? key, this.user_name,this.user_uni_name,this.user_dep_name,this.user_num,this.user_speed,this.user_id}) : super(key: key);
  final user_name;
  final user_uni_name;
  final user_dep_name;
  final user_num;
  final user_speed;
  final user_id;
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
                  children:[Image.image_box(),Name.name_box(user_name:user_name)]),
            ),
            Infornation.imformation(user_uni_name:user_uni_name,user_dep_name:user_dep_name,user_num:user_num,user_speed:user_speed),
            Account.account(user_id: user_id),
            AppSet.appset(),
            Etc.etc(),
          ],
        ),
      );
    }
  }





