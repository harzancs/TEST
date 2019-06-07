import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_deatail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_staff.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_accept_screen_sentence.dart';
//import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_not_accept_screen_suspect.dart';
//import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/tab_screen_lawsuit_product.dart';
//import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/tab_screen_lawsuit_staff_search.dart';
//import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/tab_screen_lawsuit_suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/future/lawsuit_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_evidence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_proof.dart';
import 'package:flutter/services.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/future/arrest_future.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_person.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/item_lawsuit_deatail.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/lawsuit_accept_screen_sentence.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/tab_screen_lawsuit_product.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/tab_screen_lawsuit_staff_search.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/detail/tab_screen_lawsuit_suspect.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/future/return_future.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/choice.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

const double _kPickerSheetHeight = 216.0;
class LawsuitAcceptCaseMainScreenNonProofFragment extends StatefulWidget {
  ItemsReturnArrestMain itemsReturnMain ;
  ItemsPersonInformation ItemsPerson;
  bool IsPreview;
  bool IsEdit;
  bool IsCreate;
  ItemsReturnMain itemsPreview;
  LawsuitAcceptCaseMainScreenNonProofFragment({
    Key key,
    @required this.itemsReturnMain,
    @required this.ItemsPerson,
    @required this.IsPreview,
    @required this.IsEdit,
    @required this.IsCreate,
    @required this.itemsPreview, ItemsReturnArrestMain ItemsReturnMain,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitAcceptCaseMainScreenNonProofFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  //เลือกของกลางทั้งหมด
  bool isCheckAll = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลรับคำกล่าวโทษฟฟฟ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  ItemsReturnArrestMain _itemsLawsuitArrestMain;
  ItemsReturnMain _itemsLawsuitMain;
  var _itemsStaff;
  var _itemStaffUpdate;

  List<ItemsLawsuitForms> itemsFormsTab3 = [];

  String _lawsuitDate,_proveDate;
  String _currentDateLawsuit, _currentTimeLawsuit, _currentDateProof,
      _currentTimeProof;
  var dateFormatDate, dateFormatTime;
  DateTime _initDate = DateTime.now();

  DateTime _dtDateLawsuit,_dtDateProof;
  DateTime lawsuitTime = DateTime.now();
  DateTime proofTime = DateTime.now();
  String _lawsuitTime;

  @override
  void initState() {
    super.initState();

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    var formatter = new DateFormat('yyyy');
    String year = formatter.format(DateTime.now());
    editLawsuitYear.text = (int.parse(year) + 543).toString();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    _currentDateLawsuit = date;
    editLawsuitDate.text = _currentDateLawsuit;

    _currentTimeLawsuit = dateFormatTime.format(DateTime.now()).toString();
    editLawsuitTime.text = _currentTimeLawsuit;

    _lawsuitDate = DateTime.now().toString();
    _proveDate = DateTime.now().toString();


    String title = widget.ItemsPerson.TITLE_SHORT_NAME_TH!=null
        ?widget.ItemsPerson.TITLE_SHORT_NAME_TH
        :"";
    String firstname =  widget.ItemsPerson.FIRST_NAME!=null
        ?widget.ItemsPerson.FIRST_NAME
        :"";
    String lastname =  widget.ItemsPerson.LAST_NAME!=null
        ?widget.ItemsPerson.LAST_NAME
        :"";
    editLawsuitPersonName.text = title+firstname+" "+lastname;
    _itemsStaff=widget.ItemsPerson;


    //widget.itemsReturnMain.IS_PROVE=1;
    //กรณีพิสูจน์
    if (widget.itemsReturnMain.IS_PROVE==1) {
      editProofPerson.text = title + firstname + " " + lastname;
      choices.insert(1, Choice(title: "นำส่งเพื่อพิสูจน์"));
    }


    _currentDateProof = date;
    _currentTimeProof = dateFormatTime.format(DateTime.now()).toString();
    editProofDate.text = _currentDateProof;
    editProofTime.text = _currentTimeProof;

    _dtDateLawsuit=DateTime.now();
    _dtDateProof=DateTime.now();


    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      _itemsLawsuitArrestMain = widget.itemsReturnMain;
      _itemsLawsuitMain = widget.itemsPreview;
      _setDataSaved();
    }
    if (widget.IsEdit) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      //_onEdited = widget.IsEdit;
      _itemsLawsuitArrestMain = widget.itemsReturnMain;
      //_setInitDataLawsuit();
    }
    if(widget.IsCreate){
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      _itemsLawsuitArrestMain = widget.itemsReturnMain;
    }

  }

  /*****************************view tab1**************************/
  //node focus
  //lawsuit
  final FocusNode myFocusNodeLawsuitNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitYear = FocusNode();
  final FocusNode myFocusNodeLawsuitDate = FocusNode();
  final FocusNode myFocusNodeLawsuitTime = FocusNode();
  final FocusNode myFocusNodeLawsuitPlace = FocusNode();
  final FocusNode myFocusNodeLawsuitPersonName = FocusNode();
  final FocusNode myFocusNodeLawsuitTestimony = FocusNode();

  //poof
  final FocusNode myFocusNodeProofNumber = FocusNode();
  final FocusNode myFocusNodeProofYear = FocusNode();
  final FocusNode myFocusNodeProofDate = FocusNode();
  final FocusNode myFocusNodeProofTime = FocusNode();
  final FocusNode myFocusNodeProofPerson = FocusNode();

  //textfield
  //lawsuit
  TextEditingController editLawsuitNumber = new TextEditingController();
  TextEditingController editLawsuitYear = new TextEditingController();
  TextEditingController editLawsuitDate = new TextEditingController();
  TextEditingController editLawsuitTime = new TextEditingController();
  TextEditingController editLawsuitPlace = new TextEditingController();
  TextEditingController editLawsuitPersonName = new TextEditingController();
  TextEditingController editTestimony = new TextEditingController();

  //poof
  TextEditingController editProofNumber = new TextEditingController();
  TextEditingController editProofYear = new TextEditingController();
  TextEditingController editProofDate  = new TextEditingController();
  TextEditingController editProofTime  = new TextEditingController();
  TextEditingController editProofPerson  = new TextEditingController();

  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStylePay = TextStyle(fontSize: 16.0, color: Colors.white,fontFamily: FontStyles().FontFamily);

