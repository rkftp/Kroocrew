import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class listBox extends ConsumerStatefulWidget {
  const listBox({Key? key,this.Margin}) : super(key: key);

  final Margin;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _listBoxemailState();
}
class _listBoxemailState extends ConsumerState<listBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(widget.Margin),
          color: Color(0xffABADBC),
          child:Text('시작하는 여행자', style: TextStyle(
            fontSize: 16,
            color: Color(0xff3E364F),),

          ),
        ),
        Container(child: Icon(Icons.format_quote_rounded,color: Color(0xff4A42A6),size: 30,))
      ],
    );

  }
}
