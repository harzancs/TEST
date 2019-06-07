import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart' as prefix2;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/lawsuit_not_accept_screen_suspect.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/tab_screen_lawsuit_product.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/tab_screen_lawsuit_staff_search.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/tab_screen_lawsuit_suspect.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/future/return_future.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_main.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/future/arrest_future.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_person.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/return/return_body/return_screen.dart';
import 'package:prototype_app_pang/main_menu/tab_menu/return_tab.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';

const double _kPickerSheetHeight = 216.0;

class ReturnNotAcceptCaseMainScreenFragment extends StatefulWidget {
  ItemsReturnArrestMain itemsReturnMain;
  ItemsPersonInformation ItemsPerson;
  ItemsReturnMain itemsPreview;
  bool IsPreview;
  ReturnNotAcceptCaseMainScreenFragment({
    Key key,
    @required this.itemsReturnMain,
    @required this.ItemsPerson,
    @required this.IsPreview,
    @required this.itemsPreview,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ReturnNotAcceptCaseMainScreenFragment>
    with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = true;
  bool _onSave = true;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลคืนของกลาง'),
    Choice(title: 'ของกลาง'),
    Choice(title: 'แบบฟอร์ม'),
  ];

  ItemsReturnArrestMain _itemsLawsuitArrestMain;
  ItemsReturnMain _itemsReturnMain;
  var _itemsStaff;
  var _itemStaffUpdate;

  List<ItemsLawsuitForms> itemsFormsTab3 = [];

  TextStyle tabStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.black54,
      fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  TextStyle TitleStyle =
      TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0,
      color: Colors.red,
      fontWeight: FontWeight.w500,
      fontFamily: FontStyles().FontFamily);

  TextStyle textStyleLabel = TextStyle(
      fontSize: 16,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(
      fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily,
      fontSize: 12.0);
  TextStyle textStyleLink =
      TextStyle(color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  var dateFormatDate, dateFormatTime;

  final FocusNode myFocusNodeLawsuitPersonName = FocusNode();
  TextEditingController editLawsuitPersonName = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _itemsLawsuitArrestMain = widget.itemsReturnMain;

    String title = widget.ItemsPerson.TITLE_SHORT_NAME_TH != null
        ? widget.ItemsPerson.TITLE_SHORT_NAME_TH
        : "";
    String firstname = widget.ItemsPerson.FIRST_NAME != null
        ? widget.ItemsPerson.FIRST_NAME
        : "";
    String lastname = widget.ItemsPerson.LAST_NAME != null
        ? widget.ItemsPerson.LAST_NAME
        : "";
    editLawsuitPersonName.text = title + firstname + " " + lastname;
    _itemsStaff = widget.ItemsPerson;

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = false;
      _itemsLawsuitArrestMain = widget.itemsReturnMain;
      _itemsReturnMain = widget.itemsPreview;
    }
  }

  //*****************************view tab1**************************/
  //node focus
  final FocusNode myFocusNodeReason = FocusNode();

  //textfield
  TextEditingController editReason = new TextEditingController();

  //**********************Droupdown View *****************************/
  List<String> dropdownItemsTab3 = ['ผู้จับกุม', 'ผู้ร่วมจับกุม'];

  @override
  void dispose() {
    super.dispose();
    editLawsuitPersonName.dispose();
    //*****************************dispose focus tab 1**************************/
  }

