import 'dart:async';
import 'package:flutter/material.dart';

class DetaiLow extends StatefulWidget {
  String nTopic;
  String nLow;
  DetaiLow(this.nTopic,this.nLow);
  @override
  _DetaiLowState createState() => _DetaiLowState(nTopic,nLow);
}

class _DetaiLowState extends State<DetaiLow> {
  String nTopic;
  String nLow;
  _DetaiLowState(this.nTopic,this.nLow);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar:
          AppBar(title: Text('เลขรับคำกล่าวโทษ $nTopic'), centerTitle: true),
      body: ListView(children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('เลขรับคำกล่าวโทษ',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text(nTopic, style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ฐานความผิดมาตรา',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text(nLow, style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ฐาน',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text('มีไว้ครอบครองโดยมิได้เสียภาษี',
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('วันที่จับกุม',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text('09 กันยายน 2561',
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ประเภทของกลาง',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text('สุรา', style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('สถานที่จับกุม',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text(
                              'ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น',
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('เลขที่เปรียบเทียบคดี',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text('1/2561', style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ค่าปรับ',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text('10,000  บาท', style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('คดีสิ้นสุดชั้น',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff2e76bc))),
                          Text('กรมสรรพสามิต', style: TextStyle(fontSize: 16))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
