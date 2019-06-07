import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/return_accept_case_screen.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_list.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/future/return_future.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/return_not_accept_case_screen_1.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_search.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/picker/date_picker_lawsuit_search.dart';

class ReturnMainScreenFragmentSearchResult extends StatefulWidget {
  ItemsPersonInformation ItemsPerson;
  List<ItemsReturnList> ItemSearch;
  ReturnMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ReturnMainScreenFragmentSearchResult> {

  List<ItemsReturnList> _searchResult = [];
  ItemsReturnArrestMain returnMain;
  ItemsReturnMain _itemsReturnMain;

  var dateFormatDate;

  List person_return = ['นายสิทธิชัย วัณลพ','นายสิทธิชัย วัณลพ','นายสิทธิชัย วัณลพ'];
  List numberBook_return = ['กค 0809.1/2561 ','กค 0809.2/2561 ','กค 0809.3/2561 '];

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
    Color labelColorEdit= Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelColorPreview,fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit,fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle textStyleDataSub = TextStyle(fontSize: 16,color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    TextStyle textStyleButtonAccept = TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontStyles().FontFamily);
    TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16,color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);

    return ListView.builder(
      itemCount: numberBook_return.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {

        String suspect="";
        String subSuspect = "";
        if(_searchResult[index].IndicmentDetail.length>0){
          suspect = _searchResult[index].IndicmentDetail[0]
              .TITLE_SHORT_NAME_TH +
              _searchResult[index].IndicmentDetail[0]
                  .FIRST_NAME + " " +
              _searchResult[index].IndicmentDetail[0]
                  .LAST_NAME;

          if( _searchResult[index].IndicmentDetail.length==2){
            subSuspect+=_searchResult[index].IndicmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _searchResult[index].IndicmentDetail[1]
                    .FIRST_NAME + " " +
                _searchResult[index].IndicmentDetail[1]
                    .LAST_NAME;
          }else if(_searchResult[index].IndicmentDetail.length>2){
            subSuspect+=_searchResult[index].IndicmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _searchResult[index].IndicmentDetail[1]
                    .FIRST_NAME + " " +
                _searchResult[index].IndicmentDetail[1]
                    .LAST_NAME+" และคนอื่นๆ "+(_searchResult[index].IndicmentDetail.length-2).toString()+" คน";
          }
        }else{
          suspect="-";
        }

        String lawsuit_year = "";
        if(_searchResult[index].INDICTMENT_IS_LAWSUIT_COMPLETE==1){
          DateTime dt_lawsuit_year = DateTime.parse(_searchResult[index].LAWSUIT_NO_YEAR);
          List splitslawYear = dateFormatDate.format(dt_lawsuit_year).toString().split(
              " ");
          lawsuit_year = (int.parse(splitslawYear[3]) + 543).toString();
        }

        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขที่หนังสือนำส่งคืน", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(numberBook_return[index], style: textInputStyle,),
                      ),
                      
                    ],
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ผู้นำส่งคืน", style: textLabelStyle,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingInputBox,
                        child: Text('${person_return[index]}',
                          style: textInputStyle,),
                      ),
                    ],
                  ),
                ],
              ),
              _searchResult[index].INDICTMENT_IS_LAWSUIT_COMPLETE==1
                  ?Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: new Card(
                            color:labelColor,
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
                                      _navigateLawsuitPreview(context,_searchResult[index].INDICTMENT_ID,true,false,_searchResult[index].LAWSUIT_ID);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text("เรียกดู", style: textPreviewStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
                    ],
                  )
                ],
              ):Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
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
                           
                        ),
                      ),
                      new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Color(0xff087de1), width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                              width: 100.0,
                              //height: 40,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigateLawsuitNotAcceptCase(
                                        context,_searchResult[index].INDICTMENT_ID);
                                  },
                                  splashColor: Color(0xff087de1),
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text("เรียกดู",
                                      style: textStyleButtonNotAccept,),),
                                ),
                              )
                          )
                      ),
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
  Future<bool> onLoadActionGetLawsuitIndicment(Map map,bool IsPreview,LAWSUIT_ID) async {
    await new ReturnFuture().apiRequestLawsuiltArrestIndictmentgetByCon(map).then((onValue) {
      returnMain = onValue;
    });
    if(IsPreview){
      Map map_law = {
        "LAWSUIT_ID": LAWSUIT_ID
        /*"LAWSUIT_ID": 161*/
      };
      await new ReturnFuture().apiRequestLawsuitgetByCon(map_law).then((onValue) {
        print(onValue.LAWSUIT_ID);
        _itemsReturnMain = onValue;
      });
    }

    setState(() {});
    return true;
  }
  _navigateLawsuitPreview(BuildContext context,int INDICTMENT_ID,IsPreview,IsUpdate,LAWSUIT_ID) async {
    print(LAWSUIT_ID);
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
      /*"INDICTMENT_ID" : 272*/
    };
    await onLoadActionGetLawsuitIndicment(map,true,LAWSUIT_ID);
    Navigator.pop(context);
    if (returnMain!= null||_itemsReturnMain!=null) {
      if(_itemsReturnMain.IS_LAWSUIT==0){
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReturnNotAcceptCaseMainScreenFragment(
            ItemsPerson: widget.ItemsPerson,
            itemsReturnMain: returnMain,
            IsPreview: true,
            itemsPreview: _itemsReturnMain,
          )),
        );
      }else{
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
            ItemsReturnMain: returnMain,
            ItemsPerson: widget.ItemsPerson,
            IsEdit: IsUpdate,
            IsPreview: IsPreview,
            IsCreate: false,
            itemsPreview: _itemsReturnMain,
          )),
        );
        if(result.toString()!="Back"){
          Navigator.pop(context);
        }
      }
    }
  }

  _navigateLawsuitNotAcceptCase(BuildContext context,int INDICTMENT_ID) async {
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
    await onLoadActionGetLawsuitIndicment(map,false,null);
    Navigator.pop(context);
    if (returnMain!= null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReturnNotAcceptCaseMainScreenFragment(
          ItemsPerson: widget.ItemsPerson,
          itemsReturnMain: returnMain,
          IsPreview: false,)),
      );
      if(result.toString()!="Back"){
        Navigator.pop(context);
      }
    }

  }
  _navigateLawsuitAcceptCase(BuildContext context,int INDICTMENT_ID) async {
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
    await onLoadActionGetLawsuitIndicment(map,false,null);
    Navigator.pop(context);
    if (returnMain!= null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
          itemsReturnMain: returnMain,
          ItemsPerson: widget.ItemsPerson,
          IsEdit: false,
          IsPreview: false,
          IsCreate: true,
          itemsPreview: null,
        )),
      );
      if(result.toString()!="Back"){
        Navigator.pop(context);
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
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ค้นหางานคืนของกลาง",
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              //height: 34.0,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
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
    ),
    );
  }
}