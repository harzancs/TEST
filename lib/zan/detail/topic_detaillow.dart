import 'package:flutter/material.dart';

import 'detail.dart';

class TopicDetailLow extends StatefulWidget {
  @override
  _TopicDetailLowState createState() => _TopicDetailLowState();
}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class _TopicDetailLowState extends State<TopicDetailLow> {
  var topic = ['105/2561', '1/2562'];
  var low = ['203', '209'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('รายละเอียดการกระทำผิด'), centerTitle: true),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            
            Container(
              height: 800,
              child: new ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: topic.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: RaisedButton(
                      color: Colors.white,
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8),
                              ),
                              Text('เลขรับคำกล่าวโทษ ' + topic[index] + '',
                                  style: TextStyle(fontSize: 18)),
                              Text('ฐานความผิดมาตรา ' + low[index] + '',
                                  style: TextStyle(fontSize: 18)),
                              Padding(
                                padding: EdgeInsets.all(8),
                              ),
                            ],
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      )),
                      onPressed: () {
                        String nTopic = topic[index];
                        String nLow = low[index];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DetaiLow(nTopic, nLow),
                            ));
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
