import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_detail_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_reward_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_form_list.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';

class CompareMainScreenFragment extends StatefulWidget {
  ItemsCompareMain itemsCompareMain;
  ItemsCompareArrestMain itemsCompareArrestMain;
  ItemsPersonInformation ItemsPerson;
  bool IsPreview;
  bool IsEdit;
  bool IsCreate;
  CompareMainScreenFragment({
    Key key,
    @required this.itemsCompareMain,
    @required this.itemsCompareArrestMain,
    @required this.ItemsPerson,
    @required this.IsEdit,
    @required this.IsPreview,
    @required this.IsCreate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareMainScreenFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ชำระค่าปรับ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  //item หลักทั้งหมด
  ItemsCompareMain itemMain;

  ItemsCompareArrestMain _compareArrestMain;

  //item forms
  List<ItemsCompareForms> itemsFormsTab=[];

  //วันที่อละเวลาปัจจุบัน
  String _currentProveDate,
      _currentProveTime;
  var dateFormatDate, dateFormatTime;
  //_dt
  DateTime _dtCheckEvidence = DateTime.now();
  //node focus ตรวจรับของกลาง
  final FocusNode myFocusNodeCheckEvidenceNumber = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceYear = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePlace = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePersonName = FocusNode();
  //textfield ตรวจรับของกลาง
  TextEditingController editCheckEvidenceNumber= new TextEditingController();
  TextEditingController editCheckEvidenceYear = new TextEditingController();
  TextEditingController editCheckEvidencePlace= new TextEditingController();
  TextEditingController editCheckEvidencePersonName = new TextEditingController();


  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);

  TextStyle textStyleLabel = TextStyle(
      fontSize: 16, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textDataTitleStyle = TextStyle(fontSize: 18, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0);
  TextStyle textStyleBill = TextStyle(color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButtonAccept = TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  TextStyle textStyleTitleLabel = TextStyle(fontSize: 16,color: Colors.black54,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleTitleData = TextStyle(fontSize: 18,color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);



  @override
  void initState() {
    super.initState();

    _compareArrestMain = widget.itemsCompareArrestMain;

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    //วันและเวลาตรวจสอบของกลาง
    _currentProveDate = date;
    _currentProveTime = dateFormatTime.format(DateTime.now()).toString();

    itemMain=widget.itemsCompareMain;
    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      _setInitDataProve();
      _setDataSaved();
    }
    if (widget.IsEdit) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      //_onEdited = widget.IsEdit;
      _setInitDataProve();
    }

    _compareArrestMain = widget.itemsCompareArrestMain;
  }
  void _setInitDataProve() {
    //tab 2
   /* editCheckEvidenceNumber.text = itemMain.CheckEvidence.Number;
    editCheckEvidenceYear.text = itemMain.CheckEvidence.Year;
    editCheckEvidencePlace.text = itemMain.CheckEvidence.Place;
    editCheckEvidencePersonName.text = itemMain.CheckEvidence.Person;
    _currentProveDate=itemMain.CheckEvidence.Date;
    _currentProveTime=itemMain.CheckEvidence.Time;*/
  }

  void _setDataSaved() {
    choices[0].title="ข้อมูลชำระค่าปรับ";
    _onFinish=true;

    if(choices.length==2) {
      //เพิ่ม tab แบบฟอร์ม
      choices.add(Choice(title: 'แบบฟอร์ม'));
      //เพิ่ม item forms
      itemsFormsTab.add(new ItemsCompareForms("แบบฟอร์มบันทึกการเปรียบเทียบคดี",""));
      itemsFormsTab.add(new ItemsCompareForms("แบบฟอร์มคำให้การของผู้ต้องหา","นายสมชาย ไขแสง"));
      itemsFormsTab.add(new ItemsCompareForms("ใบเสร็จรับเงิน","นายสมชาย ไขแสง"));
    }
    tabController =
        TabController(length: choices.length, vsync: this);
    _tabPageSelector =
    new TabPageSelector(controller: tabController);
  }


  @override
  void dispose() {
    super.dispose();
    //dismiss textfield for tab 2
    editCheckEvidenceNumber.dispose();
    editCheckEvidenceYear.dispose();
    editCheckEvidencePlace.dispose();
    editCheckEvidencePersonName.dispose();
  }

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        choices.removeAt(choices.length - 1);
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }
  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการลบข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[

          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _onSaved = false;
                  _onEdited = false;
                  _onSave = false;
                  clearTextfield();
                  choices.removeAt(choices.length - 1);

                  Navigator.pop(context, itemMain);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  //แสดง dialog ลบรายการ
  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  //ล้างข้อมูลใน text field
  void clearTextfield() {

  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน cancel dialog
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการยกเลิกข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[

          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);

                if (!_onEdited) {
                  Navigator.pop(mContext, "Back");
                } else {
                  setState(() {
                    _onSaved = true;
                    _onEdited = false;
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  //แสดง dialog ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }
  //เมื่อกดปุ่มบันทึก
  void onSaved() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction();
    Navigator.pop(context);

    setState(() {
      //เมื่อกดบันทึก
      _onSaved = true;
      _onFinish = true;

      //

      _setDataSaved();
      //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
      tabController.animateTo((choices.length - 1));
    });
  }

  //timing progress dialog
  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_onSaved) {
            if (_onEdited) {
              _onEdited = false;
              _onSaved = false;
            } else {
              Navigator.pop(context, itemMain);
            }
          } else {
            Navigator.pop(context, itemMain);
          }
        });
      },
      child: Scaffold(
        body: CustomScrollView(
          //physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: new Text("เปรียบเทียบและชำระค่าปรับ",
                style: appBarStyle,
              ),
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    if(_onSaved) {
                      Navigator.pop(context, "Back");
                    }else{
                      _showCancelAlertDialog(context);
                    }
                  }),
            ),
            SliverFillRemaining(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(140.0),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[500],
                    labelStyle: tabStyle,
                    controller: tabController,
                    isScrollable: false,
                    tabs: choices.map((Choice choice) {
                      return Tab(
                        text: choice.title,
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  //physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: _onFinish ? <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                  ] :
                  <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************end_tab_1*******************************
  _navigate(BuildContext context,String law_name,ItemsCompareListIndicmentDetail indicmentDetail,bool IsCreate,bool IsPreview,double fine_value) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CompareDetailScreenFragment(
          Title: law_name,
          ItemsPerson: widget.ItemsPerson,
          itemsCompareMain: itemMain,
          itemsCompareArrestMain: widget.itemsCompareArrestMain,
          itemsCompareListIndicmentDetail: indicmentDetail,
          IsCreate: IsCreate,
          IsPreview: IsPreview,
          FINE_VALUE: fine_value,
        )),
      );
      if(result.toString()!="Back") {
        itemMain = result;
        /*itemMain.Informations.Suspects[index] = result;
        if(itemMain.Informations.IsCompare){
          _setDataSaved();
        }*/
      }
  }

  Widget _buildContent_tab_1() {
    //style content
    var size = MediaQuery
        .of(context)
        .size;

    Widget _buildContent(BuildContext context) {
      return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: <Widget>[
                itemMain!=null ? Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: EdgeInsets.all(22.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Container(
                              width: size.width,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        "คดีเปรียบเทียบที่",
                                        style: textStyleTitleLabel,),
                                    ),
                                    Padding(
                                      padding: paddingData,
                                      child: Text(
                                        'น. ' +
                                            itemMain.COMPARE_NO.toString() +
                                            "/" +
                                            _convertYear(itemMain.COMPARE_NO_YEAR),
                                        style: textStyleTitleData,),
                                    ),
                                  ]
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ) : Container(),
                Container(
                  width: size.width,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _compareArrestMain.CompareArrestIndictmentDetail.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final formatter = new NumberFormat("#,###.00");
                      double fine_value;
                      if(_compareArrestMain.FINE_TYPE==0||
                          _compareArrestMain.FINE_TYPE==1||
                          _compareArrestMain.FINE_TYPE==2){
                        fine_value=0;
                        _compareArrestMain.CompareGuiltbaseFine.forEach((item){
                          if(_compareArrestMain.SUBSECTION_RULE_ID==item.SUBSECTION_RULE_ID){
                            fine_value+=item.FINE_AMOUNT;
                          }
                        });
                      }else{
                        fine_value=1000;
                        /*_compareArrestMain.CompareProveProduct.forEach((item){
                          fine_value+=item.VAT*item.F
                        });*/
                      }

                      bool IsCompare=false;
                      if(itemMain!=null) {
                        itemMain.CompareMapping.forEach((item) {
                          if (item.INDICTMENT_DETAIL_ID == _compareArrestMain
                              .CompareArrestIndictmentDetail[index]
                              .INDICTMENT_DETAIL_ID) {
                            IsCompare = true;
                          }
                        });
                      }

                      //ใบเสร็จ
                      String BillNumber="",BookNo="";
                      itemMain.CompareMapping.forEach((mapp){
                        mapp.CompareDetail.forEach((detail){
                          BillNumber = detail.RECEIPT_NO.toString();
                          BookNo = detail.RECEIPT_BOOK_NO.toString();
                        });
                      });


                      return GestureDetector(
                        onTap: () {
                          IsCompare? _navigate(
                              context,
                              _compareArrestMain.CompareArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH+
                                  _compareArrestMain.CompareArrestIndictmentDetail[index].FIRST_NAME+" "+
                                  _compareArrestMain.CompareArrestIndictmentDetail[index].LAST_NAME,
                              _compareArrestMain.CompareArrestIndictmentDetail[index],
                              false,
                              true,
                            fine_value,
                          ) : null;
                        },
                        child: Container(
                          //padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(18.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      border: Border(
                                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.grey[300],
                                            width: 1.0),
                                      )
                                  ),
                                  child: Stack(children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[

                                        Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "ผู้ต้องหาลำดับที่ " +
                                                (index + 1).toString(),
                                            style: textStyleLabel,),
                                        ),
                                        Padding(
                                          padding: paddingData,
                                          child: Text(
                                            _compareArrestMain.CompareArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH+
                                                _compareArrestMain.CompareArrestIndictmentDetail[index].FIRST_NAME+" "+
                                                _compareArrestMain.CompareArrestIndictmentDetail[index].LAST_NAME,
                                            style: textStyleData,),
                                        ),
                                        Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "ยอดชำระ", style: textStyleLabel,),
                                        ),
                                        Padding(
                                          padding: paddingData,
                                          child: Text(
                                            formatter.format(fine_value).toString(),
                                            style: textStyleData,),
                                        ),
                                      ],
                                    ),
                                    IsCompare
                                        ? Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.0, bottom: 22.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              Icon(Icons.arrow_forward_ios,
                                                size: 18,)
                                            ],
                                          ),
                                        ),
                                        /*itemMain.CompareMapping[0].CompareDetail[0].IsRelease ?
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.0, bottom: 22.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              Padding(
                                                padding: paddingData,
                                                child: Text("ปล่อยตัวชั่วคราว",
                                                  style: textStyleData,),
                                              ),
                                            ],
                                          ),
                                        ) :*/
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 22.0, bottom: 22.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: <Widget>[
                                              Padding(
                                                padding: paddingData,
                                                child: Text("เลขใบเสร็จ : " +BillNumber+"/"+BookNo,
                                                  style: tabStyle,),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                        : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        /*itemMain.Informations.Suspects[index]
                                            .IsActive ?
                                        Icon(Icons.arrow_forward_ios, size: 18,)
                                            :*/ Container(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: new Card(
                                              color: Color(0xff087de1),
                                              shape: new RoundedRectangleBorder(
                                                  side: new BorderSide(
                                                      color: Color(0xff087de1),
                                                      width: 1.5),
                                                  borderRadius: BorderRadius
                                                      .circular(12.0)
                                              ),
                                              elevation: 0.0,
                                              child: Container(
                                                  width: 130.0,
                                                  //height: 40,
                                                  child: Center(
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        _navigate(
                                                            context,
                                                          _compareArrestMain.CompareArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH+
                                                              _compareArrestMain.CompareArrestIndictmentDetail[index].FIRST_NAME+" "+
                                                              _compareArrestMain.CompareArrestIndictmentDetail[index].LAST_NAME,
                                                            _compareArrestMain.CompareArrestIndictmentDetail[index],
                                                          true,
                                                          false,
                                                          fine_value
                                                        );
                                                      },
                                                      splashColor: Color(
                                                          0xff087de1),
                                                      //highlightColor: Colors.blue,
                                                      child: Center(
                                                        child: Text(
                                                          "เปรียบเทียบ",
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
                              ],
                            )
                        ),
                      );
                    },
                  ),
                ),
                itemMain!=null ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          CompareRewardScreenFragment(
                            itemsCompareListIndicmentDetail: _compareArrestMain,
                          )),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 4.0),
                    width: size.width,
                    child: Container(
                        padding: EdgeInsets.all(22.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เงินสินบน-รางวัล",
                                style: textStyleLabel,),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 18.0,)
                          ],
                        )
                    ),
                  ),
                ) : Container()
              ],
            ),
          )
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
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
                  child: new Text(
                    'ILG60_B_04_00_03_00', style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: _buildContent(
                context),
          ),
        ],
      ),
    );
  }
