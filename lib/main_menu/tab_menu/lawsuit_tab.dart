import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/lawsuit_accept_case_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/future/lawsuit_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/lawsuit_not_accept_case_screen_1.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class LawsuitFragment extends StatefulWidget {
  ItemsPersonInformation ItemsPerson;
  ItemsArrestResponseGetOffice itemsOffice;
  LawsuitFragment({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsOffice,
  }) : super(key: key);
  @override
  _LawsuitFragmentState createState() => new _LawsuitFragmentState();
}
class _LawsuitFragmentState extends State<LawsuitFragment> {

  //style content
  TextStyle textStyleLanding = TextStyle(
      fontSize: 20, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLabel = TextStyle(fontSize: 16,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(
      fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily,
      fontSize: 12.0);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16,
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = TextStyle(
      fontSize: 16, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);

  //item data
  List<ItemsLawsuitList> itemsLawsuit = [];
  ItemsLawsuitArrestMain lawsuitMain;

  @override
  void initState() {
    super.initState();
    //_onRequestData();
  } //on show dialog
  Future<bool> onLoadActionGetLawsuitIndicment(Map map) async {
    await new LawsuitFuture()
        .apiRequestLawsuiltArrestIndictmentgetByCon(map)
        .then((onValue) {
      lawsuitMain = onValue;
    });
    setState(() {});
    return true;
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: itemsLawsuit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String suspect = "";
        String subSuspect = "";
        if (itemsLawsuit[index].IndicmentDetail.length > 0) {
          suspect = itemsLawsuit[index].IndicmentDetail[0]
              .TITLE_SHORT_NAME_TH.toString() +
              itemsLawsuit[index].IndicmentDetail[0]
                  .FIRST_NAME.toString() + " " +
              itemsLawsuit[index].IndicmentDetail[0]
                  .LAST_NAME.toString();

          if (itemsLawsuit[index].IndicmentDetail.length == 2) {
            subSuspect += itemsLawsuit[index].IndicmentDetail[1]
                .TITLE_SHORT_NAME_TH.toString() +
                itemsLawsuit[index].IndicmentDetail[1]
                    .FIRST_NAME.toString() + " " +
                itemsLawsuit[index].IndicmentDetail[1]
                    .LAST_NAME.toString();
          } else if (itemsLawsuit[index].IndicmentDetail.length > 2) {
            subSuspect += itemsLawsuit[index].IndicmentDetail[1]
                .TITLE_SHORT_NAME_TH.toString() +
                itemsLawsuit[index].IndicmentDetail[1]
                    .FIRST_NAME.toString() + " " +
                itemsLawsuit[index].IndicmentDetail[1]
                    .LAST_NAME.toString() + " และคนอื่นๆ " +
                (itemsLawsuit[index].IndicmentDetail.length - 2)
                    .toString() + " คน";
          }
        } else {
          suspect = "-";
        }

        return Padding(
          padding: EdgeInsets.only(/*top: 4.0,*/ bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(
                      color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(
                      color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "เลขที่ใบงาน", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemsLawsuit[index].ARREST_CODE,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ฐานความผิดมาตรา", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemsLawsuit[index].SECTION_NAME,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ชื่อผู้ต้องหา", style: textStyleLabel,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingData,
                        child: Text(suspect,
                          style: textStyleData,),
                      ),
                      itemsLawsuit[index].IndicmentDetail.length >
                          1
                          ? Container(
                        padding: paddingData,
                        child: Text(subSuspect,
                          style: textStyleDataSub,),
                      )
                          : Container(),
                    ],
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
                            color: Color(0xff087de1),
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: Color(0xff087de1),
                                    width: 1.5),
                                borderRadius: BorderRadius
                                    .circular(
                                    12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigateLawsuitAcceptCase(
                                          context,
                                          itemsLawsuit[index]
                                              .INDICTMENT_ID);
                                    },
                                    splashColor: Color(
                                        0xff087de1),
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text("รับคดี",
                                        style: textStyleButtonAccept,),),
                                  ),
                                )
                            )
                        ),
                      ),
                      new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Color(0xff087de1),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(
                                  12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                              width: 100.0,
                              //height: 40,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigateLawsuitNotAcceptCase(
                                        context,
                                        itemsLawsuit[index]
                                            .INDICTMENT_ID);
                                  },
                                  splashColor: Color(0xff087de1),
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text("ไม่รับคดี",
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

  _navigateLawsuitNotAcceptCase(BuildContext context, int INDICTMENT_ID) async {
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
    await onLoadActionGetLawsuitIndicment(map);
    Navigator.pop(context);
    if (lawsuitMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            LawsuitNotAcceptCaseMainScreenFragment(
              ItemsPerson: widget.ItemsPerson,
              itemsLawsuitMain: lawsuitMain,
              IsPreview: false,)),
      );
      if (result.toString() != "Back") {
        //itemsCaseInformation = result;
        print("resut : " + result.toString());
      }
    }
  }

  _navigateLawsuitAcceptCase(BuildContext context, int INDICTMENT_ID) async {
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
    await onLoadActionGetLawsuitIndicment(map);
    Navigator.pop(context);
    if (lawsuitMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            LawsuitAcceptCaseMainScreenNonProofFragment(
              itemsLawsuitMain: lawsuitMain,
              ItemsPerson: widget.ItemsPerson,
              itemsOffice: widget.itemsOffice,
              IsEdit: false,
              IsPreview: false,
              IsCreate: true,
              itemsPreview: null,
            )),
      );
      if (result.toString() != "Back") {
        //itemsCaseInformation = result;

        print("resut : " + result.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map map = {
      "ARREST_CODE": "",
      "OCCURRENCE_DATE_FROM": "",
      "OCCURRENCE_DATE_TO": "",
      "ARREST_NAME": "",
      "ARREST_OFFICE_NAME": "",
      "SUBSECTION_NAME": "",
      "GUILTBASE_NAME": "",
      "LAWSUIT_NO": "",
      "LAWSUIT_NO_YEAR": "",
      "IS_OUTSIDE": "",
      "LAWSUILT_DATE_FROM": "",
      "LAWSUILT_DATE_TO": "",
      "LAWSUILT_OFFICE_NAME": "",
      "LAWSUILT_NAME": "",
      "IS_LAWSUIT_COMPLETE": 0,
      "ACCOUNT_OFFICE_CODE": "000000"
    };

    return FutureBuilder<List<ItemsLawsuitList>>(
      future: new LawsuitFuture().apiRequestLawsuiltListgetByConAdv(map),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          itemsLawsuit = snapshot.data;
          return new Scaffold(
            body: Stack(
              children: <Widget>[
                BackgroundContent(),
                Center(
                  child: itemsLawsuit.length != 0 ?Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey[300], width: 1.0),
                            )
                        ),
                      ),
                      Expanded(
                        child: _buildContent(context),
                      ),
                    ],
                  )
                      :Stack(
                    children: <Widget>[
                      new Center(
                          child: new Container(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "ไม่มีรายการเปรียบเทียบคดี", style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey[500],
                                    fontFamily: FontStyles().FontFamily),)
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            )
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CupertinoActivityIndicator(
              ),
            )
          ],
        );
      },
    );
  }
}