import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_list.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class CompareMainScreenFragmentSearchResult extends StatefulWidget {
  ItemsPersonInformation ItemsPerson;
  List<ItemsCompareList> ItemSearch;
  CompareMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareMainScreenFragmentSearchResult> {

  List<ItemsCompareList> _searchResult = [];
  //ItemsCompareArrestMain _compareArrestMain;
  ItemsCompareArrestMain _compareArrestMain;
  ItemsCompareMain itemsCompareMain;

  var dateFormatDate;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');

    _searchResult = widget.ItemSearch;
  }
  @override
  void dispose() {
    super.dispose();
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
    TextStyle textStyleButtonAccept = TextStyle(
        fontSize: 16, color: Colors.white,fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textStyleDataSub = TextStyle(
        fontSize: 16,
        color: Colors.grey[400],
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String lawsuit_year = "",compare_year="";
        /*DateTime dt_lawsuit_year = DateTime.parse(
            _searchResult[index].LAWSUIT_NO_YEAR);*/
        DateTime dt_lawsuit_year = _searchResult[index].LAWSUIT_NO_YEAR!=null
            ?DateTime.parse(_searchResult[index].LAWSUIT_NO_YEAR)
            :DateTime.now();

        List splitslawYear = dateFormatDate.format(dt_lawsuit_year)
            .toString()
            .split(
            " ");
        lawsuit_year = (int.parse(splitslawYear[3]) + 543).toString();


        String compare_name ;
        if(_searchResult[index].COMPARE_ID!=0){
          /*DateTime dt_compare_year = DateTime.parse(
              _searchResult[index].COMPARE_NO_YEAR);*/
          DateTime dt_compare_year = _searchResult[index].COMPARE_NO_YEAR!=null
              ?DateTime.parse(_searchResult[index].COMPARE_NO_YEAR)
              :DateTime.now();
          List splitsCompareYear = dateFormatDate.format(dt_compare_year)
              .toString()
              .split(
              " ");
          compare_year = (int.parse(splitsCompareYear[3]) + 543).toString();

          compare_name ="";
          /*_searchResult[index].COMPARE_TITLE_SHORT_NAME_TH != null
              ? _searchResult[index].COMPARE_TITLE_SHORT_NAME_TH
              : _searchResult[index].COMPARE_TITLE_NAME_TH +
              _searchResult[index].COMPARE_FIRST_NAME + " " +
              _searchResult[index].COMPARE_LAST_NAME;*/
        }else {
          compare_name = _searchResult[index].LAWSUIT_TITLE_SHORT_NAME_TH!=null
              ?_searchResult[index].LAWSUIT_TITLE_SHORT_NAME_TH
              :_searchResult[index].LAWSUIT_TITLE_NAME_TH+
              _searchResult[index].LAWSUIT_FIRST_NAME+" "+
              _searchResult[index].LAWSUIT_LAST_NAME;
        }



        return Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(children: <Widget>[
              _searchResult[index].COMPARE_ID != 0 ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("เลขที่เปรียบเทียบคดี", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].COMPARE_NO.toString() + '/' +
                          compare_year, style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อผู้เปรียบเทียบคดี", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(compare_name, style: textInputStyle,),
                  ),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("เลขที่รับคำกล่าวโทษ", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].LAWSUIT_NO.toString() + "/" +
                          lawsuit_year,
                      style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อผู้กล่าวหา", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(compare_name, style: textInputStyle,),
                  ),
                ],
              ),
              _searchResult[index].COMPARE_ID != 0 ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 4.0),
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
                                      _navigatePreview(
                                        context, _searchResult[index].INDICTMENT_ID, _searchResult[index].COMPARE_ID,);
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
                    ],
                  )
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: new Card(
                        color: Color(0xff087de1),
                        shape: new RoundedRectangleBorder(
                            side: new BorderSide(
                                color: Color(0xff087de1), width: 1.5),
                            borderRadius: BorderRadius.circular(12.0)
                        ),
                        elevation: 0.0,
                        child: Container(
                            width: 130.0,
                            //height: 40,
                            child: Center(
                              child: MaterialButton(
                                onPressed: () {
                                  _navigate(
                                      context, _searchResult[index].INDICTMENT_ID);
                                },
                                splashColor: Color(0xff087de1),
                                //highlightColor: Colors.blue,
                                child: Center(
                                  child: Text("ชำระค่าปรับ",
                                    style: textStyleButtonAccept,),),
                              ),
                            )
                        )
                    ),
                  ),
                ],
              ),
            ],
            ),
          ),
        );
      },
    );
  }
  Future<bool> onLoadActionGetCompareIndicment(Map map,bool IsPreview,COMPARE_ID) async {
    await new CompareFuture().apiRequestCompareArrestgetByIndictmentID(map).then((onValue) {
      _compareArrestMain = onValue[0];
    });
    if(IsPreview){
      Map map_law = {
        "COMPARE_ID": COMPARE_ID
      };
      await new CompareFuture().apiRequestComparegetByCon(map_law).then((onValue) {
        itemsCompareMain = onValue;
      });
    }

    setState(() {});
    return true;
  }
  _navigatePreview(BuildContext context,int INDICTMENT_ID,COMPARE_ID) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {
      "INDICTMENT_ID": INDICTMENT_ID
    };
    await onLoadActionGetCompareIndicment(map, true, COMPARE_ID);
    Navigator.pop(context);

    if (_compareArrestMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            CompareMainScreenFragment(
              itemsCompareMain: itemsCompareMain,
              itemsCompareArrestMain: _compareArrestMain,
              ItemsPerson: widget.ItemsPerson,
              IsEdit: false,
              IsPreview: true,
              IsCreate: false,
            )),
      );
      if (result.toString() != "Back") {
        _searchResult = result;
        print("resut : " + result.toString());
      }
    }
  }
  _navigate(BuildContext context,int INDICTMENT_ID) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {
      "INDICTMENT_ID" : INDICTMENT_ID
    };
    await onLoadActionGetCompareIndicment(map,false,null);
    Navigator.pop(context);

    if (_compareArrestMain!= null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            CompareMainScreenFragment(
              itemsCompareMain: null,
              itemsCompareArrestMain : _compareArrestMain,
              ItemsPerson: widget.ItemsPerson,
              IsEdit: false,
              IsPreview: false,
              IsCreate: true,
            )),
      );
      if (result.toString() != "Back") {
        _searchResult = result;
        print("resut : " + result.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ค้นหางานเปรียบเทียบเเละชำระค่าปรับ",
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "Back");
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
                  //height: 34.0,
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text('ILG60_B_02_00_02_00',
                      style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                  )
                ],
              ),*/
                ),
                Expanded(
                  child: _searchResult.length != 0
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