//************************end_tab_1*******************************


  //************************start_tab_2*****************************
  buildCollapsed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.LAWSUIT_NO.toString() + "/" +
                (_compareArrestMain.LAWSUIT_NO_YEAR != null
                    ? _convertYear(_compareArrestMain.LAWSUIT_NO_YEAR)
                    : "-"),
            style: textDataTitleStyle,),
        ),
        Padding(
          padding: paddingData,
          child: Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ARREST_CODE,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _convertDate(_compareArrestMain.OCCURRENCE_DATE) + " " +
                _convertTime(_compareArrestMain.OCCURRENCE_DATE),
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ACCUSER_TITLE_NAME_TH +
                _compareArrestMain.ACCUSER_FIRST_NAME + " " +
                _compareArrestMain.ACCUSER_LAST_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องหา", style: textStyleLabel,),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _compareArrestMain.CompareArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                      padding: paddingData,
                      child: Text((j + 1).toString() + '. ' +
                          _compareArrestMain.CompareArrestIndictmentDetail[j]
                              .TITLE_SHORT_NAME_TH +
                          _compareArrestMain.CompareArrestIndictmentDetail[j]
                              .FIRST_NAME + " " +
                          _compareArrestMain.CompareArrestIndictmentDetail[j]
                              .LAST_NAME,
                        style: textStyleData,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Map map = {
                            "TEXT_SEARCH": "",
                            "PERSON_ID": _compareArrestMain
                                .CompareArrestIndictmentDetail[j].PERSON_ID
                          };
                          _navigatePreviewIndicmentDetail(context, map);
                          /* Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j],)));*/
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.SECTION_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.GUILTBASE_NAME,
            style: textStyleData,),
        ),
      ],
    );
  }

  String _convertDate(String sDate){
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(
        " ");
    result = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();


    return result;
  }
  String _convertTime(String sDate){
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " +
        dateFormatTime.format(dt).toString();
    return result;
  }
  String _convertYear(String sDate){
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(
        " ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }

  buildExpanded() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.LAWSUIT_NO.toString() + "/" +
                (_compareArrestMain.LAWSUIT_NO_YEAR != null
                    ? _convertYear(_compareArrestMain.LAWSUIT_NO_YEAR)
                    : "-"),
            style: textDataTitleStyle,),
        ),
        Padding(
          padding: paddingData,
          child: Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ARREST_CODE,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.OCCURRENCE_DATE != null
                ? _convertDate(_compareArrestMain.OCCURRENCE_DATE) + " " +
                _convertTime(_compareArrestMain.OCCURRENCE_DATE)
                : "null",
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ACCUSER_TITLE_NAME_TH +
                _compareArrestMain.ACCUSER_FIRST_NAME + " " +
                _compareArrestMain.ACCUSER_LAST_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องหา", style: textStyleLabel,),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _compareArrestMain.CompareArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: paddingData,
                    child: Text((j + 1).toString() + '. ' +
                        _compareArrestMain.CompareArrestIndictmentDetail[j]
                            .TITLE_SHORT_NAME_TH +
                        _compareArrestMain.CompareArrestIndictmentDetail[j]
                            .FIRST_NAME + " " +
                        _compareArrestMain.CompareArrestIndictmentDetail[j]
                            .LAST_NAME,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Map map = {
                            "TEXT_SEARCH": "",
                            "PERSON_ID": _compareArrestMain
                                .CompareArrestIndictmentDetail[j].PERSON_ID
                          };
                          _navigatePreviewIndicmentDetail(context, map);
                          /*Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j])));*/
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิดมาตรา", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.SUBSECTION_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.GUILTBASE_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่รับคดี", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.LAWSUIT_DATE!=null
                ?_convertDate(_compareArrestMain.LAWSUIT_DATE) + " " +
                _convertTime(_compareArrestMain.LAWSUIT_DATE)
                :"null",
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่พิสูจน์ของกลาง", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            /*_convertDate(_compareArrestMain.RECEIVE_DOC_DATE)*/
            _compareArrestMain.RECEIVE_DOC_DATE != null
                ? _convertDate(_compareArrestMain.RECEIVE_DOC_DATE) + " " +
                _convertTime(_compareArrestMain.LAWSUIT_DATE)
                : "null",
            style: textStyleData,),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text("ของกลาง", style: textStyleLabel,),
            ),
            _compareArrestMain
                .CompareProveProduct.length == 0
                ? Container(
              padding: paddingData,
              child: Text(
                "ไม่มีของกลาง", style: textStyleData,
              ),
            )
                : Container(
              padding: paddingLabel,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // new
                  itemCount: _compareArrestMain
                      .CompareProveProduct.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TabScreenArrest6Product(
                                        ItemsProduct: _compareArrestMain
                                            .CompareProveProduct[index],
                                        IsComplete: true,
                                      )),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: paddingData,
                                  child: Text(
                                    (index + 1).toString() + ". " +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_GROUP_NAME != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_GROUP_NAME
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_CATEGORY_NAME != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_CATEGORY_NAME
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_TYPE_NAME != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_TYPE_NAME
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_BRAND_NAME_TH != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_BRAND_NAME_TH
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_BRAND_NAME_EN != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_BRAND_NAME_EN
                                            .toString() + ' ')
                                            : '') +

                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_SUBBRAND_NAME_TH != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_SUBBRAND_NAME_TH
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_SUBBRAND_NAME_EN != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_SUBBRAND_NAME_EN
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_MODEL_NAME_TH != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_MODEL_NAME_TH
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_MODEL_NAME_EN != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .PRODUCT_MODEL_NAME_EN
                                            .toString() + ' ')
                                            : '') +
                                        (_compareArrestMain
                                            .CompareProveProduct[index]
                                            .DEGREE != null
                                            ? (_compareArrestMain
                                            .CompareProveProduct[index].DEGREE
                                            .toString() +
                                            ' ดีกรี ')
                                            : ' ') +
                                        _compareArrestMain
                                            .CompareProveProduct[index].SIZES
                                            .toString() + ' ' +
                                        _compareArrestMain
                                            .CompareProveProduct[index]
                                            .SIZES_UNIT.toString(),
                                    style: textStyleData,),
                                ),
                              ),
                              Icon(Icons.navigate_next),
                            ],
                          ),
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ],
                    );
                  }
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool Success=false;
  ItemsListArrestPerson ItemsPreviewIndicmentDetail=null;
  //on show dialog
  Future<bool> onLoadActionIndicmentDetail(BuildContext context,Map map) async {
    await new ArrestFuture().apiRequestMasPersongetByCon(map).then((onValue) {
      Success = onValue.SUCCESS;
      onValue.RESPONSE_DATA.forEach((item){
        ItemsPreviewIndicmentDetail=item;
      });
    });
    setState(() {});
    return true;
  }
  _navigatePreviewIndicmentDetail(BuildContext context,Map map) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionIndicmentDetail(context,map);
    Navigator.pop(context);

    if(Success){
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabScreenArrest4Suspect2(ItemsSuspect: ItemsPreviewIndicmentDetail,)),
      );
      print(result);
      /*_itemsData=result;
      Navigator.pop(context,_itemsData);*/
    }
  }


  Widget _buildContent_tab_2() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return Container(
        padding: EdgeInsets.only(
            left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
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
      );
    }
    //data result when search data
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
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
                      child: new Text(
                        'ILG60_B_04_00_04_00', style: textStylePageName,),
                    )
                  ],
                ),*/
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _buildContent(context),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }


//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      TextStyle textInputStyleTitle = TextStyle(
          fontSize: 16.0, color: Colors.black);
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: ListTile(
                      leading: Padding(padding: paddingLabel,
                        child: Text((index + 1).toString() + '. ',
                          style: textInputStyleTitle,),),
                      title: Padding(padding: paddingLabel,
                        child: Text(itemsFormsTab[index].FormsName,
                          style: textInputStyleTitle,),),
                      subtitle: Padding(padding: paddingData,
                        child: Text(itemsFormsTab[index].SuspectName,
                          style: textInputStyleTitle,),),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[300],size: 18.0,),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TabScreenArrest8Dowload(
                                  Title: itemsFormsTab[index].FormsName,),
                            ));
                      }
                  ),
                ),
              );
            }
        ),
      );
    }
    //data result when search data
    return  Scaffold(
      backgroundColor: Colors.grey[200],
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
                    child: new Text(
                      'ILG60_B_04_00_08_00', style: textStylePageName,),
                  )
                ],
              ),*/
            ),
            Expanded(
              child: new ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//************************end_tab_3*******************************
}
