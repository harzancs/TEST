import 'package:prototype_app_pang/zan/analysis/main_analysis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultCamera extends StatefulWidget {
  @override
  _SearchResultCameraState createState() => _SearchResultCameraState();
}

class _SearchResultCameraState extends State<SearchResultCamera> {
  var groupname = ['นายสมบัติ จันทสุข', 'นายสมชาย จันทสุข'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('วิเคราะห์ข้อมูลผู้ต้องหา'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(50.0),
              child: CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/person_1.jpg'),
                minRadius: 50,
                maxRadius: 70,
              ),
            ),
            Container(
              height: 450,
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
                                        ExactAssetImage('assets/images/person_2.jpg'),
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
        ),
      ),
    );
  }
}