  void _setTextField() {
    editReason.text = _itemsReturnMain.REMARK_NOT_LAWSUIT;
    CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ต้องการแก้ไขข้อมูล",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context, "Back");
                setState(() {
                  onDeleted();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onEdited = false;
        moveScreenEdit();
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }

  void moveScreenEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ReturnMainScreenFragment(
                ItemsexportMain: null,
                IsPreview: false,
                IsCreate: true,
                IsUpdate: false,
              )),
    );
  }

  CupertinoAlertDialog _createCupertinoCancelEditDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ต้องการแก้ไขข้อมูล",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context, "Back");

                setState(() {
                  onDeleted();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ยืนยันการลบข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context, "Back");
                setState(() {
                  onDeleted();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void onDeleted() async {
    Map map = {"LAWSUIT_ID": _itemsReturnMain.LAWSUIT_ID};
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    //
    await onLoadActionInsLawsuitDelete(map);
    Navigator.pop(context);
  }

  Future<bool> onLoadActionInsLawsuitDelete(Map map) async {
    Map map_indic = {
      "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
    };
    await new ReturnFuture()
        .apiRequestLawsuiltArrestIndictmentupdDeleteIndictmentComplete(
            map_indic)
        .then((onValue) {
      print("Delete IndictmentComplete : " + onValue.Msg);
    });
    Map map_arrest = {
      "ARREST_ID": _itemsLawsuitArrestMain.ARREST_ID,
    };
    await new ReturnFuture()
        .apiRequestLawsuiltArrestIndictmentupdDeleteArrestComplete(map_arrest)
        .then((onValue) {
      print("Delete ArrestComplete : " + onValue.Msg);
    });
    await new ReturnFuture().apiRequestLawsuitupdDelete(map).then((onValue) {
      print(onValue.IsSuccess);
      setState(() {
        _onSaved = false;
        _onEdited = false;
        _onSave = false;
        clearTextfield();
        choices.removeAt(choices.length - 1);

        Navigator.pop(context, _itemsReturnMain);
      });
    });
    setState(() {});
    return true;
  }

  void _showEditAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelEditDialog();
      },
    );
  }

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }
/*
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext){
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

                if(!_onEdited) {
                  Navigator.pop(mContext, "Back");
                }else{
                  setState(() {
                    _onSaved=true;
                    _onEdited=false;
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }*/

  void clearTextfield() {
    editReason.clear();
  }

  CupertinoAlertDialog _cupertinoSearchEmpty(mContext, text) {
    TextStyle TitleStyle =
        TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            text,
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showSearchEmptyAlertDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context, text);
      },
    );
  }

  void onSaved(BuildContext mContext) async {
    if (editReason.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณาเพิ่มข้อมูลส่วนข้อกล่าวหา');
    } else {
      if (!_onEdited) {
        List<Map> LawsuitDetail = [];
        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.forEach((item) {
          LawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": "",
            "LAWSUIT_ID": "",
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "COURT_ID": "",
            "LAWSUIT_TYPE": 1,
            "LAWSUIT_END": 1,
            "COURT_NAME": "",
            "UNDECIDE_NO_1": "",
            "UNDECIDE_NO_YEAR_1": "",
            "DECIDE_NO_1": "",
            "DECIDE_NO_YEAR_1": "",
            "UNDECIDE_NO_2": "",
            "UNDECIDE_NO_YEAR_2": "",
            "DECIDE_NO_2": "",
            "DECIDE_NO_YEAR_2": "",
            "JUDGEMENT_NO": "",
            "JUDGEMENT_NO_YEAR": "",
            "JUDGEMENT_DATE": "",
            "IS_IMPRISON": "",
            "IMPRISON_TIME": "",
            "IMPRISON_TIME_UNIT": "",
            "IS_FINE": "",
            "FINE": "",
            "IS_PAYONCE": "",
            "FINE_DATE": "",
            "PAYMENT_PERIOD": "",
            "PAYMENT_PERIOD_DUE": "",
            "PAYMENT_PERIOD_DUE_UNIT": "",
            "IS_ACTIVE": 1
          });
        });

        Map map = {
          "LAWSUIT_ID": "",
          "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
          "OFFICE_ID": "1",
          "OFFICE_CODE": "100300",
          "OFFICE_NAME": "สำนักงานสรรพสเทพฯ 3",
          "IS_LAWSUIT": 0,
          "REMARK_NOT_LAWSUIT": editReason.text,
          "LAWSUIT_NO": "",
          "LAWSUIT_NO_YEAR": "",
          "LAWSUIT_DATE": "",
          "TESTIMONY": "",
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "IS_OUTSIDE": 1,
          "IS_SEIZE": 1,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 5,
          "UPDATE _DATE": DateTime.now().toString(),
          "UPDATE _USER_ACCOUNT_ID": 5,
          "LawsuitStaff": [
            {
              "STAFF_ID": "",
              "LAWSUIT_ID": "",
              "STAFF_REF_ID": 1,
              "TITLE_ID": "1",
              "STAFF_CODE": "4842",
              "ID_CARD": "127896325",
              "STAFF_TYPE": 1,
              "TITLE_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
              "TITLE_NAME_EN": "",
              "TITLE_SHORT_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": "",
              "FIRST_NAME": _itemsStaff.FIRST_NAME,
              "LAST_NAME": _itemsStaff.LAST_NAME,
              "AGE": "27",
              "OPERATION_POS_CODE": "",
              "OPREATION_POS_NAME": _itemsStaff.OPREATION_POS_NAME,
              "OPREATION_POS_LEVEL": "",
              "OPERATION_POS_LEVEL_NAME": _itemsStaff.OPREATION_POS_LAVEL_NAME,
              "OPERATION_DEPT_CODE": "",
              "OPERATION_DEPT_NAME": "",
              "OPERATION_DEPT_LEVEL": "",
              "OPERATION_UNDER_DEPT_CODE": "",
              "OPERATION_UNDER_DEPT_NAME": "",
              "OPERATION_UNDER_DEPT_LEVEL": "",
              "OPERATION_OFFICE_CODE": "000000",
              "OPERATION_OFFICE_NAME": "",
              "OPERATION_OFFICE_SHORT_NAME": "",
              "MANAGEMENT_WORK_DEPT_CODE": "",
              "MANAGEMENT_WORK_DEPT_NAME": "",
              "MANAGEMENT_WORK_DEPT_LEVEL": "",
              "MANAGEMENT_OFFICE_CODE": "",
              "MANAGEMENT_OFFICE_NAME": _itemsStaff.OPERATION_OFFICE_NAME,
              "MANAGEMENT_OFFICE_SHORT_NAME": "",
              "REPRESENT_POS_CODE": "",
              "REPRESENT_POS_NAME": "",
              "REPRESENT_POS_LEVEL": "",
              "REPRESENT_POS_LEVEL_NAME": "",
              "REPRESENT_DEPT_CODE": "",
              "REPRESENT_DEPT_NAME": "",
              "REPRESENT_DEPT_LEVEL": "",
              "REPRESENT_UNDER_DEPT_CODE": "",
              "REPRESENT_UNDER_DEPT_NAME": "",
              "REPRESENT_UNDER_DEPT_LEVEL": "",
              "REPRESENT_WORK_DEPT_CODE": "",
              "REPRESENT_WORK_DEPT_NAME": "",
              "REPRESENT_WORK_DEPT_LEVEL": "",
              "REPRESENT_OFFICE_CODE": "",
              "REPRESENT_OFFICE_NAME": "",
              "REPRESENT_OFFICE_SHORT_NAME": "",
              "STATUS": 1,
              "REMARK": "",
              "CONTRIBUTOR_ID": 16,
              "IS_ACTIVE": 1
            }
          ],
          "LawsuitDetail": LawsuitDetail
        };

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionInsLawsuitAll(map);
        Navigator.pop(context);
      } else {
        List<Map> LawsuitDetail = [];
        _itemsReturnMain.LawsuitDetail.forEach((item) {
          LawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": item.LAWSUIT_DETAIL_ID,
            "LAWSUIT_ID": item.LAWSUIT_ID,
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "COURT_ID": "",
            "LAWSUIT_TYPE": 1,
            "LAWSUIT_END": 1,
            "COURT_NAME": "",
            "UNDECIDE_NO_1": "",
            "UNDECIDE_NO_YEAR_1": "",
            "DECIDE_NO_1": "",
            "DECIDE_NO_YEAR_1": "",
            "UNDECIDE_NO_2": "",
            "UNDECIDE_NO_YEAR_2": "",
            "DECIDE_NO_2": "",
            "DECIDE_NO_YEAR_2": "",
            "JUDGEMENT_NO": "",
            "JUDGEMENT_NO_YEAR": "",
            "JUDGEMENT_DATE": "",
            "IS_IMPRISON": "",
            "IMPRISON_TIME": "",
            "IMPRISON_TIME_UNIT": "",
            "IS_FINE": "",
            "FINE": "",
            "IS_PAYONCE": "",
            "FINE_DATE": "",
            "PAYMENT_PERIOD": "",
            "PAYMENT_PERIOD_DUE": "",
            "PAYMENT_PERIOD_DUE_UNIT": "",
            "IS_ACTIVE": 1
          });
        });

        Map map = {
          "LAWSUIT_ID": _itemsReturnMain.LAWSUIT_ID,
          "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
          "OFFICE_ID": _itemsReturnMain.OFFICE_ID,
          "OFFICE_CODE": _itemsReturnMain.OFFICE_CODE,
          "OFFICE_NAME": _itemsReturnMain.OFFICE_NAME,
          "IS_LAWSUIT": _itemsReturnMain.IS_LAWSUIT,
          "REMARK_NOT_LAWSUIT": editReason.text,
          "LAWSUIT_NO": "",
          "LAWSUIT_NO_YEAR": "",
          "LAWSUIT_DATE": "",
          "TESTIMONY": "",
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "IS_OUTSIDE": 1,
          "IS_SEIZE": 1,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 5,
          "UPDATE _DATE": DateTime.now().toString(),
          "UPDATE _USER_ACCOUNT_ID": 5,
          "LawsuitDetail": LawsuitDetail
        };
        List<Map> map_staff = [];
        if (_itemStaffUpdate != null) {
          map_staff.add({
            "STAFF_ID": _itemsReturnMain.LawsuitStaff[0].STAFF_ID,
            "LAWSUIT_ID": _itemsReturnMain.LAWSUIT_ID,
            "STAFF_REF_ID": 1,
            "TITLE_ID": "1",
            "STAFF_CODE": _itemStaffUpdate.STAFF_CODE,
            "ID_CARD": "127896325",
            "STAFF_TYPE": 1,
            "TITLE_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME": _itemStaffUpdate.FIRST_NAME,
            "LAST_NAME": _itemStaffUpdate.LAST_NAME,
            "AGE": "27",
            "OPERATION_POS_CODE": "",
            "OPREATION_POS_NAME": _itemStaffUpdate.OPREATION_POS_NAME,
            "OPREATION_POS_LEVEL": "",
            "OPERATION_POS_LEVEL_NAME":
                _itemStaffUpdate.OPREATION_POS_LAVEL_NAME,
            "OPERATION_DEPT_CODE": "",
            "OPERATION_DEPT_NAME": "",
            "OPERATION_DEPT_LEVEL": "",
            "OPERATION_UNDER_DEPT_CODE": "",
            "OPERATION_UNDER_DEPT_NAME": "",
            "OPERATION_UNDER_DEPT_LEVEL": "",
            "OPERATION_OFFICE_CODE": "000000",
            "OPERATION_OFFICE_NAME": "",
            "OPERATION_OFFICE_SHORT_NAME": "",
            "MANAGEMENT_WORK_DEPT_CODE": "",
            "MANAGEMENT_WORK_DEPT_NAME": "",
            "MANAGEMENT_WORK_DEPT_LEVEL": "",
            "MANAGEMENT_OFFICE_CODE": "",
            "MANAGEMENT_OFFICE_NAME": "",
            "MANAGEMENT_OFFICE_SHORT_NAME": "",
            "REPRESENT_POS_CODE": "",
            "REPRESENT_POS_NAME": "",
            "REPRESENT_POS_LEVEL": "",
            "REPRESENT_POS_LEVEL_NAME": "",
            "REPRESENT_DEPT_CODE": "",
            "REPRESENT_DEPT_NAME": "",
            "REPRESENT_DEPT_LEVEL": "",
            "REPRESENT_UNDER_DEPT_CODE": "",
            "REPRESENT_UNDER_DEPT_NAME": "",
            "REPRESENT_UNDER_DEPT_LEVEL": "",
            "REPRESENT_WORK_DEPT_CODE": "",
            "REPRESENT_WORK_DEPT_NAME": "",
            "REPRESENT_WORK_DEPT_LEVEL": "",
            "REPRESENT_OFFICE_CODE": "",
            "REPRESENT_OFFICE_NAME": "",
            "REPRESENT_OFFICE_SHORT_NAME": "",
            "STATUS": 1,
            "REMARK": "",
            "CONTRIBUTOR_ID": 16,
            "IS_ACTIVE": 1
          });
        }

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionInsLawsuitUpAll(map, map_staff.isEmpty, map_staff);
        Navigator.pop(context);
      }
    }
  }

  Future<bool> onLoadActionInsLawsuitUpAll(
      Map map, bool IsStaffUpdate, List<Map> map_staff) async {
    await new ReturnFuture().apiRequestLawsuitupdAll(map).then((onValue) {
      print("UPDATE : " + onValue.IsSuccess.toString());
    });
    if (!IsStaffUpdate) {
      await new ReturnFuture()
          .apiRequestLawsuitStaffupdAll(map_staff)
          .then((onValue) {
        print("UPDATE STAFF : " + onValue.Msg);
      });
    }
    if (_itemsReturnMain.LAWSUIT_ID != null) {
      Map map = {"LAWSUIT_ID": _itemsReturnMain.LAWSUIT_ID};
      await new ReturnFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
        _itemsReturnMain = onValue;
      });

      _onSaved = false;
      _onFinish = true;
      //add item tab 3
      itemsFormsTab3 = [];
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ"));
      itemsFormsTab3.add(new ItemsLawsuitForms("ทะเบียนประวัติผู้กระทำผิด"));
      itemsFormsTab3
          .add(new ItemsLawsuitForms("รายละเอียดการกระทำผิดผู้กระทำผิด"));
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);
      _tabPageSelector = new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length - 1);
    }

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionInsLawsuitAll(Map map) async {
    int LAWSUIT_ID;
    await new ReturnFuture().apiRequestLawsuitinsAll(map).then((onValue) {
      print(onValue.IsSuccess);
      LAWSUIT_ID = onValue.LAWSUIT_ID;
    });
    Map map_indic = {
      "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
    };
    await new ReturnFuture()
        .apiRequestLawsuiltArrestIndictmentupdIndictmentComplete(map_indic)
        .then((onValue) {
      print("Update IndictmentComplete : " + onValue.Msg);
    });
    Map map_arrest = {
      "ARREST_ID": _itemsLawsuitArrestMain.ARREST_ID,
    };
    await new ReturnFuture()
        .apiRequestLawsuiltArrestIndictmentupdArrestComplete(map_arrest)
        .then((onValue) {
      print("Update ArrestComplete : " + onValue.Msg);
    });
    if (LAWSUIT_ID != null) {
      Map map = {"LAWSUIT_ID": LAWSUIT_ID};
      await new ReturnFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
        _itemsReturnMain = onValue;
      });

      _onSaved = false;
      _onFinish = false;
      //add item tab 3
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ"));
      itemsFormsTab3.add(new ItemsLawsuitForms("ทะเบียนประวัติผู้กระทำผิด"));
      itemsFormsTab3
          .add(new ItemsLawsuitForms("รายละเอียดการกระทำผิดผู้กระทำผิด"));
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length + 1, vsync: this);
      _tabPageSelector = new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length - 1);
    }

    setState(() {});
    return true;
  }

  /*****************************method for main tab1**************************/
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<Widget> rowContents = <Widget>[
      new SizedBox(
          width: width / 3,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
                Navigator.pop(context, "Back");
                // _onSaved ? Navigator.pop(context,"Back") :
                //  _showCancelAlertDialog(context);
              },
              padding: EdgeInsets.all(10.0),
              child: new Row(
                children: <Widget>[
                  new Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  !_onSaved
                      ? new Text(
                          "",
                          style: appBarStyle,
                        )
                      : new Container(),
                ],
              ),
            ),
          )),
      Expanded(
          child: Center(
        child: Text("งานคืนของกลาง", style: appBarStyle),
      )),
      new SizedBox(
          width: width / 3,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _onSaved
                  ? (_onSave
                      ? new FlatButton(
                          onPressed: () {
                            setState(() {
                              _onSaved = true;
                              _onSave = false;
                              _onEdited = false;
                            });
                            //TabScreenArrest1().createAcceptAlert(context);
                          },
                          child: Text('บันทึก', style: appBarStyle))
                      : Container())
                  : new PopupMenuButton<Constants>(
                      onSelected: choiceAction,
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      itemBuilder: (BuildContext context) {
                        return constants.map((Constants contants) {
                          return PopupMenuItem<Constants>(
                            value: contants,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    contants.icon,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(contants.text,
                                      style: TextStyle(
                                          fontFamily: FontStyles().FontFamily)),
                                )
                              ],
                            ),
                          );
                        }).toList();
                      },
                    )
            ],
          ))
    ];
    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_onSaved) {
            if (_onEdited) {
              _onEdited = false;
              _onSaved = false;
            } else {
              //Navigator.pop(context,widget.itemsCaseInformation);
            }
          } else {
            //Navigator.pop(context,widget.itemsCaseInformation);
          }
        });
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              primary: true,
              pinned: false,
              flexibleSpace: new BottomAppBar(
                elevation: 0.0,
                color: Color(0xff2e76bc),
                child: new Row(children: rowContents),
              ),
              automaticallyImplyLeading: false,
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
                    isScrollable: choices.length != 3 ? true : false,
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
                  children: _onFinish
                      ? <Widget>[
                          _buildContent_tab_1(),
                          _buildContent_tab_2(),
                          _buildContent_tab_33(),
                          _buildContent_tab_3(),
                        ]
                      : <Widget>[
                          _buildContent_tab_1(),
                          _buildContent_tab_2(),
                          _buildContent_tab_33(),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateSearchStaff(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenLawsuitStaffSearch()),
    );
    if (result.toString() != "Back") {
      var itemStaff = result;
      _itemsStaff = itemStaff;
      _itemStaffUpdate = itemStaff;
      String title = itemStaff.TITLE_SHORT_NAME_TH != null
          ? itemStaff.TITLE_SHORT_NAME_TH
          : itemStaff.TITLE_NAME_TH;
      String firstname =
          itemStaff.FIRST_NAME != null ? itemStaff.FIRST_NAME : "";
      String lastname = itemStaff.LAST_NAME != null ? itemStaff.LAST_NAME : "";
      editLawsuitPersonName.text = title + firstname + " " + lastname;
    }
  }

  //************************start_tab_1*****************************
  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      String title = "", firstname = "", lastname = "";
      if (_onEdited) {
        _itemsReturnMain.LawsuitStaff.forEach((staff) {
          title = staff.TITLE_SHORT_NAME_TH != null
              ? staff.TITLE_SHORT_NAME_TH
              : staff.TITLE_NAME_TH;
          firstname = staff.FIRST_NAME != null ? staff.FIRST_NAME : "";
          lastname = staff.LAST_NAME != null ? staff.LAST_NAME : "";
        });
      } else {
        title = widget.ItemsPerson.TITLE_SHORT_NAME_TH != null
            ? widget.ItemsPerson.TITLE_SHORT_NAME_TH
            : "";
        firstname = widget.ItemsPerson.FIRST_NAME != null
            ? widget.ItemsPerson.FIRST_NAME
            : "";
        lastname = widget.ItemsPerson.LAST_NAME != null
            ? widget.ItemsPerson.LAST_NAME
            : "";
      }
      return Container(
        padding:
            EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ประเภทงานคืนของกลาง",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    'คืนของกลางภายนอก',
                    style: textStyleData,
                  ),
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
                  child: Text(
                    "เลขที่หนังสือขอคืน",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    'กค 0809.1/2561',
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "หนังสือลงวันที่",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    '09 กันยายน 2561   เวลา 13.00 น.',
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ผู้ขอรับคืน",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    'จ่าสิบเอกธนันชัย บุญโต',
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ตำแหน่ง",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    'รองสารวัตร',
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "หน่วยงาน",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    'สน.หัวหมาก',
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "คลังจัดเก็บ",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    'คลัง 5',
                    style: textStyleData,
                  ),
                ),
                /*Container(
                padding: paddingData,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      //padding: paddingData,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          //_navigateSearchStaff(context);
                        },
                        focusNode: myFocusNodeLawsuitPersonName,
                        controller: editLawsuitPersonName,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          //suffixIcon: Icon(Icons.search,color: Colors.grey,),
                        ),
                      ),
                    ),
                  ],
                ),
              ), */
                /* Container(
                padding: paddingLabel,
                child: Text("เหตุผล", style: textStyleLabel,),
              ),
              Padding(
                  padding: paddingData,
                  child: Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TextField(
                      maxLines: 10,
                      focusNode: myFocusNodeReason,
                      controller: editReason,
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[500], width: 0.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[400], width: 0.5),
                        ),
                      ),
                    ),
                  )
              ), */
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String title = "";
      String firstname = "";
      String lastname = "";

      _itemsReturnMain.LawsuitStaff.forEach((item) {
        title = item.TITLE_SHORT_NAME_TH != null
            ? item.TITLE_SHORT_NAME_TH
            : item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      return Container(
        padding:
            EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      _itemsReturnMain.IS_LAWSUIT == 0 ? "ไม่รับคดี" : "",
                      style: textStyleData,
                    ),
                  ),
                ],
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
                child: Text(
                  "ชื่อเจ้าพนักงาน",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  title + firstname + " " + lastname,
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "เหตุผล",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  _itemsReturnMain.REMARK_NOT_LAWSUIT,
                  style: textStyleData,
                ),
              ),
            ],
          ),
          _itemsReturnMain.IS_OUTSIDE == 1
              ? Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<Constants>(
                    onSelected: choiceAction,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) {
                      return constants.map((Constants contants) {
                        return PopupMenuItem<Constants>(
                          value: contants,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(
                                  contants.icon,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text(contants.text,
                                    style: TextStyle(
                                        fontFamily: FontStyles().FontFamily)),
                              )
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                )
              : Container()
        ]),
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
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_02_00_05_00', style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved
                    ? _buildContent_saved(context)
                    : _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************
  var itemsFormsTab = ['บัญชีรายการคืนของกลาง'];
  //************************start_tab_33*****************************
  Widget _buildContent_tab_33() {
    Widget _buildContent(BuildContext context) {
      String title = "", firstname = "", lastname = "";
      if (_onEdited) {
        _itemsReturnMain.LawsuitStaff.forEach((staff) {
          title = staff.TITLE_SHORT_NAME_TH != null
              ? staff.TITLE_SHORT_NAME_TH
              : staff.TITLE_NAME_TH;
          firstname = staff.FIRST_NAME != null ? staff.FIRST_NAME : "";
          lastname = staff.LAST_NAME != null ? staff.LAST_NAME : "";
        });
      } else {
        title = widget.ItemsPerson.TITLE_SHORT_NAME_TH != null
            ? widget.ItemsPerson.TITLE_SHORT_NAME_TH
            : "";
        firstname = widget.ItemsPerson.FIRST_NAME != null
            ? widget.ItemsPerson.FIRST_NAME
            : "";
        lastname = widget.ItemsPerson.LAST_NAME != null
            ? widget.ItemsPerson.LAST_NAME
            : "";
      }
      return Container(
        padding:
            EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Stack(
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: prefix0.EdgeInsets.all(8.0),
                  ),
                  FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TabScreenArrest8Dowload(
                                  Title: itemsFormsTab[0],
                                ),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '1.',
                          style: TextStyle(
                              fontFamily: FontStyles().FontFamily,
                              fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'บัญชีรายการคืนของกลาง',
                          style: TextStyle(
                              fontFamily: FontStyles().FontFamily,
                              fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  )
                ])
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String title = "";
      String firstname = "";
      String lastname = "";

      _itemsReturnMain.LawsuitStaff.forEach((item) {
        title = item.TITLE_SHORT_NAME_TH != null
            ? item.TITLE_SHORT_NAME_TH
            : item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      return Container(
        padding:
            EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      _itemsReturnMain.IS_LAWSUIT == 0 ? "ไม่รับคดี" : "",
                      style: textStyleData,
                    ),
                  ),
                ],
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
                child: Text(
                  "ชื่อเจ้าพนักงาน",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  title + firstname + " " + lastname,
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "เหตุผล",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  _itemsReturnMain.REMARK_NOT_LAWSUIT,
                  style: textStyleData,
                ),
              ),
            ],
          ),
          _itemsReturnMain.IS_OUTSIDE == 1
              ? Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<Constants>(
                    onSelected: choiceAction,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) {
                      return constants.map((Constants contants) {
                        return PopupMenuItem<Constants>(
                          value: contants,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(
                                  contants.icon,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text(contants.text,
                                    style: TextStyle(
                                        fontFamily: FontStyles().FontFamily)),
                              )
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                )
              : Container()
        ]),
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
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_02_00_05_00', style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved
                    ? _buildContent_saved(context)
                    : _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_33*******************************

  List groupD = ['IN00107016200008', 'IN00107016200009'];
  List groupE = ['สุราแช่/ชนิดเบียร์/Leo', 'สุราแช่/ชนิดเบียร์/สิงห์'];
//************************start_tab_2******************************
  buildCollapsed() {
    String arrest_date = "";
    DateTime dt_occourrence =
        DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    print(dt_occourrence.toString());
    List splits = dateFormatDate.format(dt_occourrence).toString().split(" ");
    arrest_date = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();
    return Container(
        child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: groupD.length,
      itemBuilder: (BuildContext context, index) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "เลขทะเบียนบัญชี",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  '${groupD[index]}',
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ชื่อของกลาง",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  '${groupE[index]}',
                  style: textStyleData,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  buildExpanded() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 80) / 100;

    String arrest_date = "";
    DateTime dt_occourrence =
        DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    print(dt_occourrence.toString());
    List splits = dateFormatDate.format(dt_occourrence).toString().split(" ");
    arrest_date = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขที่ใบงาน",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_CODE,
            style: textStyleData,
          ),
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
          child: Text(
            "วันที่จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            arrest_date,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ผู้จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH +
                _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME +
                " " +
                _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ผู้ต้องหา",
            style: textStyleLabel,
          ),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount:
                _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: paddingData,
                    child: Text(
                      (j + 1).toString() +
                          '. ' +
                          _itemsLawsuitArrestMain
                              .LawsuitArrestIndictmentDetail[j]
                              .TITLE_SHORT_NAME_TH +
                          _itemsLawsuitArrestMain
                              .LawsuitArrestIndictmentDetail[j].FIRST_NAME +
                          " " +
                          _itemsLawsuitArrestMain
                              .LawsuitArrestIndictmentDetail[j].LAST_NAME,
                      style: textStyleData,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text(
                          "ดูประวัติผู้ต้องหา",
                          style: textStyleLink,
                        ),
                        onPressed: () {
                          Map map = {
                            "TEXT_SEARCH": "",
                            "PERSON_ID": _itemsLawsuitArrestMain
                                .LawsuitArrestIndictmentDetail[j].PERSON_ID
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
          child: Text(
            "ฐานความผิดมาตรา",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.SUBSECTION_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ฐานความผิด",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.GUILTBASE_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "สถานที่จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_OFFICE_NAME,
            style: textStyleData,
          ),
        ),
        /*Padding(
          padding: paddingData,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ของกลางลำดับ "+(j+1).toString(), style: textStyleLabel,),
                  ),
                  new Padding(
                    padding: paddingData,
                    child: Text(
                      _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME+" / "+
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH
                      ,
                      style: textStyleData,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวน", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].QUANTITY.toString(),
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].QUANTITY_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ขนาด", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].SIZES.toString(),
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].SIZES_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ปริมาณสุทธิ", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].VOLUMN.toString(),
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].VOLUMN_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  j<_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length-1?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          width: Width,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ):Container()
                ],
              );
            },
          ),
        ),*/
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                "ของกลาง",
                style: textStyleLabel,
              ),
            ),
            _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length == 0
                ? Container(
                    padding: paddingData,
                    child: Text(
                      "ไม่มีของกลาง",
                      style: textStyleData,
                    ),
                  )
                : Container(
                    padding: paddingLabel,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // new
                        itemCount: _itemsLawsuitArrestMain
                            .LawsuitArrestIndictmentProduct.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TabScreenLawsuitProduct(
                                              ItemsProduct: _itemsLawsuitArrestMain
                                                      .LawsuitArrestIndictmentProduct[
                                                  index],
                                              IsComplete: true,
                                              Title: _itemsLawsuitArrestMain
                                                  .LawsuitArrestIndictmentProduct[
                                                      index]
                                                  .PRODUCT_BRAND_NAME_TH,
                                            )),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: paddingData,
                                        child: Text(
                                          (index + 1).toString() +
                                              ". " +
                                              _itemsLawsuitArrestMain
                                                  .LawsuitArrestIndictmentProduct[
                                                      index]
                                                  .PRODUCT_CATEGORY_NAME +
                                              '/' +
                                              _itemsLawsuitArrestMain
                                                  .LawsuitArrestIndictmentProduct[
                                                      index]
                                                  .PRODUCT_TYPE_NAME +
                                              '/' +
                                              //_arrestMain.ArrestIndictment[index].ArrestIndictmentProduct[j].PRODUCT_SUBTYPE_NAME + '/' +
                                              _itemsLawsuitArrestMain
                                                  .LawsuitArrestIndictmentProduct[
                                                      index]
                                                  .PRODUCT_BRAND_NAME_TH,
                                          style: textStyleData,
                                        ),
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
                        }),
                  ),
          ],
        ),
      ],
    );
  }

  //************************start_tab_3*****************************
  Widget _buildContent_tab_() {
    Widget _buildContent(BuildContext context) {
      String title = "", firstname = "", lastname = "";
      if (_onEdited) {
        _itemsReturnMain.LawsuitStaff.forEach((staff) {
          title = staff.TITLE_SHORT_NAME_TH != null
              ? staff.TITLE_SHORT_NAME_TH
              : staff.TITLE_NAME_TH;
          firstname = staff.FIRST_NAME != null ? staff.FIRST_NAME : "";
          lastname = staff.LAST_NAME != null ? staff.LAST_NAME : "";
        });
      } else {
        title = widget.ItemsPerson.TITLE_SHORT_NAME_TH != null
            ? widget.ItemsPerson.TITLE_SHORT_NAME_TH
            : "";
        firstname = widget.ItemsPerson.FIRST_NAME != null
            ? widget.ItemsPerson.FIRST_NAME
            : "";
        lastname = widget.ItemsPerson.LAST_NAME != null
            ? widget.ItemsPerson.LAST_NAME
            : "";
      }
      return Container(
        padding:
            EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ชื่อเจ้าพนักงาน",
                    style: textStyleLabel,
                  ),
                ),
                /*Padding(
                padding: paddingData,
                child: Text(
                  title+firstname+" "+lastname, style: textStyleData,),
              ),*/
                Container(
                  padding: paddingData,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        //padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            //_navigateSearchStaff(context);
                          },
                          focusNode: myFocusNodeLawsuitPersonName,
                          controller: editLawsuitPersonName,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            //suffixIcon: Icon(Icons.search,color: Colors.grey,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "เหตุผล",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                    padding: paddingData,
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: TextField(
                        maxLines: 10,
                        focusNode: myFocusNodeReason,
                        controller: editReason,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[500], width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[400], width: 0.5),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String title = "";
      String firstname = "";
      String lastname = "";

      _itemsReturnMain.LawsuitStaff.forEach((item) {
        title = item.TITLE_SHORT_NAME_TH != null
            ? item.TITLE_SHORT_NAME_TH
            : item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      return Container(
        padding:
            EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      _itemsReturnMain.IS_LAWSUIT == 0 ? "ไม่รับคดี" : "",
                      style: textStyleData,
                    ),
                  ),
                ],
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
                child: Text(
                  "ชื่อเจ้าพนักงาน",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  title + firstname + " " + lastname,
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "เหตุผล",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  _itemsReturnMain.REMARK_NOT_LAWSUIT,
                  style: textStyleData,
                ),
              ),
            ],
          ),
          _itemsReturnMain.IS_OUTSIDE == 1
              ? Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<Constants>(
                    onSelected: choiceAction,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) {
                      return constants.map((Constants contants) {
                        return PopupMenuItem<Constants>(
                          value: contants,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(
                                  contants.icon,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text(contants.text,
                                    style: TextStyle(
                                        fontFamily: FontStyles().FontFamily)),
                              )
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                )
              : Container()
        ]),
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
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_02_00_05_00', style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved
                    ? _buildContent_saved(context)
                    : _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_3*******************************/

  bool Success = false;
  ItemsListArrestPerson ItemsPreviewIndicmentDetail = null;
  //on show dialog
  Future<bool> onLoadActionIndicmentDetail(
      BuildContext context, Map map) async {
    await new ArrestFuture().apiRequestMasPersongetByCon(map).then((onValue) {
      Success = onValue.SUCCESS;
      onValue.RESPONSE_DATA.forEach((item) {
        ItemsPreviewIndicmentDetail = item;
      });
    });
    setState(() {});
    return true;
  }

  _navigatePreviewIndicmentDetail(BuildContext context, Map map) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionIndicmentDetail(context, map);
    Navigator.pop(context);

    if (Success) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenLawsuitDeatilSuspect(
                  ItemsSuspect: ItemsPreviewIndicmentDetail,
                )),
      );
      print(result);
      /*_itemsData=result;
      Navigator.pop(context,_itemsData);*/
    }
  }

  Widget _buildContent_tab_2() {
    Widget _buildContent(BuildContext context) {
      return Container(
          padding:
              EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "เลขที่คืน",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          'Auto Generate',
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "วันที่คืน",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          '09 กันยายน 2561   เวลา 13.00 น.',
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้คืนของกลาง",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH +
                              _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME +
                              " " +
                              _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "หน่วยงาน",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          'สสพ.สุราษฎร์ธานี',
                          style: textStyleData,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    ExpandableNotifier(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expandable(
                            collapsed: buildCollapsed(),
                            expanded: buildExpanded(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    }

    //data result when search data
    return Scaffold(
        backgroundColor: Colors.grey[200],
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
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_02_00_04_00',
                        style: textStylePageName,
                      ),
                    )
                  ],
                ),
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
        ));
  }

//************************end_tab_2*******************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab3.length,
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
                      )),
                  child: ListTile(
                      title: Text(
                        (index + 1).toString() +
                            '. ' +
                            itemsFormsTab3[index].FormsName,
                        style: textInputStyleTitle,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[300],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabScreenArrest8Dowload(
                                    Title: itemsFormsTab3[index].FormsName,
                                  ),
                            ));
                      }),
                ),
              );
            }),
      );
    }

    //data result when search data
    return Scaffold(
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
                  )),
              /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_02_00_07_00', style: textStylePageName,),
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
