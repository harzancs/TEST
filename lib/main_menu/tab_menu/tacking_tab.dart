import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_detail_items.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_head_list.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_list_arrest_items.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_list_lawsuit_items.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_main.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_screen.dart';

class TrackingFragment extends StatefulWidget {
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<TrackingFragment> {

  //style content
  TextStyle textStyleLanding = TextStyle(
      fontSize: 20, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLabel = TextStyle(fontSize: 16,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(
      fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily,
      fontSize: 12.0);
  TextStyle textStyleDataSub = TextStyle(
      fontSize: 16, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = TextStyle(
      fontSize: 16, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButtonNotAccept = TextStyle(
      fontSize: 16,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);

  List<ItemsTrackingMain> itemMain = [
    new ItemsTrackingMain(
        1,
        "รอรับคดี",
        [
          new ItemsTrackingArrestList(
              1,
              "TN9011126100021",
              "10 ก.พ. 2562",
              [
                new ItemsTrackingSubDetail(
                    "นาย",
                    "สามารถ",
                    "ปรารถนา"
                ),
                new ItemsTrackingSubDetail(
                    "นาย",
                    "สามารถ",
                    "ปรารถนา"
                )
              ]
          ),
          new ItemsTrackingArrestList(
              1,
              "TN9011126100021",
              "10 ก.พ. 2562",
              [
                new ItemsTrackingSubDetail(
                    "นาย",
                    "สามารถ",
                    "ปรารถนา"
                ),
                new ItemsTrackingSubDetail(
                    "นาย",
                    "สามารถ",
                    "ปรารถนา"
                )
              ]
          ),
        ]),
    new ItemsTrackingMain(
        2,
        "รอรับคดี",
        [
          new ItemsTrackingHeadList(
              "1/2562",
              "นางสาวชยนันท์ เกิดมากผล",
              [
                new ItemsTrackingArrestList(
                    1,
                    "TN9011126100021",
                    "10 ก.พ. 2562",
                    [
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      ),
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      )
                    ]
                ),
                new ItemsTrackingLawsuitList(
                    2,
                    "TN9011126100021",
                    "10 ก.พ. 2562",
                    " 255/2562",
                    [
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      ),
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      )
                    ]
                ),
              ]),
          new ItemsTrackingHeadList(
              "2/2562",
              "นางสาวชยนันท์ เกิดมากผล",
              [
                new ItemsTrackingArrestList(
                    1,
                    "TN9011126100021",
                    "10 ก.พ. 2562",
                    [
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      ),
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      )
                    ]
                ),
                new ItemsTrackingArrestList(
                    1,
                    "TN9011126100021",
                    "10 ก.พ. 2562",
                    [
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      ),
                      new ItemsTrackingSubDetail(
                          "นาย",
                          "สามารถ",
                          "ปรารถนา"
                      )
                    ]
                ),
              ])
        ]),
    new ItemsTrackingMain(
      3,
      "รอพิสูจน์ของกลาง",
      [
        new ItemsTrackingHeadList(
            "1/2562",
            "นางสาวชยนันท์ เกิดมากผล",
            [
              new ItemsTrackingArrestList(
                  1,
                  "TN9011126100021",
                  "10 ก.พ. 2562",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  2,
                  "TN9011126100021",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
            ]
        )
      ],
    ),
    new ItemsTrackingMain(
      4,
      "รอเปรียบเทียบ",
      [
        new ItemsTrackingHeadList(
            "1/2562",
            "นางสาวชยนันท์ เกิดมากผล",
            [
              new ItemsTrackingArrestList(
                  1,
                  "TN9011126100021",
                  "10 ก.พ. 2562",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  2,
                  "TN9011126100022",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  4,
                  "TN9011126100023",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
            ]
        )
      ],
    ),
    new ItemsTrackingMain(
      5,
      "รอชำระค่าปรับ",
      [
        new ItemsTrackingHeadList(
            "1/2562",
            "นางสาวชยนันท์ เกิดมากผล",
            [
              new ItemsTrackingArrestList(
                  1,
                  "TN9011126100021",
                  "10 ก.พ. 2562",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  2,
                  "TN9011126100022",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  4,
                  "TN9011126100023",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
            ]
        )
      ],
    ),
    new ItemsTrackingMain(
      6,
      "รอนำส่งรายได้",
      [
        new ItemsTrackingHeadList(
            "1/2562",
            "นางสาวชยนันท์ เกิดมากผล",
            [
              new ItemsTrackingArrestList(
                  1,
                  "121/1",
                  "10 ก.พ. 2562",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  2,
                  "121/1",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  5,
                  "TN9011126100023",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),new ItemsTrackingLawsuitList(
                  6,
                  "120/1",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),

            ]
        )
      ],
    ),
    new ItemsTrackingMain(
      7,
      "รอแบ่งเงินสินบน",
      [
        new ItemsTrackingHeadList(
            "1/2562",
            "นางสาวชยนันท์ เกิดมากผล",
            [
              new ItemsTrackingArrestList(
                  1,
                  "121/1",
                  "10 ก.พ. 2562",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  2,
                  "121/1",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),
              new ItemsTrackingLawsuitList(
                  5,
                  "TN9011126100023",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),new ItemsTrackingLawsuitList(
                  6,
                  "120/1",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),new ItemsTrackingLawsuitList(
                  7,
                  "LC0006036200001",
                  "10 ก.พ. 2562",
                  "นางสาวนิตยา ขนาดผล",
                  [
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    ),
                    new ItemsTrackingSubDetail(
                        "นาย",
                        "สามารถ",
                        "ปรารถนา"
                    )
                  ]
              ),

            ]
        )
      ],
    ),
    new ItemsTrackingMain(
      8,
      "รอแบ่งเงินรางวัล",
      [],
    ),
  ];


  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      TrackingMainScreenFragment(
                        Type: itemMain[index].TrackingType,
                        Items: itemMain[index].HeadLists,
                        Title: itemMain[index].TrackingName,
                      ),
                  ));
            },
            child: Container(
                width: size.width / 2.5,
                padding: EdgeInsets.only(
                    top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                          color: Colors.grey[500], width: 1.0),
                      bottom: BorderSide(
                          color: Colors.grey[500], width: 1.0),
                      left: BorderSide(
                          color: Colors.grey[500], width: 1.0),
                      right: BorderSide(
                          color: Colors.grey[500], width: 1.0),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 22.0, bottom: 4.0),
                          child: Text(
                            itemMain[index].TrackingName,
                            style: textStyleLabel,)
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 22.0, bottom: 4.0),
                        child: Text(itemMain[index].HeadLists.length.toString(),
                          style: textStyleData,)
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 22.0, bottom: 4.0),
                        child: Text("รายการ", style: textDataSubStyle,)
                    ),
                  ],
                )
            ),
          ),
        );
      },
      itemCount: itemMain.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_13_00_01_00',
                            style: textStylePageName),
                      ),
                    ],
                  ),
                  ],
                )*/
            ),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }
}