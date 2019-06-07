import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_detail_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_list_arrest_items.dart';

class TrackingDetailType2ScreenFragment extends StatefulWidget {
  int Type;
  List Items;
  String Title;
  TrackingDetailType2ScreenFragment({
    Key key,
    @required this.Type,
    @required this.Items,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<TrackingDetailType2ScreenFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();


  TextStyle textInputStyle = TextStyle(fontSize: 18.0,
      color: Colors.black,
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputSubStyle = TextStyle(fontSize: 16.0,
      color: Colors.black,
      fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(
      fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelHeadStyle = TextStyle(
      fontSize: 18.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 8.0);

  String text_action="";
  @override
  void initState() {
    super.initState();

    if(widget.Type==1){
      text_action="รับคดี";
    }else if(widget.Type==2) {
      text_action="คำพิพากษา";
    }else if(widget.Type==3) {
      text_action="พิสูจน์";
    }else if(widget.Type==4) {
      text_action="เปรียบเทียบ";
    }else if(widget.Type==5) {
      text_action="ชำระค่าปรับ";
    }else{
      text_action="";
    }
  }


  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  void onActionClick(type){
    print(type);
  }

  Widget _buildContentList(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: widget.Items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Widget content=Container();;
          if(widget.Items[index].Type==1){
            content=content_arrest(index);
          }else if(widget.Items[index].Type==2){
            content=content_lawsuit(index);
          } else{
            content=content_lawsuit(index);
          }
          return content;
        },
      )
    );
  }

  Widget content_arrest(index){
    var size = MediaQuery
        .of(context)
        .size;
    String label_title1, label_title2, label_title3;
    label_title1 = "เลขใบงานจับกุม";
    label_title2 = "วันที่เกิดเหตุ";
    label_title3 = "ผู้ต้องหา";


    buildCollapsed() {
      return Row(
        children: <Widget>[
          Container(
            width: size.width / 4,
            child: Container(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 22.0),
              width: 38,
              height: 38,
              decoration: new BoxDecoration(
                color: widget.Items.length>1?(index==widget.Items.length-1?Color(0xfff18488):Color(0xff63d8d9))
                    :Color(0xff63d8d9),
                shape: BoxShape.circle,
              ),
              child: new Icon(
                null,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title1,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Number,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title2,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Date,
                  style: textInputStyle,),
              ),

            ],
          ),
        ],
      );
    }
    Widget ListLawbreaker (index){
      List<Widget> _list=[];
      for(int i=0;i<widget.Items[index].Detail.length;i++){
        _list.add(
            Padding(
              padding: paddingInputBox,
              child: Text(
                widget.Items[index].Detail[i].TitleName+
                    widget.Items[index].Detail[i].FirstName+" "+
                    widget.Items[index].Detail[i].LastName,
                style: textInputStyle,),
            )
        );
      }

      return Container(
        child: Column(
          children: _list,
        ),
      );
    }

    buildExpanded() {
      return Row(
        children: <Widget>[
          Container(
            width: size.width / 4,
            child: Container(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 22.0),
              width: 38,
              height: 38,
              decoration: new BoxDecoration(
                color: widget.Items.length>1?(index==widget.Items.length-1?Color(0xfff18488):Color(0xff63d8d9))
                    :Color(0xff63d8d9),
                shape: BoxShape.circle,
              ),
              child: new Icon(
                null,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title1,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Number,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title2,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Date,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title3,
                  style: textLabelStyle,),
              ),
              ListLawbreaker(index),
            ],
          ),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 12.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            //key: stickyKey,
            //height: size.height / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(
                      color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Container(
              padding: EdgeInsets.only(
                  top: 12.0, bottom: 12.0, right: 12.0),
              child: Stack(children: <Widget>[
                ExpandableNotifier(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expandable(
                        collapsed: buildCollapsed(),
                        expanded: buildExpanded(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Builder(
                            builder: (context) {
                              var exp = ExpandableController.of(context);
                              return FlatButton(
                                  onPressed: () {
                                    exp.toggle();
                                  },
                                  child: Text(
                                    exp.expanded ? "ย่อ..." : "ดูเพิ่มเติม...",
                                    style: textStyleLink,
                                  )
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
              ),
            ),
          ),
          /*index != widget.Items.length - 1 ? Positioned(
              bottom: -30,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width / 4,
                    child: Center(
                      child: Container(
                        width: 1,
                        height: (size.height / 3) / 1.9,
                        color: Color(0xff63d8d9),
                      ),
                    ),
                  )
                ],
              )
          ) : Container(),
          index != 0 ? Positioned(
              top: -(size.height / 3) / 1.5,
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width / 4,
                    child: Center(
                      child: Container(
                        width: 1,
                        height: (size.height / 3) / 2.2,
                        color: Color(0xff63d8d9),
                      ),
                    ),
                  )
                ],
              )
          ) : Container(),*/
        ],
      ),
    );
  }
  Widget content_lawsuit(index) {
    var size = MediaQuery
        .of(context)
        .size;
    String label_title1, label_title2, label_title3, label_title4;
    if(widget.Items[index].Type==2){
      label_title1 = "เลขรับคำกล่าวโทษ";
      label_title2 = "วันที่รับคำกล่าวโทษ";
      label_title3 = "ผู้ต้องหา";
      label_title4 = "หมายเลขคดีดำ";
    }else if(widget.Items[index].Type==3){
      label_title1 = "เลขรับคำกล่าวโทษ";
      label_title2 = "วันที่รับคำกล่าวโทษ";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    }else if(widget.Items[index].Type==4){
      label_title1 = "ทะเบียนตรวจพิสูจน์";
      label_title2 = "วันที่พิสูจน์ของกลาง";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    } else if(widget.Items[index].Type==5){
      label_title1 = "เลขเปรียบเทียบคดี";
      label_title2 = "วันที่เปรียบเทียบ";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    }else if(widget.Items[index].Type==6){
      label_title1 = "เลขที่ใบเสร็จ/เล่มที่ใบเสร็จ";
      label_title2 = "วันที่ชำระค่าปรับ";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    }else if(widget.Items[index].Type==7){
      label_title1 = "เลขที่นำส่งเงิน";
      label_title2 = "วันที่นำส่ง";
      label_title3 = "ชื่อผู้ต้องหาคดีส่งฟ้องศาล";
      label_title4 = "ชื่อผู้ต้องหาคดีเปรียบเทียบ";
    }



    Widget ListLawbreaker (index){
      List<Widget> _list=[];
      for(int i=0;i<widget.Items[index].Detail.length;i++){
        _list.add(
            Padding(
              padding: paddingInputBox,
              child: Text(
                widget.Items[index].Detail[i].TitleName+
                    widget.Items[index].Detail[i].FirstName+" "+
                    widget.Items[index].Detail[i].LastName,
                style: textInputStyle,),
            )
        );
      }

      return Container(
        child: Column(
          children: _list,
        ),
      );
    }

    buildCollapsed() {
      return Row(
        children: <Widget>[
          Container(
            width: size.width / 4,
            child: Container(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 22.0),
              width: 38,
              height: 38,
              decoration: new BoxDecoration(
                color: widget.Items.length > 1 ? (index ==
                    widget.Items.length - 1
                    ? Color(0xfff18488)
                    : Color(0xff63d8d9))
                    : Color(0xff63d8d9),
                shape: BoxShape.circle,
              ),
              child: new Icon(
                null,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title1,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Number,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title2,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Date,
                  style: textInputStyle,),
              ),
            ],
          ),
        ],
      );
    }

    buildExpanded() {
      return Row(
        children: <Widget>[
          Container(
            width: size.width / 4,
            child: Container(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 22.0),
              width: 38,
              height: 38,
              decoration: new BoxDecoration(
                color: widget.Items.length > 1 ? (index ==
                    widget.Items.length - 1
                    ? Color(0xfff18488)
                    : Color(0xff63d8d9))
                    : Color(0xff63d8d9),
                shape: BoxShape.circle,
              ),
              child: new Icon(
                null,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title1,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Number,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title2,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].Date,
                  style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title3,
                  style: textLabelStyle,),
              ),
              ListLawbreaker(index),
              Container(
                padding: paddingLabel,
                child: Text(
                  label_title4,
                  style: textLabelStyle,),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(widget.Items[index].UndecidedNumber,
                  style: textInputStyle,),
              ),
            ],
          ),
        ],
      );
    }
    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 12.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            //height: size.height / 3,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(
                      color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Container(
              padding: EdgeInsets.only(
                  top: 12.0, bottom: 12.0, right: 12.0),
              child: Stack(children: <Widget>[
                ExpandableNotifier(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expandable(
                        collapsed: buildCollapsed(),
                        expanded: buildExpanded(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Builder(
                            builder: (context) {
                              var exp = ExpandableController.of(context);
                              return FlatButton(
                                  onPressed: () {
                                    exp.toggle();
                                  },
                                  child: Text(
                                    exp.expanded ? "ย่อ..." : "ดูเพิ่มเติม...",
                                    style: textStyleLink,
                                  )
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
              ),
            ),
          ),
          /*index != widget.Items.length - 1 ? Positioned(
              bottom: -30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width / 4,
                    child: Center(
                      child: Container(
                        width: 1,
                        height: (size.height / 3) / 1.9,
                        color: Color(0xff63d8d9),
                      ),
                    ),
                  )
                ],
              )
          ) : Container(),
          index != 0 ? Positioned(
              top: -(size.height / 3) / 1.5,
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width / 4,
                    child: Center(
                      child: Container(
                        width: 1,
                        height: (size.height / 3) / 2.2,
                        color: Color(0xff63d8d9),
                      ),
                    ),
                  )
                ],
              )
          ) : Container(),*/
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text(widget.Title,
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  onActionClick(widget.Type);
                },
                child: Text(text_action, style: styleTextAppbar))
            /*IconButton(icon: Icon(Icons.search), onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      StockBookSearchScreenFragment(),
                  ));
            })*/
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                          child: new Text('ILG60_B_13_00_04_00',
                            style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Expanded(
              child: _buildContentList(context),
            ),
          ],
        ),
      ),
    ),
    );
  }
}