  TextStyle textStyleLabel = TextStyle(
      fontSize: 16, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSubData = TextStyle(fontSize: 16, color: Colors.black38,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0);
  TextStyle textStyleStar = TextStyle(color: Colors.red,fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleSub = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSentence = TextStyle(color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  EdgeInsets paddindSentence = EdgeInsets.only(
      top: 8.0, bottom: 8.0, left: 14.0, right: 14.0);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleCheckAll = TextStyle(
      fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);

  /**********************Droupdown View *****************************/
  List<String> dropdownItemsTab3 = ['ผู้จับกุม', 'ผู้ร่วมจับกุม'];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  /*void _setInitDataLawsuit() {
    editLawsuitNumber.text = widget.itemsLawsuitMainAcceptCase.LawsuitNumber;
    editLawsuitYear.text = widget.itemsLawsuitMainAcceptCase.LawsuitYear;
    _currentDateLawsuit = widget.itemsLawsuitMainAcceptCase.LawsuitDate;
    _currentTimeLawsuit = widget.itemsLawsuitMainAcceptCase.LawsuitTime;
    editLawsuitPlace.text = widget.itemsLawsuitMainAcceptCase.LawsuitPlace;
    editLawsuitPersonName.text =
        widget.itemsLawsuitMainAcceptCase.LawsuitPersonName;
    editTestimony.text = widget.itemsLawsuitMainAcceptCase.LawsuitTestimony;
  }

  void _setInitDataProof() {
    editProofNumber.text = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofNumber;
    editProofYear.text = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofNumber1;
    _currentDateProof = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofDate;
    _currentTimeProof = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofDate;
  }*/

  void _setDataSaved() {
    //is active false

    itemsFormsTab3=[];
    //add item tab 3
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "เเบบฟอร์มบันทึกรับคำกล่าวโทษ"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "เเบบฟอร์มคำให้การของผู้กล่าวโทษ"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "คำร้องขอให้เปรียบเทียบคดี คด.1 นายเสนาะ อุตโม"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "คำร้องขอให้เปรียบเทียบคดี คด.1 นางวิไล เมืองใจ"));
    itemsFormsTab3.add(
        new ItemsLawsuitForms("ทะเบียนประวัติผู้กระทำผิด"));
    itemsFormsTab3.add(new ItemsLawsuitForms(
        "รายละเอียดการกระทำผิดผู้กระทำผิด"));

    choices.add(Choice(title: 'แบบฟอร์ม'));
    tabController =
        TabController(length: choices.length, vsync: this);
    _tabPageSelector =
    new TabPageSelector(controller: tabController);
  }

  @override
  void dispose() {
    super.dispose();
    editLawsuitNumber.dispose();
    editLawsuitYear.dispose();
    editLawsuitPlace.dispose();
    editLawsuitPersonName.dispose();
    editTestimony.dispose();
    editLawsuitDate.dispose();
    editLawsuitTime.dispose();

    //proof
    editProofNumber.dispose();
    editProofYear.dispose();
    editProofDate.dispose();
    editProofTime.dispose();
    editProofPerson.dispose();
  }

  void _setTextField(){
    String lawsuit_date = "";
    String lawsuit_year = "";
    DateTime dt_lawsuit_date = DateTime.parse(_itemsLawsuitMain.LAWSUIT_DATE);
    DateTime dt_lawsuit_year = DateTime.parse(_itemsLawsuitMain.LAWSUIT_NO_YEAR);
    List splitslawDate = dateFormatDate.format(dt_lawsuit_date).toString().split(
        " ");
    List splitslawYear = dateFormatDate.format(dt_lawsuit_year).toString().split(
        " ");
    lawsuit_date = splitslawDate[0] + " " + splitslawDate[1] + " " +
        (int.parse(splitslawDate[3]) + 543).toString();
    lawsuit_year = (int.parse(splitslawYear[3]) + 543).toString();

    editLawsuitNumber.text=_itemsLawsuitMain.LAWSUIT_NO.toString();
    editLawsuitYear.text=lawsuit_year;
    editLawsuitDate.text=lawsuit_date;
    editLawsuitTime.text = dateFormatTime.format(dt_lawsuit_date).toString();
    editLawsuitPlace.text=_itemsLawsuitMain.OFFICE_NAME;
    editTestimony.text=_itemsLawsuitMain.TESTIMONY;
    _itemsLawsuitMain.LawsuitStaff.forEach((f){
      //editLawsuitPersonName.text = f.TITLE_SHORT_NAME_TH+f.FIRST_NAME+" "+f.LAST_NAME;
      editLawsuitPersonName.text = f.TITLE_NAME_TH+f.FIRST_NAME+" "+f.LAST_NAME;
    });


    if(_itemsLawsuitArrestMain.IS_PROVE==1){
      DateTime dt_proof_date = DateTime.parse(_itemsLawsuitMain.DELIVERY_DOC_DATE);
      List splitsProofDate = dateFormatDate.format(dt_proof_date).toString().split(
          " ");
      String proof_date = splitsProofDate[0] + " " + splitsProofDate[1] + " " +
          (int.parse(splitsProofDate[3]) + 543).toString();
      editProofNumber.text=_itemsLawsuitMain.DELIVERY_DOC_NO_1;
      editProofYear.text=_itemsLawsuitMain.DELIVERY_DOC_NO_2;
      editProofDate.text=proof_date;
      editProofTime.text=dateFormatTime.format(dt_proof_date).toString();
    }
  }
  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        choices.removeAt(choices.length-1);
        _setTextField();
      } else {
        _onDeleted=true;
        _showDeleteAlertDialog();
      }
    });
  }

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
                Navigator.pop(context,"Back");
                setState(() {
                  onDeleted();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void onDeleted()async{
    Map map = {
      "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID
    };
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionInsLawsuitDelete(map);
    Navigator.pop(context);
  }
  Future<bool> onLoadActionInsLawsuitDelete(Map map) async {
    Map map_indic={
      "INDICTMENT_ID" : _itemsLawsuitArrestMain.INDICTMENT_ID,
    };
    await new ReturnFuture().apiRequestLawsuiltArrestIndictmentupdDeleteIndictmentComplete(map_indic).then((onValue) {
      print("Delete IndictmentComplete : "+onValue.Msg);
    });
    Map map_arrest={
      "ARREST_ID" : _itemsLawsuitArrestMain.ARREST_ID,
    };
    await new ReturnFuture().apiRequestLawsuiltArrestIndictmentupdDeleteArrestComplete(map_arrest).then((onValue) {
      print("Delete ArrestComplete : "+onValue.Msg);
    });


    List<Map> map_pay=[];
    /*_itemsLawsuitMain.LawsuitDetail.forEach((item){
      item.LawsuitPayment.forEach((item){
        map_pay.add({
          "PAYMENT_ID" : item.PAYMENT_ID
        });
      });
    });*/

    if(map_pay.isNotEmpty){
      await new ReturnFuture().apiRequestLawsuitPaymentupdDelete(map_pay).then((onValue) {
        print("Delete Payment : "+onValue.Msg);
      });
    }


    await new ReturnFuture().apiRequestLawsuitupdDelete(map).then((onValue) {
      setState(() {
        _onSaved = false;
        _onEdited = true;
        _onSave = false;
        clearTextfield();
        choices.removeAt(choices.length-1);

        Navigator.pop(context,_itemsLawsuitMain);
      });
    });
    setState(() {});
    return true;
  }

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  void onProve()async{
    Map map = {
      "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID
    };
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionProveGet(map);
    Navigator.pop(context);
  }
  Future<bool> onLoadActionProveGet(Map map) async {
    int proveID;
    await new ReturnFuture().apiRequestLawsuiltProvegetByLawsuitID(map).then((onValue) {
      proveID = onValue.PROVE_ID;
    });
    if(proveID!=null){
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProveMainScreenFragment(
          itemsProveMain: null,
          IsEdit: false,
          IsPreview: false,
        )),
      );
      if(result.toString()!="Back") {
        //
      }
    }
    setState(() {});
    return true;
  }

  void clearTextfield() {
    editLawsuitNumber.clear();
    editLawsuitYear.clear();
    editLawsuitPlace.clear();
    editLawsuitPersonName.clear();
    editTestimony.clear();

    editProofYear.clear();
    editProofNumber.clear();

    /*widget.itemsCaseInformation.Evidenses.forEach((item){
      item.IsCkecked=false;
    });*/
  }

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

                if(!_onEdited) {
                  Navigator.pop(mContext,"Back");
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
  }

  /*****************************method for main tab1**************************/
  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }
  CupertinoAlertDialog _cupertinoSearchEmpty(mContext,text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(text,
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showSearchEmptyAlertDialog(context,text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context,text);
      },
    );
  }

  void onSaved(BuildContext mContext)async{
    if (editLawsuitNumber.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกเลขที่รับคำกล่าวโทษ');
    }else if (editLawsuitPlace.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกสถานที่ทำการ');
    }else if (editTestimony.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกคำให้การของผู้กล่าวโทษ');
    }else if (_itemsLawsuitArrestMain.IS_PROVE==1&&(editProofNumber.text.isEmpty||editProofYear.text.isEmpty)) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกเลขที่หนังสือนำส่งให้ครบทุกช่อง');
    }else{
      if(!_onEdited){
        List<Map> LawsuitDetail =[];
        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.forEach((item){
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
          "OFFICE_CODE": "000000",
          "OFFICE_NAME": "สำนักงานสรรพสเทพฯ 3",
          "IS_LAWSUIT": 1,
          "REMARK_NOT_LAWSUIT": "",
          "LAWSUIT_NO": int.parse(editLawsuitNumber.text),
          "LAWSUIT_NO_YEAR": DateTime.now().toString(),
          "LAWSUIT_DATE": _lawsuitDate,
          "TESTIMONY": editTestimony.text,
          "DELIVERY_DOC_NO_1": _itemsLawsuitArrestMain.IS_PROVE==1?editProofNumber.text:"",
          "DELIVERY_DOC_NO_2": _itemsLawsuitArrestMain.IS_PROVE==1?editProofYear.text:"",
          "DELIVERY_DOC_DATE": _itemsLawsuitArrestMain.IS_PROVE==1?_proveDate:"",
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
              "FIRST_NAME":_itemsStaff.FIRST_NAME,
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
              "OPERATION_OFFICE_CODE":"000000",
              "OPERATION_OFFICE_NAME":"",
              "OPERATION_OFFICE_SHORT_NAME":"",
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

        List<Map> map_pay = [];
        /*_itemsLawsuitMain.LawsuitDetail.forEach((item){
          map_pay.add({
            "PAYMENT_ID": "",
            "LAWSUIT_DETAIL_ID": item.LAWSUIT_DETAIL_ID,
            "COMPARE_DETAIL_ID": 0,
            "FINE_TYPE": item.IS_FINE,
            "FINE": item.FINE,
            "PAYMENT_PERIOD_NO": 1,
            "PAYMENT_DATE": item.FINE_DATE,
            "IS_REQUEST_REWARD": 0,
            "IS_ACTIVE": 1,
            "LawsuitPaymentDetail":
            [
              {
                "PAYMENT_DETAIL_ID": "",
                "PAYMENT_ID": "",
                "NOTICE_ID": 1,
                "IS_REQUEST_BRIBE": 0,
                "IS_ACTIVE": 1
              }
            ]
          });
        });
        print("map_pay : "+map_pay.isNotEmpty.toString());*/

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(
                ),
              );
            });
        await onLoadActionInsLawsuitAll(map,map_pay.isNotEmpty,map_pay);
        Navigator.pop(context);
      }else{
        List<Map> LawsuitDetail =[];
        _itemsLawsuitMain.LawsuitDetail.forEach((item){
          LawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": item.LAWSUIT_DETAIL_ID,
            "LAWSUIT_ID": item.LAWSUIT_ID,
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "COURT_ID": 0,
            "LAWSUIT_TYPE": 0,
            "LAWSUIT_END": 0,
            "COURT_NAME": item.COURT_NAME,
            "UNDECIDE_NO_1": 1,
            "UNDECIDE_NO_YEAR_1": "",
            "DECIDE_NO_1": 2,
            "DECIDE_NO_YEAR_1": "",
            "UNDECIDE_NO_2": item.UNDECIDE_NO_2,
            "UNDECIDE_NO_YEAR_2": item.UNDECIDE_NO_YEAR_2,
            "DECIDE_NO_2": item.DECIDE_NO_2,
            "DECIDE_NO_YEAR_2":item.DECIDE_NO_YEAR_2,
            "JUDGEMENT_NO": 12,
            "JUDGEMENT_NO_YEAR": "",
            "JUDGEMENT_DATE": item.JUDGEMENT_DATE,
            "IS_IMPRISON": item.IS_IMPRISON,
            "IMPRISON_TIME": item.IMPRISON_TIME,
            "IMPRISON_TIME_UNIT": item.IMPRISON_TIME_UNIT,
            "IS_FINE": item.IS_FINE,
            "FINE": item.FINE,
            "IS_PAYONCE": item.IS_PAYONCE,
            "FINE_DATE": item.FINE_DATE,
            "PAYMENT_PERIOD": item.PAYMENT_PERIOD,
            "PAYMENT_PERIOD_DUE": item.PAYMENT_PERIOD_DUE,
            "PAYMENT_PERIOD_DUE_UNIT": item.IMPRISON_TIME_UNIT,
            "IS_ACTIVE": 1
          });
        });

        Map map = {
          "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID,
          "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
          "OFFICE_ID": _itemsLawsuitMain.OFFICE_ID,
          "OFFICE_CODE": _itemsLawsuitMain.OFFICE_CODE,
          "OFFICE_NAME": _itemsLawsuitMain.OFFICE_NAME,
          "IS_LAWSUIT": _itemsLawsuitMain.IS_LAWSUIT,
          "REMARK_NOT_LAWSUIT": "",
          "LAWSUIT_NO": int.parse(editLawsuitNumber.text),
          "LAWSUIT_NO_YEAR": DateTime.now().toString(),
          "LAWSUIT_DATE": _lawsuitDate,
          "TESTIMONY": editTestimony.text,
          "DELIVERY_DOC_NO_1": _itemsLawsuitArrestMain.IS_PROVE==1?editProofNumber.text:"",
          "DELIVERY_DOC_NO_2": _itemsLawsuitArrestMain.IS_PROVE==1?editProofYear.text:"",
          "DELIVERY_DOC_DATE": _itemsLawsuitArrestMain.IS_PROVE==1?_proveDate:"",
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
        if(_itemStaffUpdate!=null){
          map_staff.add({
            "STAFF_ID": _itemsLawsuitMain.LawsuitStaff[0].STAFF_ID,
            "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID,
            "STAFF_REF_ID": 1,
            "TITLE_ID": "1",
            "STAFF_CODE": _itemStaffUpdate.STAFF_CODE,
            "ID_CARD": "127896325",
            "STAFF_TYPE": 1,
            "TITLE_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME":_itemStaffUpdate.FIRST_NAME,
            "LAST_NAME": _itemStaffUpdate.LAST_NAME,
            "AGE": "27",
            "OPERATION_POS_CODE": "",
            "OPREATION_POS_NAME": _itemStaffUpdate.OPREATION_POS_NAME,
            "OPREATION_POS_LEVEL": "",
            "OPERATION_POS_LEVEL_NAME": _itemStaffUpdate.OPREATION_POS_LAVEL_NAME,
            "OPERATION_DEPT_CODE": "",
            "OPERATION_DEPT_NAME": "",
            "OPERATION_DEPT_LEVEL": "",
            "OPERATION_UNDER_DEPT_CODE": "",
            "OPERATION_UNDER_DEPT_NAME": "",
            "OPERATION_UNDER_DEPT_LEVEL": "",
            "OPERATION_OFFICE_CODE":"000000",
            "OPERATION_OFFICE_NAME":"",
            "OPERATION_OFFICE_SHORT_NAME":"",
            "MANAGEMENT_WORK_DEPT_CODE": "",
            "MANAGEMENT_WORK_DEPT_NAME": "",
            "MANAGEMENT_WORK_DEPT_LEVEL": "",
            "MANAGEMENT_OFFICE_CODE": "",
            "MANAGEMENT_OFFICE_NAME": _itemStaffUpdate.OPERATION_OFFICE_NAME,
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
                child: CupertinoActivityIndicator(
                ),
              );
            });
        await onLoadActionInsLawsuitUpAll(map,map_staff.isEmpty,map_staff);
        Navigator.pop(context);
      }
    }
  }
  Future<bool> onLoadActionInsLawsuitAll(Map map,IsPayment,List<Map> map_pay) async {
    int LAWSUIT_ID;
    await new ReturnFuture().apiRequestLawsuitinsAll(map).then((onValue) {
      LAWSUIT_ID = onValue.LAWSUIT_ID;
    });
    Map map_indic={
      "INDICTMENT_ID" : _itemsLawsuitArrestMain.INDICTMENT_ID,
    };
    await new ReturnFuture().apiRequestLawsuiltArrestIndictmentupdIndictmentComplete(map_indic).then((onValue) {
      print("Update IndictmentComplete : "+onValue.Msg);
    });
    Map map_arrest={
      "ARREST_ID" : _itemsLawsuitArrestMain.ARREST_ID,
    };
    await new ReturnFuture().apiRequestLawsuiltArrestIndictmentupdArrestComplete(map_arrest).then((onValue) {
      print("Update ArrestComplete : "+onValue.Msg);
    });

    if(IsPayment){
      await new ReturnFuture().apiRequestLawsuitPaymentinsAll(map_pay).then((onValue) {
        print("Add Payment : "+onValue.Msg);
      });
    }

    if(LAWSUIT_ID!=null){
      Map map = {
        "LAWSUIT_ID": LAWSUIT_ID
      };
      await new ReturnFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
        _itemsLawsuitMain = onValue;
      });


      _onSaved = true;
      _onFinish = true;

      itemsFormsTab3=[];
      //add item tab 3
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ"));
      itemsFormsTab3.add(new ItemsLawsuitForms("ทะเบียนประวัติผู้กระทำผิด"));
      itemsFormsTab3.add(new ItemsLawsuitForms("รายละเอียดการกระทำผิดผู้กระทำผิด"));
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController =
          TabController(length: choices.length, vsync: this);
      _tabPageSelector =
      new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length-1);
    }

    setState(() {});
    return true;
  }
  Future<bool> onLoadActionInsLawsuitUpAll(Map map,bool IsStaffUpdate,List<Map> map_staff) async {
    await new ReturnFuture().apiRequestLawsuitupdAll(map).then((onValue) {
    });

    if(!IsStaffUpdate){
      await new ReturnFuture().apiRequestLawsuitStaffupdAll(map_staff).then((onValue) {
      });
    }
    if(_itemsLawsuitMain.LAWSUIT_ID!=null){
      Map map = {
        "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID
      };
      await new ReturnFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
        _itemsLawsuitMain = onValue;
      });


      _onSaved = true;
      _onFinish = true;
      _onEdited = false;
      //add item tab 3
      itemsFormsTab3=[];
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ"));
      itemsFormsTab3.add(new ItemsLawsuitForms("ทะเบียนประวัติผู้กระทำผิด"));
      itemsFormsTab3.add(new ItemsLawsuitForms("รายละเอียดการกระทำผิดผู้กระทำผิด"));
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController =
          TabController(length: choices.length, vsync: this);
      _tabPageSelector =
      new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length-1);

      tabController =
          TabController(length: choices.length, vsync: this);
      _tabPageSelector =
      new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length-1);
    }

    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    final List<Widget> rowContents = <Widget>[
      new SizedBox(
          width: width / 3,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
                /*_onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :*/
                _onSaved ? Navigator.pop(context, "Back") :
                _showCancelAlertDialog(context);
              },
              padding: EdgeInsets.all(10.0),
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.arrow_back_ios, color: Colors.white,),
                  !_onSaved
                      ? new Text("ยกเลิก", style: appBarStyle,)
                      : new Container(),
                ],
              ),
            ),
          )
      ),
      Expanded(
          child: Center(child: Text("รับคำกล่าวโทษ", style: appBarStyle),
          )),
      new SizedBox(
          width: width / 3,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _onSaved ? (_onSave ? new FlatButton(
                  onPressed: () {
                    setState(() {
                      _onSaved = true;
                      _onSave = false;
                      _onEdited = false;
                    });
                    //TabScreenArrest1().createAcceptAlert(context);
                  },
                  child: Text('บันทึก', style: appBarStyle))
                  :
              widget.itemsReturnMain.IS_PROVE==1 ? ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: FlatButton(
                    onPressed: (){
                      //เมื่อพิสูจน์
                      //onProve();
                    },
                    child: Row(
                      children: <Widget>[
                        Text('พิสูจน์', style: appBarStylePay),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                  )) : (_itemsLawsuitArrestMain.IS_COMPARE==1 ? new ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: FlatButton(
                    onPressed: (){
                      //เมื่อชำระค่าปรับ
                    },
                    child: Row(
                      children: <Widget>[
                        Text('ชำระค่าปรับ', style: appBarStylePay),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                  )
              ) : Container())
              )
                  :
              new FlatButton(
                  onPressed: () {
                    onSaved(context);
                  },
                  child: Text('บันทึก', style: appBarStyle)),
            ],
          )
      )
    ];
    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_onSaved) {
            if (_onEdited) {
              _onEdited = false;
              _onSaved = false;
            } else {
              Navigator.pop(context, widget.itemsReturnMain);
            }
          } else {
            Navigator.pop(context, widget.itemsReturnMain);
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
                child: new Row(
                    children: rowContents),
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
                    isScrollable: choices.length >3  ? true : false,
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
                  children: widget.itemsReturnMain.IS_PROVE==1 ? (_onFinish ? <
                      Widget>[
                    //กรณีพิสูจน์
                    _buildContent_tab_1(),
                    _buildContent_tab_proof(),
                    _buildContent_tab_2(),
                    _buildContent_tab_3(),
                  ] :
                  <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_proof(),
                    _buildContent_tab_2(),
                  ])
                      : _onFinish ? <Widget>[
                    //กรณีไม่พิสูจน์
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
  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 22.0,fontFamily: FontStyles().FontFamily
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  _navigateSearchStaff(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenLawsuitStaffSearch()),
    );
    if(result.toString()!="Back"){
      var itemStaff = result;
      _itemsStaff = itemStaff;
      _itemStaffUpdate = itemStaff;
      String title = itemStaff.TITLE_SHORT_NAME_TH!=null
          ?itemStaff.TITLE_SHORT_NAME_TH
          :itemStaff.TITLE_NAME_TH;
      String firstname = itemStaff.FIRST_NAME!=null
          ?itemStaff.FIRST_NAME
          :"";
      String lastname =  itemStaff.LAST_NAME!=null
          ?itemStaff.LAST_NAME
          :"";
      editLawsuitPersonName.text = title+firstname+" "+lastname;

    }
  }

  //************************start_tab_1*****************************
  Widget _buildContent_tab_1() {

    _navigateLawsuitAcceptCaseSentence(BuildContext context,
        ItemsListReturnDetail itemSentence,index) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            ReturnAcceptSentenceScreenFragment(
              ItemSentence: itemSentence,
              IsPreview: _onSaved,
              IsUpdate: _onEdited,
            )),
      );
      if (result.toString() != "Back") {
        if(_onEdited){
          _itemsLawsuitMain.LawsuitDetail[index] = result;

          _itemsLawsuitMain.LawsuitDetail.forEach((item){

          });
        }
      }
    }


    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Padding(
                              padding: paddingData,
                              child: new Text("น.",
                                style: textStyleData,
                              ),
                            ),
                            Container(
                              width: ((size.width * 75) / 100) / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeLawsuitNumber,
                                      controller: editLawsuitNumber,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                            new Padding(
                              padding: paddingData,
                              child: new Text("/",
                                style: textStyleData,
                              ),
                            ),
                            Container(
                              width: ((size.width * 75) / 100) / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeLawsuitYear,
                                      controller: editLawsuitYear,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(
                                new FocusNode());
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DynamicDialog(
                                      Current: _dtDateLawsuit);
                                }).then((s) {
                              String date = "";
                              List splits = dateFormatDate.format(
                                  s).toString().split(" ");
                              date = splits[0] + " " + splits[1] +
                                  " " +
                                  (int.parse(splits[3]) + 543)
                                      .toString();
                              setState(() {
                                _dtDateLawsuit = s;
                                _currentDateLawsuit = date;
                                editLawsuitDate.text = _currentDateLawsuit;
                                _lawsuitDate = _dtDateLawsuit.toString();
                              });
                            });
                          },
                          focusNode: myFocusNodeLawsuitDate,
                          controller: editLawsuitDate,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(FontAwesomeIcons.calendarAlt,
                              color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text("เวลา", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      /*Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ListTile(
                              title: Text(
                                _currentTimeLawsuit, style: textStyleData,),
                              onTap: () {

                              },
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),*/
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(
                                new FocusNode());
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildBottomPicker(
                                  CupertinoDatePicker(
                                    use24hFormat: true,
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: lawsuitTime,
                                    onDateTimeChanged: (DateTime newDateTime) {
                                      setState(() {
                                        lawsuitTime = newDateTime;
                                        _currentTimeLawsuit =
                                            dateFormatTime.format(lawsuitTime)
                                                .toString();
                                        editLawsuitTime.text =
                                            _currentTimeLawsuit;

                                        List splitsArrestDate = _dtDateLawsuit
                                            .toUtc().toLocal().toString().split(
                                            " ");
                                        List splitsArrestTime = lawsuitTime
                                            .toString().split(" ");
                                        _lawsuitDate =
                                            splitsArrestDate[0].toString() +
                                                " " +
                                                splitsArrestTime[1].toString();
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          focusNode: myFocusNodeLawsuitTime,
                          controller: editLawsuitTime,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("สถานที่ทำการ", style: textStyleLabel,),
                      ),
                      Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              //padding: paddingData,
                              child: TextField(
                                focusNode: myFocusNodeLawsuitPlace,
                                controller: editLawsuitPlace,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ชื่อผู้รับคดี", style: textStyleLabel,),
                      ),
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
                                  FocusScope.of(context).requestFocus(
                                      new FocusNode());
                                  //_navigateSearchStaff(context);
                                },
                                focusNode: myFocusNodeLawsuitPersonName,
                                controller: editLawsuitPersonName,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  /*suffixIcon: Icon(
                                    Icons.search, color: Colors.grey,),*/
                                ),
                              ),
                            ),
                            /*Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),*/
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "คำให้การของผู้กล่าวโทษ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              //padding: paddingData,
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                focusNode: myFocusNodeLawsuitTestimony,
                                controller: editTestimony,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: Container(
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ผู้ต้องหา", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                // new
                                itemCount: _itemsLawsuitArrestMain
                                    .LawsuitArrestIndictmentDetail
                                    .length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int j) {
                                  int LAWSUIT_TYPE = 0;
                                  ItemsListReturnDetail lawDetail;
                                  var lawIndicDetail;
                                  if(_itemsLawsuitMain==null){
                                    lawIndicDetail=_itemsLawsuitArrestMain
                                        .LawsuitArrestIndictmentDetail[j];
                                  }else {
                                    for (int i = 0; i <
                                        _itemsLawsuitMain.LawsuitDetail.length;
                                    i++) {
                                      print(_itemsLawsuitMain.LawsuitDetail[i]
                                          .INDICTMENT_DETAIL_ID.toString() +
                                          " : " + _itemsLawsuitArrestMain
                                          .LawsuitArrestIndictmentDetail[j]
                                          .INDICTMENT_DETAIL_ID.toString());

                                      if (_itemsLawsuitArrestMain
                                          .LawsuitArrestIndictmentDetail[j]
                                          .INDICTMENT_DETAIL_ID ==
                                          _itemsLawsuitMain.LawsuitDetail[i]
                                              .INDICTMENT_DETAIL_ID) {
                                        if (_itemsLawsuitMain.LawsuitDetail[i]
                                            .LAWSUIT_TYPE == 0 ||
                                            _itemsLawsuitMain.LawsuitDetail[i]
                                                .LAWSUIT_TYPE == 2) {
                                          LAWSUIT_TYPE = 1;
                                        } else
                                        if (_itemsLawsuitMain.LawsuitDetail[i]
                                            .LAWSUIT_TYPE == 1) {
                                          LAWSUIT_TYPE = 0;
                                        }

                                        lawDetail =
                                        _itemsLawsuitMain.LawsuitDetail[i];
                                        lawIndicDetail = _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentDetail[j];
                                        break;
                                      }
                                    }
                                  }

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingData,
                                        child: Text((j + 1).toString() + ". " +
                                            lawIndicDetail
                                                .TITLE_SHORT_NAME_TH +
                                            lawIndicDetail
                                                .FIRST_NAME + " " +
                                          lawIndicDetail
                                                .LAST_NAME,
                                          style: textStyleData,),
                                      ),
                                      LAWSUIT_TYPE == 0
                                          ? Container(
                                        padding: paddingData,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  //
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff3b69f3),
                                                    border: Border.all(
                                                        color: Colors.black12),
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(4.0),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 18,
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: paddingData,
                                              child: Text("เปรียบเทียบ",
                                                style: textStyleSubData,),
                                            )
                                          ],
                                        ),
                                      )
                                          : Container(
                                        child: new InkWell(
                                          child: Card(
                                            shape: new RoundedRectangleBorder(
                                                side: new BorderSide(
                                                    color: Color(0xff087de1),
                                                    width: 1.5),
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    10.0)
                                            ),
                                            elevation: 0.0,
                                            child: Padding(
                                                padding: paddindSentence,
                                                child: Text('คำพิพากษาศาล',
                                                  style: textStyleSentence,)
                                            ),
                                          ),
                                          onTap: () {
                                             _navigateLawsuitAcceptCaseSentence(
                                                      context,  lawDetail,j);
                                          },
                                        ),
                                      ),
                                      _itemsLawsuitArrestMain
                                          .LawsuitArrestIndictmentDetail
                                          .length > 1 && j !=
                                          _itemsLawsuitArrestMain
                                              .LawsuitArrestIndictmentDetail
                                              .length - 1 ?
                                      Container(
                                        padding: paddingData,
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ) : Container(),
                                    ],
                                  );
                                }
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          )
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String title = "";
      String firstname="";
      String lastname="";
      _itemsLawsuitMain.LawsuitStaff.forEach((item){
        title = item.TITLE_SHORT_NAME_TH!=null
            ?item.TITLE_SHORT_NAME_TH
            :item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      String lawsuit_date = "";
      String lawsuit_year = "";
      DateTime dt_lawsuit_date = DateTime.parse(_itemsLawsuitMain.LAWSUIT_DATE);
      DateTime dt_lawsuit_year = DateTime.parse(_itemsLawsuitMain.LAWSUIT_NO_YEAR);
      List splitslawDate = dateFormatDate.format(dt_lawsuit_date).toString().split(
          " ");
      List splitslawYear = dateFormatDate.format(dt_lawsuit_year).toString().split(
          " ");
      lawsuit_date = splitslawDate[0] + " " + splitslawDate[1] + " " +
          (int.parse(splitslawDate[3]) + 543).toString();
      lawsuit_year = (int.parse(splitslawYear[3]) + 543).toString();

      return Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
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
                        child: Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: paddingData,
                            child: Text(
                              _itemsLawsuitMain.LAWSUIT_NO.toString() + '/' +
                                  lawsuit_year,
                              style: textStyleData,),
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
                          "วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          lawsuit_date,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ชื่อผู้รับคดี", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                         title+firstname+" "+lastname, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ลักษณะคดีรายผู้ต้องหา", style: textStyleLabel,),
                      ),
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // new
                            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              EdgeInsets paddingSuspect = EdgeInsets.only(
                                  left: 8.0, top: 4, bottom: 4);
                              int LAWSUIT_TYPE=0;
                              ItemsListReturnDetail lawDetail;
                              for(int i=0;i<_itemsLawsuitMain.LawsuitDetail.length;i++){
                                if(_itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].INDICTMENT_DETAIL_ID ==
                                    _itemsLawsuitMain.LawsuitDetail[i].INDICTMENT_DETAIL_ID){
                                  if(_itemsLawsuitMain.LawsuitDetail[i].LAWSUIT_TYPE==0||
                                      _itemsLawsuitMain.LawsuitDetail[i].LAWSUIT_TYPE==2){
                                    LAWSUIT_TYPE = 1;
                                  }else if(_itemsLawsuitMain.LawsuitDetail[i].LAWSUIT_TYPE==1){
                                    LAWSUIT_TYPE = 0;
                                  }
                                  lawDetail=_itemsLawsuitMain.LawsuitDetail[i];
                                  break;
                                }
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: paddingSuspect,
                                    child: Text((index + 1).toString() + '. ' +
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH+
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].FIRST_NAME+" "+
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].LAST_NAME,
                                      style: textStyleData,),
                                  ),
                                  LAWSUIT_TYPE==0 ? Padding(
                                    padding: paddingSuspect,
                                    child: Text('(' +
                                       "เปรียบเทียบปรับ" + ')',
                                      style: textStyleSub,),
                                  )
                                      : Container(
                                    child: new InkWell(
                                      child: Card(
                                        shape: new RoundedRectangleBorder(
                                            side: new BorderSide(
                                                color: Color(0xff087de1),
                                                width: 1.5),
                                            borderRadius: BorderRadius.circular(
                                                10.0)
                                        ),
                                        elevation: 0.0,
                                        child: Padding(padding: paddindSentence,
                                            child: Text('คำพิพากษาศาล',
                                              style: textStyleSentence,)
                                        ),
                                      ),
                                      onTap: () {
                                        _navigateLawsuitAcceptCaseSentence(
                                            context,  lawDetail,index);
                                      },
                                    ),
                                  )
                                ],
                              );
                            }
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("สถานที่ทำการ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          _itemsLawsuitMain.OFFICE_NAME, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "คำให้การของผู้กล่าวโทษ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          _itemsLawsuitMain.TESTIMONY, style: textStyleData,),
                      ),
                    ],
                  ),
                  _itemsLawsuitMain.IS_OUTSIDE==1?Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton<Constants>(
                      onSelected: choiceAction,
                      icon: Icon(Icons.more_vert, color: Colors.black,),
                      itemBuilder: (BuildContext context) {
                        return constants.map((Constants contants) {
                          return PopupMenuItem<Constants>(
                            value: contants,
                            child: Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    contants.icon, color: Colors.grey[400],),),
                                Padding(padding: EdgeInsets.only(left: 4.0),
                                  child: Text(contants.text,style: TextStyle(fontFamily: FontStyles().FontFamily),),)
                              ],
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ):Container()
                ],
              )
          ),
        ),
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
                    'ILG60_B_02_00_03_00', style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: _onSaved ? _buildContent_saved(context) : _buildContent(
                context),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************

