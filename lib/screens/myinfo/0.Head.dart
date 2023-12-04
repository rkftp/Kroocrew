import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/mypageProvider.dart';


class head extends ConsumerWidget {
  const head({super.key});

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    return Container(

        padding: EdgeInsets.fromLTRB(0, 10, 0,10),
        child: Row(
          children: [
            IconButton(onPressed: (){
              ref.read(MyinfoProvider.notifier).getMainAPI();
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),

            Text('설정',style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),




    );
  }
}
