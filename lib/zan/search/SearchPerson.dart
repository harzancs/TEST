import 'package:flutter/material.dart';

import 'typePer_1.dart';
import 'typePer_2.dart';

class SearchPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'บุคคลธรรมดา'),
              Tab(text: 'นิติบุคคล')
            ],
          ),
          title: Text('ค้นหาผู้ต้องหา'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: <Widget>[
            FormSearch1(),
            FormSearch2(),
          ],
        ),
      ),
    );
  }
}
