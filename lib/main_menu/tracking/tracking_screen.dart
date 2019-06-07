import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_deatil_type_1_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_deatil_type_2_screen.dart';

class TrackingMainScreenFragment extends StatefulWidget {
  int Type;
  List Items;
  String Title;
  TrackingMainScreenFragment({
    Key key,
    @required this.Type,
    @required this.Items,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<TrackingMainScreenFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  Widget _buildContent_type1(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 18.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: widget.Items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          String label_title,label_sub;
          if(widget.Type==1){
            label_title="เลขใบงานจับกุม";
            label_sub="ผู้กล่าวหา";
          }else if(widget.Type==2||widget.Type==3||widget.Type==4||widget.Type==5){
            label_title="เลขรับคำกล่าวโทษ";
            label_sub="ผู้ต้องหา";
          }else if(widget.Type==6){
            label_title="เลขที่ใบเสร็จ";
            label_sub="ผู้ต้องหา";
          }else{
            label_title="";
            label_sub="";
          }

          return GestureDetector(
            onTap: (){
              if(widget.Type==1){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        TrackingDetailType1ScreenFragment(
                          Type: widget.Type,
                          Title: widget.Title,
                          Data: widget.Items[index],
                        ),
                    ));
              }else{
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        TrackingDetailType2ScreenFragment(
                          Type: widget.Type,
                          Title: widget.Title,
                          Items: widget.Items[index].TrackingList,
                        ),
                    ));
              }

            },
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 22.0,right: 22.0,top: 12.0,bottom: 12.0),
                    child: Stack(children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  label_title, style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Icon(Icons.navigate_next),
                              ),
                            ],
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items[index].Number,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(label_sub, style: textLabelStyle,),
                          ),
                          /*Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items[index].Detail.length>0?widget.Items[index].Detail[0].TitleName+
                                  widget.Items[index].Detail[0].FirstName+" "+
                                  widget.Items[index].Detail[0].LastName:"",
                              style: textInputStyle,),
                          ),*/
                        ],
                      ),
                    ],
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildContent_type2(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 18.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: widget.Items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          String label_title,label_sub;
          if(widget.Type==1){
            label_title="เลขใบงานจับกุม";
            label_sub="ผู้กล่าวหา";
          }else if(widget.Type==2||widget.Type==3||widget.Type==4||widget.Type==5){
            label_title="เลขรับคำกล่าวโทษ";
            label_sub="ผู้ต้องหา";
          }else if(widget.Type==6){
            label_title="เลขที่ใบเสร็จ";
            label_sub="ผู้ต้องหา";
          }else if(widget.Type==7){
            label_title="เลขที่เปรียบเทียบคดี";
            label_sub="ผู้ต้องหา";
          }else{
            label_title="";
            label_sub="";
          }

          return GestureDetector(
            onTap: (){
              if(widget.Type==1){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        TrackingDetailType1ScreenFragment(
                          Type: widget.Type,
                          Title: widget.Title,
                          Data: widget.Items[index],
                        ),
                    ));
              }else{
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        TrackingDetailType2ScreenFragment(
                          Type: widget.Type,
                          Title: widget.Title,
                          Items: widget.Items[index].TrackingList,
                        ),
                    ));
              }

            },
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 22.0,right: 22.0,top: 12.0,bottom: 12.0),
                    child: Stack(children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  label_title, style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Icon(Icons.navigate_next),
                              ),
                            ],
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items[index].TrackingNumber,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(label_sub, style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              "นายสามารถ  ปรารถนา ",
                              style: textInputStyle,),
                          ),
                        ],
                      ),
                    ],
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
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
            IconButton(icon: Icon(Icons.search), onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      TrackingBookSearchScreenFragment(),
                  ));
            })
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
                          child: new Text('ILG60_B_13_00_03_00',
                            style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
                          child: new Text('รวม '+widget.Items.length.toString()+' คดี',
                              style: textLabelStyle),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Expanded(
              child: widget.Type==1?_buildContent_type1(context):_buildContent_type2(context),
            ),
          ],
        ),
      ),
    ),
    );
  }
}