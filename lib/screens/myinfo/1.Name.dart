import 'package:flutter/material.dart';
import 'empty.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

XFile ? selectImage;
final ImagePicker _picker = ImagePicker();
class NamePlace extends StatelessWidget {
  NamePlace({super.key, this.user_name, this.user_speed});
  final user_name;
  final user_speed;




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row( //name
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            name(user_name: user_name,),

          ],
        ),
        button(text: '프로필 사진 수정'),
      ],
    );
  }
}


class name extends StatelessWidget {
  name({super.key, this.user_name});
  final user_name;
  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black12, width: 3),



              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20,0, 0,0),
              child: Text(user_name ,style:TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700
              )),
            ),
          ],
        )
    );
  }
}

class button extends StatefulWidget {
  button({super.key,this.text});
  final text;

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child:Container(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
            onPressed: ()async{
              var picker = ImagePicker();
              var image;
              showDialog(
                context: context,
                barrierDismissible:true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      height: 140,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text('어떤 앱을 실행하겠습니까?')),
                          TextButton(
                            child: const Text('카메라'),
                            onPressed: ()async {
                              Navigator.of(context).pop();

                              selectImage = await _picker.pickImage(source: ImageSource.camera,maxHeight: 75,maxWidth: 75,imageQuality: 30);
                            },
                          ),
                          TextButton(
                            child: const Text('갤러리'),
                            onPressed: ()async {
                              Navigator.of(context).pop();
                             selectImage = await _picker.pickImage(source: ImageSource.gallery,maxHeight: 75,maxWidth: 75,imageQuality: 30);
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('닫기'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],

                  );
                }
              );
              if (selectImage != null) {

              }
            },
            style: ButtonStyle(

              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
              shadowColor: MaterialStateProperty.all(Colors.grey),
              elevation: MaterialStateProperty.all(0),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.withOpacity(0.2);
                  }
                  return null;
                },
              ),
            ),
            child: Container(

              alignment: Alignment.center,
              child: Text(widget.text,style: TextStyle(
                color: Colors.white,
                fontSize: 18,

              ),),
            )
        ),
      ),
    );



  }
}

class speed extends StatelessWidget {
  speed({super.key, this.user_speed});
  final user_speed;
  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
        child: Row(
          children: [
            Container(

              child: Text('$user_speed km/h',style:TextStyle(
                  color: Color(0xff000000),
                  fontSize: 13,
                  fontWeight: FontWeight.bold
              )),
            ),
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.fromLTRB(20,0, 0,0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 3),

              ),
            ),
          ],
        )
    );
  }
}
