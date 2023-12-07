import 'package:flutter/material.dart';

class SpeedChart extends StatelessWidget {
  const SpeedChart({super.key,this.speed});
  final speed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
              child: Text('속도',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),)),

          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: Text('$speed km/h',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff473CCE),
              ),)),
          bar(speed:speed),

        ],
      )
    );
  }
}


class bar extends StatelessWidget {
  const bar({super.key,this.speed});
  final speed ;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),

          ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Flexible(child: Container(

                  decoration: BoxDecoration(
                    color: Color(0xff473CCE),
                    borderRadius: BorderRadius.circular(15),

                  ),
                ),flex:speed ),
                Flexible(child: Container(),flex:(300-speed)as int)
              ],
            )


      )
    );
  }
}


