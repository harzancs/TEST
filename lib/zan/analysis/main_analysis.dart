import 'package:flutter/material.dart';

import 'network.dart';
import 'report.dart';


class NetPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
           bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'ผู้ต้องหา'),
              Tab(text: 'รายงาน')
            ],
          ),
          title: Text('วิเคราะห์ข้อมูลผู้ต้องหา'),
          centerTitle: true,
        ),body: TabBarView(
          children: <Widget>[
            NetworkPerson(),
            ReportPerson(),
          ],
        ),
      ),
    );
  }
}