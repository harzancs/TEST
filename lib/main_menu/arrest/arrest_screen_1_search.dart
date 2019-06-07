import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/arrest_screen_1.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class ArrestMainScreenFragmentSearch extends StatefulWidget {
  ItemsPersonInformation ItemsData;
  ItemsMasterTitleResponse itemsTitle;
  ArrestMainScreenFragmentSearch({
    Key key,
    @required this.ItemsData,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _ArrestMainScreenFragmentSearchSearchState createState() => new _ArrestMainScreenFragmentSearchSearchState();
}

class _ArrestMainScreenFragmentSearchSearchState extends State<ArrestMainScreenFragmentSearch> {

  Future<List<ItemsListArrestSearch>> apiRequest(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestListgetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrestSearch.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  TextEditingController controller = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  List<ItemsListArrestSearch> _searchResult = [];
  List<ItemsListArrestSearch> _itemsData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
  }

  CupertinoAlertDialog _cupertinoSearchEmpty(mContext) {
    TextStyle TitleStyle = TextStyle(
        fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ไม่พบข้อมูล.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                controller.clear();
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showSearchEmptyAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context);
      },
    );
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await apiRequest(map).then((onValue) {
      _searchResult = onValue;
      /*_searchResult.forEach((f) {
        print(f.ARREST_ID.toString());
      });*/
    });
    setState(() {});
    return true;
  }

  //on submitted search
  onSearchTextSubmitted(String text, mContext, IsAction) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    //Map map = {'TEXT_SEARCH': text, 'ACCOUNT_OFFICE_CODE': widget.ItemsData.UnderOffCode};
    Map map = {'TEXT_SEARCH': text, 'ACCOUNT_OFFICE_CODE': "000000"};
    await onLoadAction(map);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      if (!IsAction) {
        _showSearchEmptyAlertDialog(mContext);
      }
    }
  }


  ItemsListArrestMain _arrestMain;
  List<ItemsListArrest6Section> _listGuiltbase = [];
  //on show dialog
  Future<bool> onLoadActionGetAll(Map map) async {
    await new ArrestFuture().apiRequestGet(map).then((onValue) {
      _arrestMain = onValue;
    });

    Map map_guiltbase = {
      "TEXT_SEARCH": ""
    };
    await new ArrestFuture().apiRequestArrestMasGuiltbasegetByKeyword(map_guiltbase).then((onValue) {
      _listGuiltbase=onValue;
    });
    setState(() {});
    return true;
  }

  _navigateArrestTab(BuildContext context, IsPreview, IsUpdate,
      ARREST_ID) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {'ARREST_ID': ARREST_ID};
    await onLoadActionGetAll(map);
    Navigator.pop(context);

    if (_arrestMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            ArrestMainScreenFragment(
              IsPreview: IsPreview,
              IsCreate: false,
              IsUpdate: IsUpdate,
              ITEMS_ARREST: _arrestMain,
              ItemsPerson: widget.ItemsData,
              itemsTitle: widget.itemsTitle,
              ItemsGuiltbase: _listGuiltbase,
            )),
      );
      //load again
      onSearchTextSubmitted(controller.text, context, true);
      //Navigator.pop(context, result);
    }
  }


  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit = Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(
        fontSize: 16.0,
        color: labelColorPreview,
        fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0,
        color: labelColorEdit,
        fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textSubInputStyle = TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                //color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(
              children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("เลขที่ใบงาน", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].ARREST_CODE, style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อผู้จับ", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].TITLE_SHORT_NAME_TH +
                          _searchResult[index].FIRST_NAME + " " +
                          _searchResult[index].LAST_NAME,
                      style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("สถานที่เกิดเหตุ", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].SUB_DISTRICT_NAME_TH + "/" +
                          _searchResult[index].DISTRICT_NAME_TH + "/" +
                          _searchResult[index].PROVINCE_NAME_TH,
                      style: textInputStyle,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: new Card(
                            color: labelColor,
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: labelColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigateArrestTab(context, true, false,
                                          _searchResult[index].ARREST_ID);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        "เรียกดู", style: textPreviewStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
                      _searchResult[index].IS_LAWSUIT_COMPLETE == 0 ? new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: labelColor, width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                              width: 100.0,
                              //height: 40,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigateArrestTab(context, false, true,
                                        _searchResult[index].ARREST_ID);
                                  },
                                  splashColor: labelColor,
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      "แก้ไข", style: textEditStyle,),),
                                ),
                              )
                          )
                      ) : Container(),
                    ],
                  )
                ],
              ),
            ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(
        fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery
        .of(context)
        .size;

    return new Theme(
      data: new ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.grey[400]
      ),
      child: Scaffold(
          //backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Row(children: <Widget>[
                  new SizedBox(width: 10.0,),
                  new Expanded(child: new Stack(
                      alignment: const Alignment(1.0, 1.0),
                      children: <Widget>[
                        new TextField(
                          style: styleTextSearch,
                          decoration: InputDecoration(
                            hintText: 'ค้นหา', hintStyle: styleTextSearch,),
                          onChanged: (text) {
                            setState(() {});
                          },
                          onSubmitted: (String text) {
                            onSearchTextSubmitted(text, context, false);
                          },
                          controller: controller,),
                        controller.text.length > 0 ? new IconButton(
                            icon: new Icon(Icons.clear), onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        }) : new Container(height: 0.0,)
                      ]
                  ),),
                ],
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,), onPressed: () {
                Navigator.pop(context, _itemsData);
              }),
            ),
          ),
          body: Stack(
            children: <Widget>[
              BackgroundContent(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                          )
                      ),
                    ),
                    Expanded(
                      child: _searchResult.length != 0 ||
                          controller.text.isNotEmpty
                          ? _buildSearchResults() : new Container(),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
