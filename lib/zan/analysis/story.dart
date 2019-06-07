import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/zan/detail/topic_detaillow.dart';

class StoryPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ประวัติผู้ต้องหา'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                ' ชื่อผู้ต้องหา',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff2e76bc)),
                              ),
                              Text(' นายเสนาะ อุตโม',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: FontStyles().FontFamily)),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ประเภทผู้ต้องหา',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff2e76bc))),
                              Text(' บุคคลธรรมดา',
                                  style: TextStyle(fontSize: 16)),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ประเภทบุคคล',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff2e76bc))),
                              Text(' คนไทย', style: TextStyle(fontSize: 16)),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(' เลขที่บัตรประชาชน',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff2e76bc))),
                            Text(' 155600009661',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ที่อยู่',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff2e76bc))),
                              Text(
                                ' เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น',
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Kanit'),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                RaisedButton(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TopicDetailLow(),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('จำนวนครั้งที่กระทำผิด',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff2e76bc))),
                            Text('2 ครั้ง', style: TextStyle(fontSize: 18))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[Icon(Icons.chevron_right)],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
