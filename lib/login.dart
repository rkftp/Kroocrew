import 'package:flutter/material.dart';



class login extends StatelessWidget {
  const login({super.key, this.loginAcc});
  final loginAcc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

              width: 180,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("id"),
                      Text("pw"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text("id 입력"),
                        Text("pw 입력"),
                      ],
                  ),
                ],
              ),
            ),
            Container(
                width: 80,
                height: 50,
                child: TextButton( onPressed: () { loginAcc(); }, child: Text("로그인"), )
            ),
          ],
        ),
      ),
    );
  }
}