//************************start_tab_2*****************************
  buildCollapsed() {
    String arrest_date = "";
    DateTime dt_occourrence = DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    List splits = dateFormatDate.format(dt_occourrence).toString().split(
        " ");
    arrest_date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_CODE,
            style: textStyleData,),
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
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            arrest_date,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH+
                _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME+" "+
                _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
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
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                      padding: paddingData,
                      child: Text((j + 1).toString() + '. ' +
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH+
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].FIRST_NAME+" "+
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].LAST_NAME,
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
                          Map map={
                            "TEXT_SEARCH" : "",
                            "PERSON_ID" : _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].PERSON_ID
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
            _itemsLawsuitArrestMain.SECTION_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.GUILTBASE_NAME,
            style: textStyleData,),
        ),
      ],
    );
  }
  buildExpanded() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;

    String arrest_date = "";
    DateTime dt_occourrence = DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    List splits = dateFormatDate.format(dt_occourrence).toString().split(
        " ");
    arrest_date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_CODE,
            style: textStyleData,),
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
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            arrest_date,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH+
                _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME+" "+
                _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
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
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
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
                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH+
                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].FIRST_NAME+" "+
                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].LAST_NAME,
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
                          Map map={
                            "TEXT_SEARCH" : "",
                            "PERSON_ID" : _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].PERSON_ID
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
            _itemsLawsuitArrestMain.SUBSECTION_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.GUILTBASE_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("สถานที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_OFFICE_NAME,
            style: textStyleData,),
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
              child: Text("ของกลาง", style: textStyleLabel,),
            ),
            _itemsLawsuitArrestMain
                .LawsuitArrestIndictmentProduct.length==0
                ?Container(
              padding: paddingData,
              child: Text(
                "ไม่มีของกลาง",style: textStyleData,
              ),
            )
                :Container(
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
                                      TabScreenLawsuitProduct(
                                        ItemsProduct:  _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentProduct[index],
                                        IsComplete: true,
                                        Title: _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentProduct[index].PRODUCT_BRAND_NAME_TH,
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
                                        _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentProduct[index]
                                            .PRODUCT_CATEGORY_NAME +
                                        '/' +
                                        _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentProduct[index]
                                            .PRODUCT_TYPE_NAME + '/' +
                                        //_arrestMain.ArrestIndictment[index].ArrestIndictmentProduct[j].PRODUCT_SUBTYPE_NAME + '/' +
                                        _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentProduct[index]
                                            .PRODUCT_BRAND_NAME_TH,
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
        MaterialPageRoute(builder: (context) => TabScreenLawsuitDeatilSuspect(ItemsSuspect: ItemsPreviewIndicmentDetail,)),
      );
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
                        'ILG60_B_02_00_04_00', style: textStylePageName,),
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

