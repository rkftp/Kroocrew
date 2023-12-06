import 'package:flutter/material.dart';

class FlutterDropdownDay extends StatefulWidget {
  const FlutterDropdownDay({Key? key}) : super(key: key);

  @override
  State<FlutterDropdownDay> createState() => _FlutterDropdownDayState();
}
class _FlutterDropdownDayState extends State<FlutterDropdownDay> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          hint: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['1', '2', '3','4','5','6','7','8','9','10',
            '11','12','13','14','15','16','17','18','19','20',
            '21','22','23','24','25','26','27','28','29','30','31']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FlutterDropdownMonth extends StatefulWidget {
  const FlutterDropdownMonth({Key? key}) : super(key: key);

  @override
  State<FlutterDropdownMonth> createState() => _FlutterDropdownMonthState();
}
class _FlutterDropdownMonthState extends State<FlutterDropdownMonth> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          hint: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['1', '2', '3','4','5','6','7','8','9','10', '11','12']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FlutterDropdownYear extends StatefulWidget {
  const FlutterDropdownYear({Key? key}) : super(key: key);

  @override
  State<FlutterDropdownYear> createState() => _FlutterDropdownYearState();
}
class _FlutterDropdownYearState extends State<FlutterDropdownYear> {
  String dropdownValue = '2023';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          hint: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['2022','2023','2024']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FlutterDropdownIcon extends StatefulWidget {
  const FlutterDropdownIcon({Key? key}) : super(key: key);

  @override
  State<FlutterDropdownIcon> createState() => _FlutterDropdownIconState();
}
class _FlutterDropdownIconState extends State<FlutterDropdownIcon> {
  IconData dropdownValue = Icons.file_copy_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DropdownButton<IconData>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          hint: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (IconData? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <IconData>[Icons.file_copy_outlined,Icons.monitor,Icons.video_camera_back,Icons.access_alarm]
              .map<DropdownMenuItem<IconData>>((IconData value) {
            return DropdownMenuItem<IconData>(
              value: value,
              child: Icon(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FlutterDropdownSubject extends StatefulWidget {
  const FlutterDropdownSubject({Key? key}) : super(key: key);

  @override
  State<FlutterDropdownSubject> createState() => _FlutterDropdownSubjectState();
}
class _FlutterDropdownSubjectState extends State<FlutterDropdownSubject> {
  String dropdownValue = '캡스톤디자인(1)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          hint: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['캡스톤디자인(1)','인공지능','컴퓨터통신','리눅스시스템응용설계']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FlutterDropdownTeamnum extends StatefulWidget {
  const FlutterDropdownTeamnum({Key? key}) : super(key: key);

  @override
  State<FlutterDropdownTeamnum> createState() => _FlutterDropdownTeamnumState();
}
class _FlutterDropdownTeamnumState extends State<FlutterDropdownTeamnum> {
  String dropdownValue = '2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          hint: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['2','3','4','5','6','7','8','9','10']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}