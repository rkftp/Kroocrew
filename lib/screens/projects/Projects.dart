import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/utils/dio_service.dart';
import '/utils/token_keybox.dart';


part 'Projects.g.dart';

class getMainApi {
  Future<Map<String, dynamic>?> mainAPI( BuildContext context) async {
    Dio _dio = DioServices().to();

    KeyBox _keyBox = KeyBox().to();

    late String? storedToken;
    storedToken = await _keyBox.getToken();

    final response = await _dio.get('/list_whole_project',
        queryParameters: {

        },
        options: Options(
          headers: {'Authorization' :  '${storedToken}'},
        )
    );

    if (response.statusCode == 200) {
      print("성공해버린..");
      return response.data;
    } else {
      print('불러오기 실패' + response.data['success'].toString());
      return response.data;
    }
  }
}

List subject_list = [];



class Projects extends ConsumerStatefulWidget{
  const Projects({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectsState();
}


class _ProjectsState extends ConsumerState<Projects> with SingleTickerProviderStateMixin {

  late final Provider<TabController> recentTabStateProvider;

  @override
  void initState() {
    super.initState();
    recentTabStateProvider = Provider<TabController>((ref) {
      return TabController(length: 3, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(recentTabStateProvider);

    final List<Tab> myTabs = <Tab>[
      Tab(
        child: Text(
          '수강 과목',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Tab(
        child: Text(
          '대외활동',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Tab(
        child: Text(
          '스터디',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];




    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // 새로운 높이
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: controller,
            tabs: myTabs,//
            indicatorColor: Color(0xff473CCE),
            labelColor: Color(0xff473CCE),
            unselectedLabelColor: Color(0xff707070),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Projects_Subject(),
          Projects_Activity(),
          ElevatedButton(
            onPressed: () async {
              final getMainApi _getMainApi = getMainApi();
              final Map<String, dynamic>? response = await _getMainApi.mainAPI(context);
              print(response);
              subject_list = response!['data'];
              print(subject_list);
            },
            child: Text('make api'),
          ),
        ],
      ),
    );
  }
}

@swidget
Widget SearchWidget() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(Icons.search, color: Colors.grey),
        SizedBox(width: 5),
        Text('검색', style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}



@swidget
Widget projects_Subject() {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20, 14, 14, 0),
        alignment: Alignment.centerLeft,
        child: Column(
            children:[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: TextField(
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                    hintText: '검색',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none, // 테두리 선 없음
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: subject_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCard(
                        subjectName: subject_list[index]['subjectName'],
                        time: subject_list[index]['time'],
                      );
                    },
                  ),
                ),
              ),
            ]
        ),
      ),

    ]
  );
}

@swidget
Widget projects_Activity() {
  return Center(
    child: Text("대외활동"),
  );
}

@swidget
Widget projects_Study() {
  return Center(
    child: Text("스터디"),
  );
}

class CustomCard extends StatelessWidget {
  final String subjectName;
  final String time;

  CustomCard({required this.subjectName, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Color(0xffe8e4e4),
          ),
        ),
        title: Text(
          subjectName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          time,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

