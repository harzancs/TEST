import 'package:prototype_app_pang/zan/analysis/main_analysis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultText extends StatefulWidget {
  @override
  _SearchResultTextState createState() => _SearchResultTextState();
}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class _SearchResultTextState extends State<SearchResultText> {
  var groupname = ['นายสมบัติ จันทสุข', 'นายสมชาย จันทสุข'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('วิเคราะห์ข้อมูลผู้ต้องหา'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 800,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: groupname.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        RaisedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => NetPerson(),
                              )),
                          color: Colors.white,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(12),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        ExactAssetImage('assets/person_2.jpg'),
                                    minRadius: 20,
                                    maxRadius: 30,
                                  ),
                                ),
                                Text(
                                  groupname[index],
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
