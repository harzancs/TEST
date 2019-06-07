import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'story.dart';

class NetworkPerson extends StatelessWidget {
  var arr = ['ใบงานจับกุมเดียวกัน', 'บิดา - มารดา', 'ที่อยู่ เดียวกัน'];
  var group = [
    'นางวิไล เมืองใจ',
    'นายธันวา เด่นไกล',
    'นายเสนาะ อุตโม',
    'นายสมชาย ไขแสง'
  ];

  var family = ['นายกลั่า อุตโม'];

  var address = [
    'นายอลังการ แสนสาน',
    'นายออด เกิดพูล',
    'นายเทพ ทวี',
    'นายกวิน ปิ่นมงคล',
    'นายสิธา คล้ายสุบรรณ',
    'นายสวด ภูมิคอนสาร'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.white,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => StoryPerson(),
                    )),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/person_1.jpg',
                        width: 150.0, height: 150.0),
                    Text('นายเสนาะ อุตโม', style: TextStyle(fontSize: 16))
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(arr[0],
                          style: new TextStyle(
                              fontSize: 20.0, color: Color(0xff2e76bc))),
                    ],
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: group.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            child: new Container(
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/person_2.jpg',
                                      width: 100.0, height: 100.0),
                                  Text(group[index])
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(arr[1],
                          style: new TextStyle(
                              fontSize: 20.0, color: Color(0xff2e76bc))),
                    ],
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: family.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            child: new Container(
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/person_3.JPEG',
                                      width: 100.0, height: 100.0),
                                  Text(family[index])
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(arr[2],
                          style: new TextStyle(
                              fontSize: 20.0, color: Color(0xff2e76bc))),
                    ],
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: address.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            child: new Container(
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/person_1.jpg',
                                      width: 100.0, height: 100.0),
                                  Text(address[index])
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        )
      ],
    );

  }
}
