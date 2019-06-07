import 'package:flutter/material.dart';

class ReportPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            new Column(
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  onPressed: () {},
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('1. ทะเบียนประวัติผู้กระทำผิด ', style: TextStyle(fontSize: 16)),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  onPressed: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('2. รายละเอียดการกระทำผิดของผู้กระทำผิด',
                            style: TextStyle(fontSize: 16)),
                        Icon(Icons.navigate_next)
                      ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
