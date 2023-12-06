import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/projectProvider.dart';

class JoinProject extends ConsumerStatefulWidget{

  final ProjectCardData projectData;

  const JoinProject({
    Key? key,
    required this.projectData,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinProjectState();
}

class _JoinProjectState extends ConsumerState<JoinProject>{



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          ListTile(
            title: Text('asdf'),
            subtitle: Text('asdf'),
          ),
        ]
      )
    );
  }

}