//************************end_tab_2*******************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Container(
          padding: EdgeInsets.only(bottom: 0.0),
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
                          bottom: BorderSide(
                              color: Colors.grey[300], width: 1.0),
                        )
                    ),
                    child: ListTile(
                        title: Text((index + 1).toString() + '. ' +
                            itemsFormsTab3[index].FormsName,
                          style: textInputStyleTitle,),
                        trailing: Icon(
                          Icons.arrow_forward_ios, color: Colors.grey[300],),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TabScreenArrest8Dowload(Title: itemsFormsTab3[index].FormsName,),
                              ));
                        }
                    ),
                  ),
                );
              }
          ),
        ),
      );
    }
    //data result when search data
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                      'ILG60_B_02_00_07_00', style: textStylePageName,),
                  )
                ],
              ),*/
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

//************************end_tab_3*******************************

//************************start_tab_proof*****************************
  Widget _buildContent_tab_proof() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text("เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: ((size.width * 75) / 100) / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeProofNumber,
                                      controller: editProofNumber,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                            new Padding(
                              padding: paddingData,
                              child: new Text("/",
                                style: textStyleData,
                              ),
                            ),
                            Container(
                              width: ((size.width * 75) / 100) / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeProofYear,
                                      controller: editProofYear,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "วันที่ออกหนังสือ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DynamicDialog(
                                      Current: _dtDateProof);
                                }).then((s) {
                              String date = "";
                              List splits = dateFormatDate.format(
                                  s).toString().split(" ");
                              date = splits[0] + " " + splits[1] +
                                  " " +
                                  (int.parse(splits[3]) + 543)
                                      .toString();
                              setState(() {
                                _dtDateProof=s;
                                _currentDateProof=date;
                                editProofDate.text = _currentDateProof;
                                _proveDate = _dtDateProof.toString();
                              });
                            });
                          },
                          focusNode: myFocusNodeProofDate,
                          controller: editProofDate,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(FontAwesomeIcons.calendarAlt,color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text("เวลา", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildBottomPicker(
                                  CupertinoDatePicker(
                                    use24hFormat: true,
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: proofTime,
                                    onDateTimeChanged: (
                                        DateTime newDateTime) {
                                      setState(() {
                                        proofTime = newDateTime;
                                        _currentTimeProof = dateFormatTime.format(proofTime)
                                            .toString();
                                        editProofTime.text = _currentTimeProof;

                                        List splitsArrestDate = _dtDateProof.toUtc().toLocal().toString().split(" ");
                                        List splitsArrestTime = proofTime.toString().split(" ");
                                        _proveDate=splitsArrestDate[0].toString()+" "+splitsArrestTime[1].toString();
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          focusNode: myFocusNodeProofTime,
                          controller: editProofTime,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้นำส่งของกลางไปพิสูจน์", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                          },
                          focusNode: myFocusNodeProofPerson,
                          controller: editProofPerson,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               /* _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length>0
                    ?Container(
                  padding: EdgeInsets.only(left:22.0,right: 22.0,top: 12.0,bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text("เลือกของกลางทั้งหมด",
                          style: textInputStyleCheckAll,),
                        padding: EdgeInsets.all(8.0),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCheckAll =
                            !isCheckAll;
                            if (isCheckAll) {
                              _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.forEach((
                                  item) {
                                item.IsCkecked = true;
                              });
                            } else {
                              _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.forEach((
                                  item) {
                                item.IsCkecked = false;
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: isCheckAll
                                ? Color(0xff3b69f3)
                                : Colors.grey[200],
                            border: isCheckAll
                                ? Border.all(color: Color(0xff3b69f3), width: 2)
                                : Border.all(color: Colors.grey[400], width: 2),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: isCheckAll
                                  ? Icon(
                                Icons.check,
                                size: 18.0,
                                color: Colors.white,
                              )
                                  : Container(
                                height: 18.0,
                                width: 18.0,
                                color: Colors.transparent,
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    :Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 0.2, bottom: 0.2),
                            child: Container(
                              padding: EdgeInsets.all(22.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.grey[300],
                                        width: 1.0),
                                    bottom: BorderSide(
                                        color: Colors.grey[300],
                                        width: 1.0),
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                .PRODUCT_CATEGORY_NAME +
                                                _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .PRODUCT_TYPE_NAME + '/' +
                                                _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .PRODUCT_BRAND_NAME_TH +
                                                _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .PRODUCT_MODEL_NAME_TH +
                                                '/' +
                                                _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .QUANTITY.toString() +
                                                ' ' +
                                                _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .QUANTITY_UNIT+
                                                '/'+
                                              _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                              .VOLUMN.toString() +
                                              ' ' +
                                              _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                  .VOLUMN_UNIT,
                                            style: textStyleData,),
                                        ),
                                      ),
                                      Center(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .IsCkecked =
                                                ! _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .IsCkecked;

                                                int count = 0;
                                                _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.forEach((ev){
                                                  if(ev.IsCkecked){
                                                    count++;
                                                  }
                                                });
                                                count== _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length?isCheckAll=true:isCheckAll=false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  2.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color:  _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .IsCkecked
                                                    ? Color(0xff3b69f3)
                                                    : Colors.white,
                                                border: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                    .IsCkecked
                                                    ? Border.all(
                                                    color: Color(
                                                        0xff3b69f3),
                                                    width: 2)
                                                    : Border.all(
                                                    color: Colors
                                                        .grey[400],
                                                    width: 2),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(0.0),
                                                  child: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]
                                                      .IsCkecked
                                                      ? Icon(
                                                    Icons.check,
                                                    size: 18.0,
                                                    color: Colors.white,
                                                  )
                                                      : Container(
                                                    height: 18.0,
                                                    width: 18.0,
                                                    color: Colors
                                                        .transparent,
                                                  )
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )*/
              ],
            ),
          )
      );
    }
    Widget _buildContent_saved(BuildContext context) {
      String delivery_date = "";
      DateTime dt_occourrence = DateTime.parse(_itemsLawsuitMain.DELIVERY_DOC_DATE);
      List splits = dateFormatDate.format(dt_occourrence).toString().split(
          " ");
      delivery_date = splits[0] + " " + splits[1] + " " +
          (int.parse(splits[3]) + 543).toString()+" เวลา ";

      String title = "";
      String firstname="";
      String lastname="";
      _itemsLawsuitMain.LawsuitStaff.forEach((item){
        title = item.TITLE_SHORT_NAME_TH!=null
            ?item.TITLE_SHORT_NAME_TH
            :item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 18.0, bottom: 18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
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
                            child: Text("เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                             _itemsLawsuitMain.DELIVERY_DOC_NO_1 + '/' + _itemsLawsuitMain.DELIVERY_DOC_NO_2,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "วันที่ออกหนังสือ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              delivery_date,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ผู้นำส่งของกลางไปพิสูจน์", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              title+firstname+" "+lastname,
                              style: textStyleData,),
                          ),
                        ],
                      ),
                      _itemsLawsuitMain.IS_OUTSIDE==1?Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton<Constants>(
                          onSelected: choiceAction,
                          icon: Icon(Icons.more_vert, color: Colors.black,),
                          itemBuilder: (BuildContext context) {
                            return constants.map((Constants contants) {
                              return PopupMenuItem<Constants>(
                                value: contants,
                                child: Row(
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        contants.icon, color: Colors.grey[400],),),
                                    Padding(padding: EdgeInsets.only(left: 4.0),
                                      child: Text(contants.text,style: TextStyle(fontFamily: FontStyles().FontFamily)),)
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ):Container()
                    ],
                  )
              ),
              /*Container(
                padding: paddingLabel,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget
                      .itemsCaseInformation.Proof.Evidences.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0.1, bottom: 0.1),
                      child: Container(
                        padding: EdgeInsets.all(22.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              top: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0),
                              bottom: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0),
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: paddingLabel,
                                    child: Text((index+1).toString()+'. '+
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductCategory +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductType + ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .MainBrand +
                                        widget
                                            .itemsCaseInformation
                                            .Evidenses[index]
                                            .ProductModel +
                                        ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .SubProductType +
                                        ' ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .SubSetProductType +
                                        ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .Capacity.toString() +
                                        ' ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductUnit,
                                      style: textStyleData,),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),*/
            ],
          )
        ),
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
                  )
              ),
              /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_02_00_11_00', style: textStylePageName,),
                  )
                ],
              ),*/
            ),
            Expanded(
              child: _onSaved&&widget.itemsReturnMain.IS_PROVE!=0?_buildContent_saved(context):_buildContent(context),
            ),
          ],
        ),
      ),
    );
  }
//************************end_tab_poof*******************************
}
