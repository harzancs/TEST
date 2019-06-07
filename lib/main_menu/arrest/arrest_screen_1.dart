import 'dart:async';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:geocoder/model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_indicment.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_3/tab_screen_arrest_3_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_evidence.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_2.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_location.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_map_custom.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_2/tab_screen_arrest_2_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_3/tab_screen_arrest_3_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_add.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_add.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:location/location.dart' as Locations;
import 'package:flutter/services.dart';
import 'package:async_loader/async_loader.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_7.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker_arrest.dart';

const double _kPickerSheetHeight = 216.0;
class ArrestMainScreenFragment extends StatefulWidget {
  final ItemsListArrestMain ITEMS_ARREST;
  bool IsPreview;
  bool IsUpdate;
  bool IsCreate;
  String ARREST_CODE;
  bool IsArrestCode;
  ItemsListTransection itemsListTransection;
  ItemsPersonInformation ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  List<ItemsListArrest6Section> ItemsGuiltbase;
  ArrestMainScreenFragment({
    Key key,
    @required this.ITEMS_ARREST,
    @required this.IsPreview,
    @required this.IsUpdate,
    @required this.IsCreate,
    @required this.ItemsPerson,
    @required this.itemsTitle,
    @required this.ARREST_CODE,
    @required this.IsArrestCode,
    @required this.itemsListTransection,
    @required this.ItemsGuiltbase,
  }) : super(key: key);
  @override
  _ArrestMainScreenFragmentState createState() => new _ArrestMainScreenFragmentState();
}
class _ArrestMainScreenFragmentState extends State<ArrestMainScreenFragment>  with TickerProviderStateMixin {

  ArrestFuture future = new ArrestFuture();

  final formatter = new NumberFormat("#,###.###");

  //app bar
  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);

  TextStyle textDataTitleStyle = TextStyle(
      fontSize: 18.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(
      fontSize: 14.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyleSub = TextStyle(
      fontSize: 14.0, color: Colors.black54,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textLabelDeleteStyle = TextStyle(
      fontSize: 16.0, color: Colors.red,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSubCont = TextStyle(
      fontSize: 14.0, color: Colors.grey[500],fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);

  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSub = TextStyle(fontSize: 16.0, color: Colors.grey[500],fontFamily: FontStyles().FontFamily);


  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
    color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
    fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);

  //paffing
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingInputBoxSub = EdgeInsets.only(top: 8.0, bottom: 8.0);

  ItemsListArrestMain _arrestMain;
  ItemsListArrestLocation _itemsLocale=null;

  TabController tabController;
  TabPageSelector _tabPageSelector;
  int _currentIndex = 0;
  VoidCallback onChanged;

  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  bool TESTIMONY=false;

  bool IsPlace = false;

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลการจับกุม'),
    Choice(title: 'ใบแจ้งความ'),
    Choice(title: 'ผู้จับกุม/ผู้ร่วมจับกุม'),
    Choice(title: 'ผู้ต้องหา'),
    Choice(title: 'ของกลาง'),
    Choice(title: 'ข้อกล่าวหา'),
    Choice(title: 'พฤติกรรมการจับ'),
  ];


  String _arrestDate;
  String _currentDateArrestTH,_currentDateArrestEN, _currentDateCreateTH,_currentDateCreateEN;
  DateTime _dtArrest, _dtMaxDate, _dtMinDate, _dtCreate;

  //is delete
  List<int> list_delete_lawbreaker=[];
  List<int> list_delete_staff=[];
  List<int> list_delete_product=[];
  List<int> list_delete_indicment=[];
  List<int> list_delete_indicment_delt=[];

  //is add
  List list_add_lawbreaker=[];
  List list_add_staff=[];
  List list_add_product=[];
  List list_add_indicment=[];

  //is update
  List list_update_product=[];
  List list_update_indicment=[];
  List list_update_indicment_pro=[];
  ItemsListArrestLocation list_update_location;

  //on show dialog
  Future<bool> onLoadActionInsAll(Map map) async {
    List<Map> ArrestIndictment=[];
    List<Map> ArrestProduct=[];
    await future.apiRequestInsAll(map).then((onValue) async{
      _itemsInitTab6.forEach((item){
        List<Map> ArrestLawbreaker=[];
        item.ArrestIndictmentDetail.forEach((item){
          ArrestLawbreaker.add({
            "INDICTMENT_DETAIL_ID": "",
            "INDICTMENT_ID": "",
            "LAWBREAKER_ID": onValue.ArrestLawbreaker[item.INDEX].LAWBREAKER_ID,
            "IS_ACTIVE": 1
          });
        });
        //print(ArrestLawbreaker.toString());
        ArrestIndictment.add({
          "INDICTMENT_ID": "",
          "ARREST_ID": onValue.ARREST_ID,
          "GUILTBASE_ID": item.GUILTBASE_ID,
          "FINE_ESTIMATE": "",
          "IS_LAWSUIT_COMPLETE": 0,
          "IS_ACTIVE": 1,
          "ArrestIndictmentDetail": ArrestLawbreaker,
          /*"ArrestIndictmentProduct": ArrestProduct,*/
          "ArrestIndictmentProduct": []
        });
      });
      ItemsArrestResponseIndicment item_indicment;
      await future.apiRequestInsIndictment(ArrestIndictment).then((onValue) {
          print("Indic : "+onValue.Msg);
          item_indicment = onValue;
      });

      for(int i=0;i<_itemsInitTab6.length;i++){
        for(int j=0;j<_itemsInitTab6[i].ArrestIndictmentProduct.length;j++){
          for(int k=0;k<item_indicment.ArrestIndictment[i].ArrestIndictmentDetail.length;k++){
            ArrestProduct.add({
              "PRODUCT_INDICTMENT_ID": "",
              "PRODUCT_ID": onValue.ArrestProduct[_itemsInitTab6[i].ArrestIndictmentProduct[j].INDEX].PRODUCT_ID,
              "INDICTMENT_ID": item_indicment.ArrestIndictment[i].ArrestIndictmentDetail[k].INDICTMENT_DETAIL_ID,
              "SIZES_UNIT_ID": _itemsInitTab6[i].ArrestIndictmentProduct[j].SIZES_UNIT_ID,
              "QUATITY_UNIT_ID": _itemsInitTab6[i].ArrestIndictmentProduct[j].QUATITY_UNIT_ID,
              "VOLUMN_UNIT_ID": _itemsInitTab6[i].ArrestIndictmentProduct[j].VOLUMN_UNIT_ID,
              "SIZES": _itemsInitTab6[i].ArrestIndictmentProduct[j].SIZES,
              "SIZES_UNIT": _itemsInitTab6[i].ArrestIndictmentProduct[j].SIZES_UNIT,
              "QUANTITY": _itemsInitTab6[i].ArrestIndictmentProduct[j].QUANTITY,
              "QUANTITY_UNIT": _itemsInitTab6[i].ArrestIndictmentProduct[j].QUANTITY_UNIT,
              "VOLUMN": _itemsInitTab6[i].ArrestIndictmentProduct[j].VOLUMN,
              "VOLUMN_UNIT": _itemsInitTab6[i].ArrestIndictmentProduct[j].VOLUMN_UNIT,
              "FINE_ESTIMATE": "",
              "IS_ILLEGAL": 1,
              "IS_ACTIVE": 1
            });
          }
        }
      }
      print("ArrestProduct : "+ArrestProduct.length.toString());
      //print(ArrestProduct.toString());
      await future.apiRequestArrestIndictmentProductinsAll(ArrestProduct).then((onValue) {
        print("Indic Product : "+onValue.Msg);
      });

      //add transection codeapiRequestArrestIndictmentDetailinsAll
      if(widget.IsArrestCode){
        Map map_tran_up = {
          "RUNNING_ID": widget.itemsListTransection.RUNNING_ID,
        };
        await new TransectionFuture().apiRequestTransactionRunningupdByCon(map_tran_up).then((onValue) {
          print("Update Transection : "+onValue.Msg);
        });
      }else{
        Map map_tran_ins = {
          "RUNNING_OFFICE_ID": 30,
          "RUNNING_OFFICE_CODE": widget.ItemsPerson.WorkOffCode,
          "RUNNING_TABLE": "OPS_ARREST",
          "RUNNING_PREFIX": "TN"
        };
        print(map_tran_ins.toString());
        await new TransectionFuture().apiRequestTransactionRunninginsAll(map_tran_ins).then((onValue) {
          print("Insert Transection : "+onValue.Msg);
        });
      }

      Map MAP_ARREST_ID = {'ARREST_ID': onValue.ARREST_ID};
      await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
        _arrestMain=onValue;
      });

      widget.IsCreate=false;
      _onSaved = true;
      _onFinish = true;
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);
      _tabPageSelector = new TabPageSelector(controller: tabController);
      tabController.animateTo((choices.length - 1));

      _itemsDataTab8=[];
      _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39"));
      _itemsDataTab8.add(
          ItemsListArrest8("รายละเอียดการกระทำผิดของผู้กระทำผิด"));
    });
    setState(() {});
    return true;
  }
  Future<bool> onLoadActionDelete(Map map) async {
    await future.apiRequestDelete(map).then((onValue) {
      if(onValue.IsSuccess.endsWith("True")&&onValue.Msg.endsWith("Complete")){
        print(onValue.Msg);
      }
    });
    setState(() {});
    return true;
  }


  Future<bool> onLoadActionArrestLawbreakerupdDelete(
      Map map_arrest,
      List<Map> map_del_law,
      List<Map> map_del_indic_detail,
      List<Map> map_del_staff,
      List<Map> map_del_pro,
      List<Map> map_del_indic_product,
      List<Map> map_del_indic_all,
      List<Map> map_upadd_staff,
      List<Map> map_upadd_law,
      List<Map> map_upadd_pro,
      List<Map> map_upadd_indic,
      List<Map> map_up_indic,
      List<Map> map_up_indic_pro,
      List<Map> map_up_indic_delt,
      List<Map> map_up_pro,
      bool IsDelLawbreaker,
      bool IsDelIndicmentDetail,
      bool IsDelStaff,
      bool IsDelProduct,
      bool IsDelIndicmentProduct,
      bool IsDelIndicment,
      bool IsUpAddStaff,
      bool IsUpAddLawbreaker,
      bool IsUpAddProduct,
      bool IsUpAddIndicmen,
      bool IsUpIndicmen,
      bool IsUpIndicmenPro,
      bool IsUpIndicmenDelt,
  bool IsUpProduct) async {
    await future.apiRequestArrestupdByCon(map_arrest).then((onValue) {
      if (onValue.IsSuccess.endsWith("True") &&
          onValue.Msg.endsWith("Complete")) {
        print("Up Arrest : " + onValue.Msg);
        //Navigator.pop(context);
      }
    });

    if (!IsDelLawbreaker) {
      await future.apiRequestArrestLawbreakerupdDelete(map_del_law).then((
          onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Del Lawbreaker : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelIndicmentDetail) {
      await future.apiRequestArrestIndictmentDetailupdDelete(
          map_del_indic_detail).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Del IndicDetail : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelStaff) {
      await future.apiRequestArrestStaffupdDelete(map_del_staff).then((
          onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Del Staff : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelProduct) {
      await future.apiRequestArrestProductupdDelete(map_del_pro).then((
          onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Del Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelIndicmentProduct) {
      await future.apiRequestArrestIndictmentProductupdDelete(
          map_del_indic_product).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Del IndicProduct : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelIndicment) {
      await future.apiRequestArrestIndictmentupdDelete(map_del_indic_all).then((
          onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Del Indictment : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }

    if (!IsUpAddStaff) {
      await future.apiRequestArrestStaffinsAll(map_upadd_staff).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Add Staff : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsUpAddLawbreaker) {
      await future.apiRequestArrestLawbreakerinsAll(map_upadd_law).then((
          onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Add Law : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsUpAddProduct) {
      await future.apiRequestArrestProductinsAll(map_upadd_pro).then((onValue) {
        print("result add pro : "+onValue.IsSuccess.toString());
        print("result add pro : "+onValue.Msg.toString());
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Add Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsUpAddIndicmen) {
      ItemsArrestResponseIndicment item_indicment;
      await future.apiRequestInsIndictment(map_upadd_indic).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Add Indictment : " + onValue.Msg);
          //Navigator.pop(context);
          item_indicment = onValue;
        }
      });
      List<Map> ArrestProduct = [];
      for(int i=0;i<list_add_indicment.length;i++){
        for(int j=0;j<list_add_indicment[i].ArrestIndictmentProduct.length;j++){
          for(int k=0;k<item_indicment.ArrestIndictment[i].ArrestIndictmentDetail.length;k++){
            ArrestProduct.add({
              "PRODUCT_INDICTMENT_ID": "",
              "PRODUCT_ID": _arrestMain.ArrestProduct[list_add_indicment[i].ArrestIndictmentProduct[j].INDEX].PRODUCT_ID,
              "INDICTMENT_ID": item_indicment.ArrestIndictment[i].ArrestIndictmentDetail[k].INDICTMENT_DETAIL_ID,
              "SIZES_UNIT_ID": list_add_indicment[i].ArrestIndictmentProduct[j].SIZES_UNIT_ID,
              "QUATITY_UNIT_ID": list_add_indicment[i].ArrestIndictmentProduct[j].QUATITY_UNIT_ID,
              "VOLUMN_UNIT_ID": list_add_indicment[i].ArrestIndictmentProduct[j].VOLUMN_UNIT_ID,
              "SIZES": list_add_indicment[i].ArrestIndictmentProduct[j].SIZES,
              "SIZES_UNIT": list_add_indicment[i].ArrestIndictmentProduct[j].SIZES_UNIT,
              "QUANTITY": list_add_indicment[i].ArrestIndictmentProduct[j].QUANTITY,
              "QUANTITY_UNIT": list_add_indicment[i].ArrestIndictmentProduct[j].QUANTITY_UNIT,
              "VOLUMN": list_add_indicment[i].ArrestIndictmentProduct[j].VOLUMN,
              "VOLUMN_UNIT": list_add_indicment[i].ArrestIndictmentProduct[j].VOLUMN_UNIT,
              "FINE_ESTIMATE": "",
              "IS_ILLEGAL": 1,
              "IS_ACTIVE": 1
            });
          }
        }
      }
      print("ArrestProduct Upd Arrest : "+ArrestProduct.length.toString());
      //print(ArrestProduct.toString());
      await future.apiRequestArrestIndictmentProductinsAll(ArrestProduct).then((onValue) {
        print("Indic Add Product : "+onValue.Msg);
      });
    }

    if (!IsUpIndicmen) {
      await future.apiRequestArrestIndictmentupdByCon(map_up_indic).then((
          onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Up Indictment : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }

    if (!IsUpIndicmenPro) {
      await future.apiRequestArrestIndictmentProductupdByCon(map_up_indic_pro)
          .then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Up Indictment Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsUpIndicmenDelt) {
      await future.apiRequestArrestIndictmentDetailinsAll(map_up_indic_delt)
          .then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Up Indictment Detail : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsUpProduct) {
      await future.apiRequestArrestProductupdByCon(map_up_pro).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Up Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }


    //load data again
    Map MAP_ARREST_ID = {"ARREST_ID": _arrestMain.ARREST_ID};
    await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
      _arrestMain = onValue;
    });

    list_delete_lawbreaker = [];
    list_delete_staff = [];
    list_delete_product = [];
    list_delete_indicment = [];
    list_delete_indicment_delt = [];
    list_add_lawbreaker = [];
    list_add_staff = [];
    list_add_product = [];
    list_add_indicment = [];
    list_update_product = [];
    list_update_indicment = [];
    list_update_indicment_pro = [];

    //add & go to tab forms
    widget.IsUpdate = false;
    widget.IsCreate = false;
    widget.IsPreview = true;

    _onEdited = false;
    _onSaved = true;
    _onFinish = true;
    choices.add(Choice(title: 'แบบฟอร์ม'));
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
    tabController.animateTo((choices.length - 1));

    _itemsDataTab8 = [];
    _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39"));
    _itemsDataTab8.add(
        ItemsListArrest8("รายละเอียดการกระทำผิดของผู้กระทำผิด"));

    setState(() {});
    return true;
  }
  /*Future<bool> onLoadActionArrestIndictmentDetailupdDelete(List<Map> map) async {
    await future.apiRequestArrestIndictmentDetailupdDelete(map).then((onValue) {
      if(onValue.IsSuccess.endsWith("True")&&onValue.Msg.endsWith("Complete")){
        print("Del IndicDetail : "+onValue.Msg);
        //Navigator.pop(context);
      }
    });
    setState(() {});
    return true;
  }*/
  Location _locationService = new Location();
  @override
  void initState() {
    super.initState();
    _arrestMain = widget.ITEMS_ARREST;
    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    /*****************************initData for tab1**************************/
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    editArrestDate.text = date;
    editArrestDateCreate.text = date;
    _time = dateFormatTime.format(DateTime.now()).toString();
    editArrestTime.text = _time;

    _currentDateArrestTH = date;
    _currentDateCreateTH = date;

    _currentDateArrestEN = DateTime.now().toString();
    _currentDateCreateEN = DateTime.now().toString();

    _arrestDate = DateTime.now().toString();
    _dtArrest = DateTime.now();
    _dtMaxDate = DateTime.now();
    _dtCreate = DateTime.now();
    _dtMinDate = DateTime.now();


    if (widget.IsPreview) {
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;
      _onFinish= widget.IsPreview;

      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);

      _itemsDataTab8=[];
      _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39"));
      _itemsDataTab8.add(
          ItemsListArrest8("รายละเอียดการกระทำผิดของผู้กระทำผิด"));

    }else if(widget.IsCreate){
      _itemsDataTab3.add(widget.ItemsPerson);
      editArrestNumber.text = "Auto Gen";

      initPlatformState();
      /*onChanged = () {
        setState(() {
          _currentIndex = this.tabController.index;
          String textLawsuitBreaker="";
          String Evidence="";
          String Section="";
          if(_currentIndex==6){
            if(_itemsInitTab6.length>0){
              textLawsuitBreaker=" โดยจับกุมตัวผู้ต้องหาจำนวน "+_itemsDataTab4.length.toString()+" คน คือ ";
              Evidence="พร้อมได้ยึดของกลาง ดังนี้ ";
              Section="ในข้อกล่าวหา ";
              _itemsInitTab6.forEach((item){
                item.ItemLawsuitBreaker.forEach((item){
                  textLawsuitBreaker+=item.TITLE_SHORT_NAME_TH+item.FIRST_NAME+" "+item.LAST_NAME+" ";
                });
                item.ItemProduct.forEach((item){
                  Evidence+= item.PRODUCT_CATEGORY_NAME + '/' +
                      item.PRODUCT_TYPE_NAME + '/' +
                      item.PRODUCT_BRAND_NAME_TH +
                      " จำนวน "+item.QUANTITY.toString()+" "+item.QUANTITY_UNIT+
                      " ปริมาณสุทธิ "+item.VOLUMN.toString()+" "+item.VOLUMN_UNIT+", ";
                });
                Section+=item.GUILTBASE_NAME;
              });
            }
            setBehavior(textLawsuitBreaker+Evidence+Section);
          }else{
            setBehavior(textLawsuitBreaker+Evidence+Section);
          }
        });
      };
      tabController.addListener(onChanged);*/
    }else if(widget.IsUpdate){
      _onSaved = widget.IsPreview;
      _onEdited=widget.IsUpdate;


      List<String> list = [];
      list.add(_arrestMain.BEHAVIOR_1);
      list.add(_arrestMain.BEHAVIOR_2);
      list.add(_arrestMain.BEHAVIOR_3);
      list.add(_arrestMain.BEHAVIOR_4);
      list.add(_arrestMain.BEHAVIOR_5);
      String behavior = "";
      list.forEach((string) {
        if (string != null) {
          behavior += string;
        }
      });
      String address="";
      _arrestMain.ArrestLocale.forEach((item){
        print(item.ROAD.isEmpty);
        address = item.ADDRESS_NO+(item.ALLEY.isEmpty?"":" ซอย "+item.ALLEY)
            +(item.ROAD.isEmpty?"":" ถนน "+item.ROAD)
            + " อำเภอ/เขต " +  item.DISTRICT_NAME_TH
            + " ตำบล/แขวง " +
            item.SUB_DISTRICT_NAME_TH + " จังหวัด " +
            item.PROVINCE_NAME_TH;
      });
      //editArrestNumber.text=_arrestMain.ARREST_CODE;
      editArrestNumber.text="Auto Gen";
      editArrestLocation.text=address;
      editArrestPlace.text=_arrestMain.OFFICE_NAME;

      editArrestBehavior.text = behavior;
      TESTIMONY=_arrestMain.IS_REQUEST==1?true:false;
      editNotificationOfRights.text=_arrestMain.IS_REQUEST==1?_arrestMain.REQUEST_DESC:"ได้ดำเนินการตามที่ข้าพเจ้าร้องขอ";
    }

  }
  void setBehavior(text){
    setState(() {
      String name = widget.ItemsPerson.TITLE_SHORT_NAME_TH+widget.ItemsPerson.FIRST_NAME+" "+widget.ItemsPerson.LAST_NAME;
      editArrestBehavior.text="ข้าพเจ้า "+name+" พร้อมด้วยสายตรวจได้ทำการจับกุมในวันที่ "+_currentDateArrestTH+text;
      editNotificationOfRights.text="ได้ดำเนินการตามที่ข้าพเจ้าร้องขอ";
    });
  }

  Map putDataRequest(){
    Map locale;
    List<Map> lawsuitBreaker=new List();
    List<Map> staff=new List();
    List<Map> product=new List();
    List<Map> productMapping=new List();

    _itemsDataTab3.forEach((f){
      staff.add({
        "STAFF_ID": "",
        "ARREST_ID": "",
        "STAFF_REF_ID": f.STAFF_ID,
        "TITLE_ID": "1",
        "STAFF_CODE": "56050337",
        "ID_CARD": "1539475630947",
        "STAFF_TYPE": 1,
        "TITLE_NAME_TH": f.TITLE_SHORT_NAME_TH,
        "TITLE_NAME_EN": "Mister",
        "TITLE_SHORT_NAME_TH": f.TITLE_SHORT_NAME_TH,
        "FIRST_NAME": f.FIRST_NAME,
        "LAST_NAME": f.LAST_NAME,
        "AGE": 24,
        "OPERATION_POS_CODE": "18",
        "OPREATION_POS_NAME": f.OPREATION_POS_NAME,
        "OPREATION_POS_LEVEL": "",
        "OPERATION_POS_LEVEL_NAME": f.OPREATION_POS_LAVEL_NAME,
        "OPERATION_DEPT_CODE": "",
        "OPERATION_DEPT_NAME": "",
        "OPERATION_DEPT_LEVEL": "",
        "OPERATION_UNDER_DEPT_CODE": "",
        "OPERATION_UNDER_DEPT_NAME": "",
        "OPERATION_UNDER_DEPT_LEVEL": "",
        "OPERATION_WORK_DEPT_CODE": "",
        "OPERATION_WORK_DEPT_NAME": "",
        "OPERATION_WORK_DEPT_LEVEL": "",
        "OPERATION_OFFICE_CODE": "",
        "OPERATION_OFFICE_NAME": f.OPERATION_OFFICE_NAME,
        "OPERATION_OFFICE_SHORT_NAME": f.OPERATION_OFFICE_SHORT_NAME==null?"":f.OPERATION_OFFICE_SHORT_NAME,
        "MANAGEMENT_POS_CODE": "",
        "MANAGEMENT_POS_NAME": "",
        "MANAGEMENT_POS_LEVEL": "",
        "MANAGEMENT_POS_LEVEL_NAME": "",
        "MANAGEMENT_DEPT_CODE": "",
        "MANAGEMENT_DEPT_NAME": "",
        "MANAGEMENT_DEPT_LEVEL": "",
        "MANAGEMENT_UNDER_DEPT_CODE": "",
        "MANAGEMENT_UNDER_DEPT_NAME": "",
        "MANAGEMENT_UNDER_DEPT_LEVEL": "",
        "MANAGEMENT_WORK_DEPT_CODE": "",
        "MANAGEMENT_WORK_DEPT_NAME": "",
        "MANAGEMENT_WORK_DEPT_LEVEL": "",
        "MANAGEMENT_OFFICE_CODE": "",
        "MANAGEMENT_OFFICE_NAME": "",
        "MANAGEMENT_OFFICE_SHORT_NAME": "",
        "REPRESENTATION_POS_CODE": "",
        "REPRESENTATION_POS_NAME": "",
        "REPRESENTATION_POS_LEVEL": "",
        "REPRESENTATION_POS_LEVEL_NAME": "",
        "REPRESENTATION_DEPT_CODE": "",
        "REPRESENTATION_DEPT_NAME": "",
        "REPRESENTATION_DEPT_LEVEL": "",
        "REPRESENTATION_UNDER_DEPT_CODE": "",
        "REPRESENTATION_UNDER_DEPT_NAME": "",
        "REPRESENTATION_UNDER_DEPT_LEVEL": "",
        "REPRESENT_WORK_DEPT_CODE": "",
        "REPRESENT_WORK_DEPT_NAME": "",
        "REPRESENT_WORK_DEPT_LEVEL": "",
        "REPRESENT_OFFICE_CODE": "",
        "REPRESENT_OFFICE_NAME": "",
        "REPRESENT_OFFICE_SHORT_NAME": "",
        "STATUS": 1,
        "REMARK": "",
        "CONTRIBUTOR_ID": f.ArrestType=="ผู้จับกุม"?14:15,
        "IS_ACTIVE": 1
      });
    });

    //ที่อยู่
    locale = {
      "LOCALE_ID": "",
      "ARREST_ID": "",
      "SUB_DISTRICT_ID": _itemsLocale.SUB_DISTICT.SUB_DISTRICT_ID,
      "GPS": _itemsLocale.GPS,
      "ADDRESS_NO": _itemsLocale.ADDRESS_NO,
      "VILLAGE_NO": "",
      "BUILDING_NAME": "",
      "ROOM_NO": "",
      "ALLEY": _itemsLocale.ALLEY,
      "FLOOR": "",
      "VILLAGE_NAME": "",
      "LANE": "",
      "ROAD": _itemsLocale.ROAD,
      "ADDRESS_TYPE": 4,
      "ADDRESS_STATUS": 0,
      "POLICE_STATION": "",
      "LOCATION": "",
      "IS_ACTIVE": 1
    };

    //ผู้ต้องหา
    _itemsDataTab4.forEach((item){
      lawsuitBreaker.add({
        "LAWBREAKER_ID": "",
        "ARREST_ID": "",
        "PERSON_ID": item.PERSON_ID,
        "TITLE_ID": item.TITLE_ID,
        "PERSON_TYPE": item.PERSON_TYPE,
        "ENTITY_TYPE": item.ENTITY_TYPE,
        "TITLE_NAME_TH": item.TITLE_NAME_TH,
        "TITLE_NAME_EN": item.TITLE_NAME_EN,
        "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
        "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
        "FIRST_NAME": item.FIRST_NAME,
        "MIDDLE_NAME": item.MIDDLE_NAME,
        "LAST_NAME": item.LAST_NAME,
        "OTHER_NAME": item.OTHER_NAME,
        "COMPANY_NAME": "",
        "COMPANY_REGISTRATION_NO": "",
        "EXCISE_REGISTRATION_NO": "",
        "ID_CARD": item.ID_CARD,
        "AGE": item.AGE,
        "PASSPORT_NO": item.PASSPORT_NO,
        "CAREER": "",
        "PERSON_DESC": "",
        "EMAIL": "",
        "TEL_NO": "",
        "MISTREAT_NO": item.MISTREAT_NO,
        "IS_ACTIVE": 1
      });
    });
    //ของกลาง
    _itemsDataTab5.forEach((item){
      productMapping.add(
          {
            "PRODUCT_ID": "",
            "ARREST_ID": "",
            "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
            "PRODUCT_CODE": item.PRODUCT_CODE,
            "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
            "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
            "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
            "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
            "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
            "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
            "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
            "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
            "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
            "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
            "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
            "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
            "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
            "PRODUCT_GROUP_CODE": "",
            "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME!=null?item.PRODUCT_GROUP_NAME:"",
            "PRODUCT_CATEGORY_CODE": "",
            "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME!=null?item.PRODUCT_CATEGORY_NAME:"",
            "PRODUCT_TYPE_CODE": "",
            "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME!=null?item.PRODUCT_TYPE_NAME:"",
            "PRODUCT_SUBTYPE_CODE": "",
            "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME!=null?item.PRODUCT_SUBTYPE_NAME:"",
            "PRODUCT_SUBSETTYPE_CODE": "",
            "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME!=null?item.PRODUCT_SUBSETTYPE_NAME:"",
            "PRODUCT_BRAND_CODE": "",
            "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:"",
            "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN!=null?item.PRODUCT_BRAND_NAME_EN:"",
            "PRODUCT_SUBBRAND_CODE": "",
            "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH!=null?item.PRODUCT_SUBBRAND_NAME_TH:"",
            "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN!=null?item.PRODUCT_SUBBRAND_NAME_EN:"",
            "PRODUCT_MODEL_CODE": "",
            "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH!=null?item.PRODUCT_MODEL_NAME_TH:"",
            "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN!=null?item.PRODUCT_MODEL_NAME_EN:"",
            "IS_TAX_VALUE": 1,
            "TAX_VALUE": "",
            "IS_TAX_VOLUMN": 1,
            "TAX_VOLUMN": "",
            "TAX_VOLUMN_UNIT": "",
            "LICENSE_PLATE": "",
            "ENGINE_NO": "",
            "CHASSIS_NO": "",
            "PRODUCT_DESC": (item.PRODUCT_GROUP_NAME != null
                ? (item.PRODUCT_GROUP_NAME
                .toString() + ' ')
                : '') +
                (item.PRODUCT_CATEGORY_NAME != null
                    ? (item.PRODUCT_CATEGORY_NAME
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_TYPE_NAME != null
                    ? (item.PRODUCT_TYPE_NAME
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_BRAND_NAME_TH != null
                    ? (item.PRODUCT_BRAND_NAME_TH
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_BRAND_NAME_EN != null
                    ? (item.PRODUCT_BRAND_NAME_EN
                    .toString() + ' ')
                    : '') +

                (item.PRODUCT_SUBBRAND_NAME_TH != null
                    ? (item.PRODUCT_SUBBRAND_NAME_TH
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_SUBBRAND_NAME_EN != null
                    ? (item.PRODUCT_SUBBRAND_NAME_EN
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_MODEL_NAME_TH != null
                    ? (item.PRODUCT_MODEL_NAME_TH
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_MODEL_NAME_EN != null
                    ? (item.PRODUCT_MODEL_NAME_EN
                    .toString() + ' ')
                    : '') +
                (item.DEGREE != null
                    ? (item.DEGREE.toString() +
                    ' ดีกรี ')
                    : ' ') +
                item.SIZES.toString() + ' ' +
                item.SIZES_UNIT.toString(),
            "SUGAR": item.SUGAR,
            "CO2": item.CO2,
            "DEGREE": item.DEGREE,
            "PRICE": item.PRICE,
            "SIZES": item.SIZES,
            "SIZES_UNIT": item.SIZES_UNIT,
            "QUANTITY": item.QUANTITY,
            "QUANTITY_UNIT": item.QUANTITY_UNIT,
            "VOLUMN": item.VOLUMN,
            "VOLUMN_UNIT": item.VOLUMN_UNIT,
            "REMARK": "",
            "IS_DOMESTIC": 1,
            "IS_ILLEGAL": 1,
            "IS_ACTIVE": 1,
          }
      );
    });

    //ของกลาง
    _itemsDataTab5.forEach((item){
      product.add({
        "PRODUCT_ID": "",
        "ARREST_ID": "",
        "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
        "PRODUCT_CODE": item.PRODUCT_CODE,
        "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
        "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
        "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
        "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
        "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
        "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
        "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
        "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
        "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
        "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
        "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
        "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
        "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
        "PRODUCT_GROUP_CODE": "",
        "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME!=null?item.PRODUCT_GROUP_NAME:"",
        "PRODUCT_CATEGORY_CODE": "",
        "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME!=null?item.PRODUCT_CATEGORY_NAME:"",
        "PRODUCT_TYPE_CODE": "",
        "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME!=null?item.PRODUCT_TYPE_NAME:"",
        "PRODUCT_SUBTYPE_CODE": "",
        "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME!=null?item.PRODUCT_SUBTYPE_NAME:"",
        "PRODUCT_SUBSETTYPE_CODE": "",
        "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME!=null?item.PRODUCT_SUBSETTYPE_NAME:"",
        "PRODUCT_BRAND_CODE": "",
        "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:"",
        "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN!=null?item.PRODUCT_BRAND_NAME_EN:"",
        "PRODUCT_SUBBRAND_CODE": "",
        "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH!=null?item.PRODUCT_SUBBRAND_NAME_TH:"",
        "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN!=null?item.PRODUCT_SUBBRAND_NAME_EN:"",
        "PRODUCT_MODEL_CODE": "",
        "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH!=null?item.PRODUCT_MODEL_NAME_TH:"",
        "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN!=null?item.PRODUCT_MODEL_NAME_EN:"",
        "IS_TAX_VALUE": 1,
        "TAX_VALUE": "",
        "IS_TAX_VOLUMN": 1,
        "TAX_VOLUMN": "",
        "TAX_VOLUMN_UNIT": "",
        "LICENSE_PLATE": "",
        "ENGINE_NO": "",
        "CHASSIS_NO": "",
        "PRODUCT_DESC": (item.PRODUCT_GROUP_NAME != null
            ? (item.PRODUCT_GROUP_NAME
            .toString() + ' ')
            : '') +
            (item.PRODUCT_CATEGORY_NAME != null
                ? (item.PRODUCT_CATEGORY_NAME
                .toString() + ' ')
                : '') +
            (item.PRODUCT_TYPE_NAME != null
                ? (item.PRODUCT_TYPE_NAME
                .toString() + ' ')
                : '') +
            (item.PRODUCT_BRAND_NAME_TH != null
                ? (item.PRODUCT_BRAND_NAME_TH
                .toString() + ' ')
                : '') +
            (item.PRODUCT_BRAND_NAME_EN != null
                ? (item.PRODUCT_BRAND_NAME_EN
                .toString() + ' ')
                : '') +

            (item.PRODUCT_SUBBRAND_NAME_TH != null
                ? (item.PRODUCT_SUBBRAND_NAME_TH
                .toString() + ' ')
                : '') +
            (item.PRODUCT_SUBBRAND_NAME_EN != null
                ? (item.PRODUCT_SUBBRAND_NAME_EN
                .toString() + ' ')
                : '') +
            (item.PRODUCT_MODEL_NAME_TH != null
                ? (item.PRODUCT_MODEL_NAME_TH
                .toString() + ' ')
                : '') +
            (item.PRODUCT_MODEL_NAME_EN != null
                ? (item.PRODUCT_MODEL_NAME_EN
                .toString() + ' ')
                : '') +
            (item.DEGREE != null
                ? (item.DEGREE.toString() +
                ' ดีกรี ')
                : ' ') +
            item.SIZES.toString() + ' ' +
            item.SIZES_UNIT.toString(),
        "SUGAR": item.SUGAR,
        "CO2": item.CO2,
        "DEGREE": item.DEGREE,
        "PRICE": item.PRICE,
        "SIZES": item.SIZES,
        "SIZES_UNIT": item.SIZES_UNIT,
        "QUANTITY": item.QUANTITY,
        "QUANTITY_UNIT": item.QUANTITY_UNIT,
        "VOLUMN": item.VOLUMN,
        "VOLUMN_UNIT": item.VOLUMN_UNIT,
        "REMARK": "",
        "IS_DOMESTIC": 1,
        "IS_ILLEGAL": 1,
        "IS_ACTIVE": 1,
        "ArrestProductMapping":productMapping
      });
    });


    Map map_arrest = {
      "ARREST_ID": "",
      "OFFICE_ID": 13,
      "ARREST_CODE": widget.ARREST_CODE,
      "OFFICE_CODE": widget.ItemsPerson.WorkOffCode,
      "OFFICE_NAME": editArrestPlace.text,
      "ARREST_DATE": _arrestDate,
      "OCCURRENCE_DATE": _dtCreate.toString(),
      "BEHAVIOR_1": editArrestBehavior.text,
      "BEHAVIOR_2": "",
      "BEHAVIOR_3": "",
      "BEHAVIOR_4": "",
      "BEHAVIOR_5": "",
      "TESTIMONY": "",
      "IS_REQUEST": TESTIMONY?1:0,
      "REQUEST_DESC": TESTIMONY?editNotificationOfRights.text:"",
      "IS_LAWSUIT_COMPLETE": 0,
      "IS_ACTIVE": 1,
      "CREATE_DATE": DateTime.now().toString(),
      "CREATE_USER_ACCOUNT_ID": 13,
      "UPDATE_DATE": "",
      "UPDATE_USER_ACCOUNT_ID": 0,
      "ArrestStaff":staff,
      "ArrestLocale":[
        locale
      ],
      "ArrestLawbreaker":lawsuitBreaker,
      "ArrestProduct":product
    };

    /*print("staff "+staff.toString());
    print("locale "+locale.toString());
    print("lawsuitBreaker "+lawsuitBreaker.toString());
    print("product "+product.toString());
    print("map_arrest "+map_arrest.toString());*/

    return map_arrest;
  }
  /*****************************view tab1**************************/
  //node focus
  final FocusNode myFocusNodeArrestNumber = FocusNode();
  final FocusNode myFocusNodeArrestDate = FocusNode();
  final FocusNode myFocusNodeArrestTime = FocusNode();
  final FocusNode myFocusNodeArrestLocation = FocusNode();
  final FocusNode myFocusNodeArrestDateCreate = FocusNode();
  final FocusNode myFocusNodeArrestPlace = FocusNode();

  //textfield
  TextEditingController editArrestNumber = new TextEditingController();
  TextEditingController editArrestDate = new TextEditingController();
  TextEditingController editArrestTime = new TextEditingController();
  TextEditingController editArrestLocation = new TextEditingController();
  TextEditingController editArrestDateCreate = new TextEditingController();
  TextEditingController editArrestPlace = new TextEditingController();

  //date
  var dateFormatDate, dateFormatTime;
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  //location
  Locations.LocationData _startLocation;
  Locations.LocationData _currentLocation;
  StreamSubscription<Locations.LocationData> _locationSubscription;
  Locations.Location _location = new Locations.Location();
  bool _permission = false;
  String error;
  String placeAddress = "";

  //time
  DateTime time = DateTime.now();
  String _time;

  /**************************list model*******************************/
  List<ItemsList> _itemsDataTab2 = [];
  //List<ItemsPersonInformation> _itemsDataTab3 = [];
  List _itemsDataTab3 = [];
  List _itemsDataTab4 = [];
  List _itemsDataTab5 = [];
  List<ItemsListArrest7> _itemsDataTab7 = [];
  List<ItemsListArrest8> _itemsDataTab8 = [];

  /**********************Droupdown View *****************************/


  /************************view tab 6*******************************/
  bool IsSelected_tab6 = false;
  final FocusNode myFocusNodeSearchTab6 = FocusNode();
  List _itemsInitTab6 = [];

  /*****************************view tab 7**************************/
  final FocusNode myFocusNodeArrestBehavior = FocusNode();
  final FocusNode myFocusNodeNotificationOfRights = FocusNode();

  TextEditingController editArrestBehavior = new TextEditingController();
  TextEditingController editNotificationOfRights = new TextEditingController();


  @override
  void dispose() {
    super.dispose();
    /*****************************dispose focus tab 1**************************/
    myFocusNodeArrestNumber.dispose();
    myFocusNodeArrestDate.dispose();
    myFocusNodeArrestTime.dispose();
    myFocusNodeArrestLocation.dispose();
    myFocusNodeArrestDateCreate.dispose();
    myFocusNodeArrestPlace.dispose();
    editArrestDate.dispose();
    /*****************************dispose focus tab 6**************************/
    myFocusNodeSearchTab6.dispose();
    /*****************************dispose focus tab 7**************************/
    myFocusNodeArrestBehavior.dispose();
    myFocusNodeNotificationOfRights.dispose();
  }

  /*****************************method for main tab**************************/
  void whenAnimationTab()async{
    tabController.animateTo((0));
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
    /*onChanged = () {
        setState(() {
          _currentIndex = this.tabController.index;
          if(_currentIndex==0){
            //choices.removeAt(choices.length-1);
          }
        });
      };
      tabController.addListener(onChanged);*/
    choices.removeAt(choices.length-1);
  }
  void choiceAction(Constants constants) async{
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _currentIndex=0;
        _onEdited=true;
        _onSaved = false;
        _onFinish=false;
        widget.IsPreview=false;
        widget.IsCreate=false;
        widget.IsCreate=false;
        widget.IsUpdate=true;

       whenAnimationTab();

        List<String> list = [];
        list.add(_arrestMain.BEHAVIOR_1);
        list.add(_arrestMain.BEHAVIOR_2);
        list.add(_arrestMain.BEHAVIOR_3);
        list.add(_arrestMain.BEHAVIOR_4);
        list.add(_arrestMain.BEHAVIOR_5);
        String behavior = "";
        list.forEach((string) {
          if (string != null) {
            behavior += string;
          }
        });
        String address="";
        _arrestMain.ArrestLocale.forEach((item){
          address = item.ADDRESS_NO+(item.ALLEY!=null?(" ซอย "+item.ALLEY):"")
              +(item.ROAD!=null?(" ถนน "+item.ROAD):"")
              + " อำเภอ/เขต " +  item.DISTRICT_NAME_TH
              + " ตำบล/แขวง " +
              item.SUB_DISTRICT_NAME_TH + " จังหวัด " +
              item.PROVINCE_NAME_TH;
        });
        editArrestNumber.text=_arrestMain.ARREST_CODE;
        editArrestLocation.text=address;
        editArrestPlace.text=_arrestMain.OFFICE_NAME;

       editArrestBehavior.text = behavior;
        TESTIMONY=_arrestMain.IS_REQUEST==1?true:false;
       editNotificationOfRights.text=_arrestMain.IS_REQUEST==1?_arrestMain.REQUEST_DESC:"ได้ดำเนินการตามที่ข้าพเจ้าร้องขอ";

      } else {
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
                Navigator.pop(context);
                setState(() {
                  onDelete();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
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
  CupertinoAlertDialog _createCupertinoDeleteItemsDialog(index,String type) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการลบข้อมูล.",
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
                  if(type.endsWith("Staff")){
                    _itemsDataTab3.removeAt(index);
                  }else if(type.endsWith("Person")){
                    _itemsDataTab4.removeAt(index);
                  }else if(type.endsWith("Product")){
                    _itemsDataTab5.removeAt(index);
                  }else if(type.endsWith("Indicment")){
                    _itemsInitTab6.removeAt(index);
                  }else if(type.endsWith("PersonUp")){
                    list_delete_lawbreaker.add(_arrestMain.ArrestLawbreaker[index].LAWBREAKER_ID);
                    _arrestMain.ArrestLawbreaker.removeAt(
                        index);
                  }else if(type.endsWith("StaffUp")){
                    list_delete_staff.add(_arrestMain.ArrestStaff[index].STAFF_ID);
                    _arrestMain.ArrestStaff.removeAt(
                        index);
                  }else if(type.endsWith("ProductUp")){
                    list_delete_product.add(_arrestMain.ArrestProduct[index].PRODUCT_ID);
                    _arrestMain.ArrestProduct.removeAt(index);
                  }else if(type.endsWith("IndicmentUp")){
                    list_delete_indicment.add(_arrestMain.ArrestIndictment[index].INDICTMENT_ID);
                    _arrestMain.ArrestIndictment.removeAt(index);
                  }else if(type.endsWith("Notice")){
                    _itemsDataTab2.removeAt(index);
                  }

                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showDeleteItemsAlertDialog(index,String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteItemsDialog(index,type);
      },
    );
  }

  /*****************************method for main tab1**************************/
  void clearTextField() {
    editArrestNumber.clear();
    editArrestDate.clear();
    editArrestTime.clear();
    editArrestLocation.clear();
    editArrestDateCreate.clear();
    editArrestPlace.clear();
  }

  String _placeName = "",
      _addressno = "",
      _province = "",
      _distict = "",
      _sub_distinct = "",
      _alley = "",
      _gps = "",
      _road="";
  ItemsMasterProvinceResponse ItemProvince;
  ItemsMasterDistictResponse ItemDistrict;
  ItemsMasterSubDistictResponse ItemSubDistrict;

  ItemsListSubDistict sSubDistrict;
  ItemsListDistict sDistrict;
  ItemsListProvince sProvince;

  void getPlaceAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);

    var place = addresses.first;
    placeAddress = place.addressLine;

    _placeName = place.featureName + " " + place.thoroughfare;
    _addressno = place.subThoroughfare;
    _province = place.adminArea;
    _gps = place.coordinates.latitude.toString() + "," +
        coordinates.longitude.toString();

    placeAddress = place.addressLine;

    /*print("featureName " + place.featureName);
    print("adminArea " + place.adminArea);
    print("subLocality " + place.subLocality.toString());
    print("locality " + place.locality.toString());
    print("subAdminArea " + place.subAdminArea.toString());
    print("coordinates " + place.coordinates.toString());
    print("thoroughfare " + place.thoroughfare.toString());
    print("subThoroughfare " + place.subThoroughfare.toString());
    print("postalCode " + place.postalCode.toString());
    print("addressLine "+place.addressLine.toString());
    print("countryCode "+place.countryCode.toString());
    print("countryName "+place.countryName.toString());*/

    if (place.subLocality.contains("เขต")) {
      List splits = place.subLocality.split(" ");
      _distict = place.subLocality.replaceAll("เขต", "").trim();
      //_distict = splits[1];
    }
    List addressLine = place.addressLine.split(" ");
    for (int i = 0; i < addressLine.length; i++) {
      if (addressLine[i].toString().endsWith("ซอย")) {
        _alley = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("ถนน")) {
        _road = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("แขวง")) {
        _sub_distinct = addressLine[i + 1];
      }
    }

    _onSelectCountry(1);


    setState(() {});
  }

  initPlatformState() async {
    Locations.LocationData location;
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
        'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }
    setState(() {
      _startLocation = location;
      getPlaceAddress(location.latitude,location.longitude);
    });
  }

  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      locale: Locale('th', 'TH'),
      firstDate: DateTime(2018),
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),

    );
  }

  _navigateMap(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest1MapCustom(itemsLocale: _itemsLocale,)),
    );
    //_itemsLocale = result;
    //String address = _itemsLocale.ADDRESS_NO+""+_itemsLocale.ROAD;
    if(result.toString()!="Back"){
      if(_onEdited){
        list_update_location = result;
        String address = list_update_location.ADDRESS_NO+(_itemsLocale.ALLEY.isEmpty?"":" ซอย "+_itemsLocale.ALLEY)
            +(_itemsLocale.ROAD.isEmpty?"":" ถนน "+_itemsLocale.ROAD)
            + " อำเภอ/เขต " +  list_update_location.DISTICT.DISTRICT_NAME_TH
            + " ตำบล/แขวง " +
            list_update_location.SUB_DISTICT.SUB_DISTRICT_NAME_TH + " จังหวัด " +
            list_update_location.PROVINCE.PROVINCE_NAME_TH+" "+
            list_update_location.Other;
        editArrestLocation.text = address;
      }else{
        _itemsLocale =result;
        String address = _itemsLocale.ADDRESS_NO+(_itemsLocale.ALLEY.isEmpty?"":" ซอย "+_itemsLocale.ALLEY)
            +(_itemsLocale.ROAD.isEmpty?"":" ถนน "+_itemsLocale.ROAD)
            + " อำเภอ/เขต " +  _itemsLocale.DISTICT.DISTRICT_NAME_TH
            + " ตำบล/แขวง " +
            _itemsLocale.SUB_DISTICT.SUB_DISTRICT_NAME_TH + " จังหวัด " +
            _itemsLocale.PROVINCE.PROVINCE_NAME_TH+" "+
            _itemsLocale.Other;
        editArrestLocation.text = address;
        if(_itemsLocale.IsPlace){
          editArrestPlace.text = address;
        }
      }
    }
  }

  //test async
  getMessage() async {
    return new Future.delayed(Duration(seconds: 3), () {
      print('finish');
    });
  }

  void onDelete() async{
    Map map={"ARREST_ID":_arrestMain.ARREST_ID};
    await onLoadActionDelete(map);
    Navigator.pop(context);
   /* _onSaved = false;
    _onEdited = false;
    _onSave = false;
    clearTextField();
    choices.removeAt(7);*/
  }
  void onSaved(mContext) async {
    //if (widget.IsCreate == true && widget.IsUpdate == false)
    print(_onEdited);
    if ((_onEdited
        ? _arrestMain.ArrestIndictment.length
        : _itemsInitTab6
        .length) == 0) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณาเพิ่มข้อมูลส่วนข้อกล่าวหา');
    }
    else if (editArrestLocation.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณาเพิ่มสถานที่เกิดเหตุ');
    } else if (editArrestPlace.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณาเพิ่มสถานที่เขียน');
    }
    else {
      //request
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(
              ),
            );
          });
      if (_onEdited) {
        List<Map> map_del_staff_id = [];
        List<Map> map_del_law_id = [];
        List<Map> map_del_pro_id = [];
        List<Map> map_del_indic_id = [];
        List<Map> map_del_indic_detail_id = [];
        List<Map> map_del_indic_product_id = [];
        List<Map> map_up_staff = [];
        List<Map> map_upadd_lawbreaker = [];
        List<Map> map_upadd_product = [];
        List<Map> map_upadd_indicment = [];
        List<Map> map_up_indicment = [];
        List<Map> map_up_indicment_delt = [];
        List<Map> map_up_indicment_pro = [];
        List<Map> map_up_product = [];
        if (list_delete_lawbreaker.length > 0 ||
            list_delete_staff.length > 0 ||
            list_delete_product.length > 0 ||
            list_delete_indicment.length > 0 ||
            list_add_staff.length > 0 ||
            list_add_lawbreaker.length > 0 ||
            list_add_product.length > 0 ||
            list_add_indicment.length > 0 ||
            list_update_indicment.length > 0 ||
            list_update_product != null ||
            list_delete_indicment_delt.length > 0
        ) {
          //**************************Delete*********************************

          list_delete_lawbreaker.forEach((item) {
            _arrestMain.ArrestIndictment.forEach((indic) {
              indic.ArrestIndictmentDetail.forEach((indicDetail) {
                if (item == indicDetail.LAWBREAKER_ID) {
                  map_del_indic_detail_id.add({
                    "INDICTMENT_DETAIL_ID": indicDetail.INDICTMENT_DETAIL_ID
                  });
                }
              });
            });
            map_del_law_id.add({
              "LAWBREAKER_ID": item
            });
          });
          list_delete_staff.forEach((item) {
            map_del_staff_id.add({
              "STAFF_ID": item
            });
          });

          list_delete_product.forEach((item) {
            _arrestMain.ArrestIndictment.forEach((indic) {
              indic.ArrestIndictmentProduct.forEach((indicProduct) {
                if (item == indicProduct.PRODUCT_ID) {
                  map_del_indic_product_id.add({
                    "PRODUCT_INDICTMENT_ID": indicProduct.PRODUCT_INDICTMENT_ID
                  });
                }
              });
              map_del_pro_id.add({
                "PRODUCT_ID": item
              });
            });
          });
          list_delete_indicment.forEach((item) {
            map_del_indic_id.add({
              "INDICTMENT_ID": item
            });
          });

          //**************************Update*********************************
          list_add_staff.forEach((f) {
            map_up_staff.add({
              "STAFF_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
              "STAFF_REF_ID": f.STAFF_ID,
              "TITLE_ID": "1",
              "STAFF_CODE": "",
              "ID_CARD": f.ID_CARD,
              "STAFF_TYPE": 1,
              "TITLE_NAME_TH": f.TITLE_SHORT_NAME_TH,
              "TITLE_NAME_EN": "Mister",
              "TITLE_SHORT_NAME_TH": f.TITLE_SHORT_NAME_TH,
              "FIRST_NAME": f.FIRST_NAME,
              "LAST_NAME": f.LAST_NAME,
              "AGE": 24,
              "OPERATION_POS_CODE": "",
              "OPREATION_POS_NAME": f.OPREATION_POS_NAME,
              "OPREATION_POS_LEVEL": "",
              "OPERATION_POS_LEVEL_NAME": f.OPREATION_POS_LAVEL_NAME,
              "OPERATION_DEPT_CODE": "",
              "OPERATION_DEPT_NAME": "",
              "OPERATION_DEPT_LEVEL": "",
              "OPERATION_UNDER_DEPT_CODE": "",
              "OPERATION_UNDER_DEPT_NAME": "",
              "OPERATION_UNDER_DEPT_LEVEL": "",
              "OPERATION_WORK_DEPT_CODE": "",
              "OPERATION_WORK_DEPT_NAME": "",
              "OPERATION_WORK_DEPT_LEVEL": "",
              "OPERATION_OFFICE_CODE": "",
              "OPERATION_OFFICE_NAME": f.OPERATION_OFFICE_NAME,
              "OPERATION_OFFICE_SHORT_NAME": f.OPERATION_OFFICE_SHORT_NAME==null?"":f.OPERATION_OFFICE_SHORT_NAME,
              "MANAGEMENT_POS_CODE": "",
              "MANAGEMENT_POS_NAME": "",
              "MANAGEMENT_POS_LEVEL": "",
              "MANAGEMENT_POS_LEVEL_NAME": "",
              "MANAGEMENT_DEPT_CODE": "",
              "MANAGEMENT_DEPT_NAME": "",
              "MANAGEMENT_DEPT_LEVEL": "",
              "MANAGEMENT_UNDER_DEPT_CODE": "",
              "MANAGEMENT_UNDER_DEPT_NAME": "",
              "MANAGEMENT_UNDER_DEPT_LEVEL": "",
              "MANAGEMENT_WORK_DEPT_CODE": "",
              "MANAGEMENT_WORK_DEPT_NAME": "",
              "MANAGEMENT_WORK_DEPT_LEVEL": "",
              "MANAGEMENT_OFFICE_CODE": "",
              "MANAGEMENT_OFFICE_NAME": "",
              "MANAGEMENT_OFFICE_SHORT_NAME": "",
              "REPRESENTATION_POS_CODE": "",
              "REPRESENTATION_POS_NAME": "",
              "REPRESENTATION_POS_LEVEL": "",
              "REPRESENTATION_POS_LEVEL_NAME": "",
              "REPRESENTATION_DEPT_CODE": "",
              "REPRESENTATION_DEPT_NAME": "",
              "REPRESENTATION_DEPT_LEVEL": "",
              "REPRESENTATION_UNDER_DEPT_CODE": "",
              "REPRESENTATION_UNDER_DEPT_NAME": "",
              "REPRESENTATION_UNDER_DEPT_LEVEL": "",
              "REPRESENT_WORK_DEPT_CODE": "",
              "REPRESENT_WORK_DEPT_NAME": "",
              "REPRESENT_WORK_DEPT_LEVEL": "",
              "REPRESENT_OFFICE_CODE": "",
              "REPRESENT_OFFICE_NAME": "",
              "REPRESENT_OFFICE_SHORT_NAME": "",
              "STATUS": 1,
              "REMARK": "",
              "CONTRIBUTOR_ID": f.ArrestType == "ผู้จับกุม" ? 14 : 15,
              "IS_ACTIVE": 1
            });
          });

          list_add_lawbreaker.forEach((f) {
            map_upadd_lawbreaker.add({
              "LAWBREAKER_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
              "PERSON_ID": f.PERSON_ID,
              "TITLE_ID": f.TITLE_ID,
              "PERSON_TYPE": f.PERSON_TYPE,
              "ENTITY_TYPE": f.ENTITY_TYPE,
              "TITLE_NAME_TH": f.TITLE_NAME_TH,
              "TITLE_NAME_EN": f.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": f.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": f.TITLE_SHORT_NAME_EN,
              "FIRST_NAME": f.FIRST_NAME,
              "MIDDLE_NAME": f.MIDDLE_NAME,
              "LAST_NAME": f.LAST_NAME,
              "OTHER_NAME": f.OTHER_NAME,
              "COMPANY_NAME": "",
              "COMPANY_REGISTRATION_NO": "",
              "EXCISE_REGISTRATION_NO": "",
              "ID_CARD": f.ID_CARD,
              "AGE": f.AGE,
              "PASSPORT_NO": f.PASSPORT_NO,
              "CAREER": "",
              "PERSON_DESC": "",
              "EMAIL": "",
              "TEL_NO": "",
              "MISTREAT_NO": f.MISTREAT_NO,
              "IS_ACTIVE": 1
            });
          });

          List<Map>productMapping = [];
          list_add_product.forEach((item) {
            productMapping.add(
                {
                  "PRODUCT_ID": "",
                  "ARREST_ID": _arrestMain.ARREST_ID,
                  "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
                  "PRODUCT_CODE": item.PRODUCT_CODE,
                  "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
                  "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
                  "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
                  "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
                  "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
                  "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
                  "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
                  "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
                  "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
                  "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
                  "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
                  "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
                  "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
                  "PRODUCT_GROUP_CODE": "",
                  "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME!=null?item.PRODUCT_GROUP_NAME:"",
                  "PRODUCT_CATEGORY_CODE": "",
                  "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME!=null?item.PRODUCT_CATEGORY_NAME:"",
                  "PRODUCT_TYPE_CODE": "",
                  "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME!=null?item.PRODUCT_TYPE_NAME:"",
                  "PRODUCT_SUBTYPE_CODE": "",
                  "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME!=null?item.PRODUCT_SUBTYPE_NAME:"",
                  "PRODUCT_SUBSETTYPE_CODE": "",
                  "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME!=null?item.PRODUCT_SUBSETTYPE_NAME:"",
                  "PRODUCT_BRAND_CODE": "",
                  "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:"",
                  "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN!=null?item.PRODUCT_BRAND_NAME_EN:"",
                  "PRODUCT_SUBBRAND_CODE": "",
                  "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH!=null?item.PRODUCT_SUBBRAND_NAME_TH:"",
                  "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN!=null?item.PRODUCT_SUBBRAND_NAME_EN:"",
                  "PRODUCT_MODEL_CODE": "",
                  "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH!=null?item.PRODUCT_MODEL_NAME_TH:"",
                  "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN!=null?item.PRODUCT_MODEL_NAME_EN:"",
                  "IS_TAX_VALUE": 1,
                  "TAX_VALUE": "",
                  "IS_TAX_VOLUMN": 1,
                  "TAX_VOLUMN": "",
                  "TAX_VOLUMN_UNIT": "",
                  "LICENSE_PLATE": "",
                  "ENGINE_NO": "",
                  "CHASSIS_NO": "",
                  "PRODUCT_DESC": (item.PRODUCT_GROUP_NAME != null
                      ? (item.PRODUCT_GROUP_NAME
                      .toString() + ' ')
                      : '') +
                      (item.PRODUCT_CATEGORY_NAME != null
                          ? (item.PRODUCT_CATEGORY_NAME
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_TYPE_NAME != null
                          ? (item.PRODUCT_TYPE_NAME
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_BRAND_NAME_TH != null
                          ? (item.PRODUCT_BRAND_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_BRAND_NAME_EN != null
                          ? (item.PRODUCT_BRAND_NAME_EN
                          .toString() + ' ')
                          : '') +

                      (item.PRODUCT_SUBBRAND_NAME_TH != null
                          ? (item.PRODUCT_SUBBRAND_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_SUBBRAND_NAME_EN != null
                          ? (item.PRODUCT_SUBBRAND_NAME_EN
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_MODEL_NAME_TH != null
                          ? (item.PRODUCT_MODEL_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_MODEL_NAME_EN != null
                          ? (item.PRODUCT_MODEL_NAME_EN
                          .toString() + ' ')
                          : '') +
                      (item.DEGREE != null
                          ? (item.DEGREE.toString() +
                          ' ดีกรี ')
                          : ' ') +
                      item.SIZES.toString() + ' ' +
                      item.SIZES_UNIT.toString(),
                  "SUGAR": item.SUGAR,
                  "CO2": item.CO2,
                  "DEGREE": item.DEGREE,
                  "PRICE": item.PRICE,
                  "SIZES": item.SIZES,
                  "SIZES_UNIT": item.SIZES_UNIT,
                  "QUANTITY": item.QUANTITY,
                  "QUANTITY_UNIT": item.QUANTITY_UNIT,
                  "VOLUMN": item.VOLUMN,
                  "VOLUMN_UNIT": item.VOLUMN_UNIT,
                  "REMARK": "",
                  "IS_DOMESTIC": 1,
                  "IS_ILLEGAL": 1,
                  "IS_ACTIVE": 1,
                }
            );
            map_upadd_product.add({
              "PRODUCT_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
              "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
              "PRODUCT_CODE": item.PRODUCT_CODE,
              "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
              "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
              "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
              "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
              "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
              "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
              "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
              "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
              "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
              "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
              "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
              "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
              "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
              "PRODUCT_GROUP_CODE": "",
              "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME!=null?item.PRODUCT_GROUP_NAME:"",
              "PRODUCT_CATEGORY_CODE": "",
              "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME!=null?item.PRODUCT_CATEGORY_NAME:"",
              "PRODUCT_TYPE_CODE": "",
              "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME!=null?item.PRODUCT_TYPE_NAME:"",
              "PRODUCT_SUBTYPE_CODE": "",
              "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME!=null?item.PRODUCT_SUBTYPE_NAME:"",
              "PRODUCT_SUBSETTYPE_CODE": "",
              "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME!=null?item.PRODUCT_SUBSETTYPE_NAME:"",
              "PRODUCT_BRAND_CODE": "",
              "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:"",
              "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN!=null?item.PRODUCT_BRAND_NAME_EN:"",
              "PRODUCT_SUBBRAND_CODE": "",
              "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH!=null?item.PRODUCT_SUBBRAND_NAME_TH:"",
              "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN!=null?item.PRODUCT_SUBBRAND_NAME_EN:"",
              "PRODUCT_MODEL_CODE": "",
              "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH!=null?item.PRODUCT_MODEL_NAME_TH:"",
              "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN!=null?item.PRODUCT_MODEL_NAME_EN:"",
              "IS_TAX_VALUE": 1,
              "TAX_VALUE": "",
              "IS_TAX_VOLUMN": 1,
              "TAX_VOLUMN": "",
              "TAX_VOLUMN_UNIT": "",
              "LICENSE_PLATE": "",
              "ENGINE_NO": "",
              "CHASSIS_NO": "",
              "PRODUCT_DESC": (item.PRODUCT_GROUP_NAME != null
                  ? (item.PRODUCT_GROUP_NAME
                  .toString() + ' ')
                  : '') +
                  (item.PRODUCT_CATEGORY_NAME != null
                      ? (item.PRODUCT_CATEGORY_NAME
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_TYPE_NAME != null
                      ? (item.PRODUCT_TYPE_NAME
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_BRAND_NAME_TH != null
                      ? (item.PRODUCT_BRAND_NAME_TH
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_BRAND_NAME_EN != null
                      ? (item.PRODUCT_BRAND_NAME_EN
                      .toString() + ' ')
                      : '') +

                  (item.PRODUCT_SUBBRAND_NAME_TH != null
                      ? (item.PRODUCT_SUBBRAND_NAME_TH
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_SUBBRAND_NAME_EN != null
                      ? (item.PRODUCT_SUBBRAND_NAME_EN
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_MODEL_NAME_TH != null
                      ? (item.PRODUCT_MODEL_NAME_TH
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_MODEL_NAME_EN != null
                      ? (item.PRODUCT_MODEL_NAME_EN
                      .toString() + ' ')
                      : '') +
                  (item.DEGREE != null
                      ? (item.DEGREE.toString() +
                      ' ดีกรี ')
                      : ' ') +
                  item.SIZES.toString() + ' ' +
                  item.SIZES_UNIT.toString(),
              "SUGAR": item.SUGAR,
              "CO2": item.CO2,
              "DEGREE": item.DEGREE,
              "PRICE": item.PRICE,
              "SIZES": item.SIZES,
              "SIZES_UNIT": item.SIZES_UNIT,
              "QUANTITY": item.QUANTITY,
              "QUANTITY_UNIT": item.QUANTITY_UNIT,
              "VOLUMN": item.VOLUMN,
              "VOLUMN_UNIT": item.VOLUMN_UNIT,
              "REMARK": "",
              "IS_DOMESTIC": 1,
              "IS_ILLEGAL": 1,
              "IS_ACTIVE": 1,
              "ArrestProductMapping": productMapping
            });
          });

          list_add_indicment.forEach((f) {
            List<Map> ArrestLawbreaker = [];
            f.ArrestIndictmentDetail.forEach((item) {
              ArrestLawbreaker.add({
                "INDICTMENT_DETAIL_ID": "",
                "INDICTMENT_ID": "",
                "LAWBREAKER_ID": _arrestMain.ArrestLawbreaker[item.INDEX]
                    .LAWBREAKER_ID,
                "IS_ACTIVE": 1
              });
            });
            map_upadd_indicment.add({
              "INDICTMENT_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
              "GUILTBASE_ID": f.GUILTBASE_ID,
              "FINE_ESTIMATE": "",
              "IS_LAWSUIT_COMPLETE": 0,
              "IS_ACTIVE": 1,
              "ArrestIndictmentDetail": ArrestLawbreaker,
             /* "ArrestIndictmentProduct": ArrestProduct*/
              "ArrestIndictmentProduct":[],
            });
          });

          list_update_indicment.forEach((f) {
            f.ArrestIndictmentProduct.forEach((item) {
              map_up_indicment_pro.add({
                "PRODUCT_INDICTMENT_ID": item.PRODUCT_INDICTMENT_ID,
                "PRODUCT_ID": item.PRODUCT_ID,
                "INDICTMENT_ID": f.INDICTMENT_ID,
                "SIZES_UNIT_ID": 1,
                "QUATITY_UNIT_ID": 2,
                "VOLUMN_UNIT_ID": 2,
                "SIZES": item.SIZES,
                "SIZES_UNIT": item.SIZES_UNIT,
                "QUANTITY": item.QUANTITY,
                "QUANTITY_UNIT": item.QUANTITY_UNIT,
                "VOLUMN": item.VOLUMN,
                "VOLUMN_UNIT": item.VOLUMN_UNIT,
                "FINE_ESTIMATE": "",
                "IS_ILLEGAL": 1,
                "IS_ACTIVE": 1
              });
              map_up_indicment.add({
                "INDICTMENT_ID": f.INDICTMENT_ID,
                "ARREST_ID": _arrestMain.ARREST_ID,
                "GUILTBASE_ID": f.GUILTBASE_ID,
                "FINE_ESTIMATE": "",
                "IS_LAWSUIT_COMPLETE": 0,
                "IS_ACTIVE": 1
              });
            });
            /*f.ArrestIndictmentDetail.forEach((item) {
              _arrestMain.ArrestIndictment.forEach((item1){
                for(int i=0;i<item1.ArrestIndictmentDetail.length;i++){
                  if(item1.ArrestIndictmentDetail[i].LAWBREAKER_ID==item.LAWBREAKER_ID){
                    print(i.toString()+" : "+item.LAWBREAKER_ID.toString());
                    break;
                  }
                }
              });
            });*/
            f.ArrestIndictmentDetail.forEach((item) {
              map_up_indicment_delt.add({
                "INDICTMENT_DETAIL_ID": "",
                "INDICTMENT_ID": f.INDICTMENT_ID,
                "LAWBREAKER_ID": item.LAWBREAKER_ID,
                "IS_ACTIVE": 1
              });
            });
          });


          list_update_product.forEach((item) {
            map_up_product.add({
              "PRODUCT_ID": item.PRODUCT_ID,
              "ARREST_ID": _arrestMain.ARREST_ID,
              "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
              "PRODUCT_CODE": item.PRODUCT_CODE,
              "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
              "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
              "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
              "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
              "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
              "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
              "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
              "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
              "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
              "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
              "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
              "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
              "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
              "PRODUCT_GROUP_CODE": "",
              "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME!=null?item.PRODUCT_GROUP_NAME:"",
              "PRODUCT_CATEGORY_CODE": "",
              "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME!=null?item.PRODUCT_CATEGORY_NAME:"",
              "PRODUCT_TYPE_CODE": "",
              "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME!=null?item.PRODUCT_TYPE_NAME:"",
              "PRODUCT_SUBTYPE_CODE": "",
              "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME!=null?item.PRODUCT_SUBTYPE_NAME:"",
              "PRODUCT_SUBSETTYPE_CODE": "",
              "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME!=null?item.PRODUCT_SUBSETTYPE_NAME:"",
              "PRODUCT_BRAND_CODE": "",
              "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:"",
              "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN!=null?item.PRODUCT_BRAND_NAME_EN:"",
              "PRODUCT_SUBBRAND_CODE": "",
              "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH!=null?item.PRODUCT_SUBBRAND_NAME_TH:"",
              "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN!=null?item.PRODUCT_SUBBRAND_NAME_EN:"",
              "PRODUCT_MODEL_CODE": "",
              "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH!=null?item.PRODUCT_MODEL_NAME_TH:"",
              "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN!=null?item.PRODUCT_MODEL_NAME_EN:"",
              "IS_TAX_VALUE": 1,
              "TAX_VALUE": "",
              "IS_TAX_VOLUMN": 1,
              "TAX_VOLUMN": "",
              "TAX_VOLUMN_UNIT": "",
              "LICENSE_PLATE": "",
              "ENGINE_NO": "",
              "CHASSIS_NO": "",
              "PRODUCT_DESC": (item.PRODUCT_GROUP_NAME != null
                  ? (item.PRODUCT_GROUP_NAME
                  .toString() + ' ')
                  : '') +
                  (item.PRODUCT_CATEGORY_NAME != null
                      ? (item.PRODUCT_CATEGORY_NAME
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_TYPE_NAME != null
                      ? (item.PRODUCT_TYPE_NAME
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_BRAND_NAME_TH != null
                      ? (item.PRODUCT_BRAND_NAME_TH
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_BRAND_NAME_EN != null
                      ? (item.PRODUCT_BRAND_NAME_EN
                      .toString() + ' ')
                      : '') +

                  (item.PRODUCT_SUBBRAND_NAME_TH != null
                      ? (item.PRODUCT_SUBBRAND_NAME_TH
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_SUBBRAND_NAME_EN != null
                      ? (item.PRODUCT_SUBBRAND_NAME_EN
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_MODEL_NAME_TH != null
                      ? (item.PRODUCT_MODEL_NAME_TH
                      .toString() + ' ')
                      : '') +
                  (item.PRODUCT_MODEL_NAME_EN != null
                      ? (item.PRODUCT_MODEL_NAME_EN
                      .toString() + ' ')
                      : '') +
                  (item.DEGREE != null
                      ? (item.DEGREE.toString() +
                      ' ดีกรี ')
                      : ' ') +
                  item.SIZES.toString() + ' ' +
                  item.SIZES_UNIT.toString(),
              "SUGAR": item.SUGAR,
              "CO2": item.CO2,
              "DEGREE": item.DEGREE,
              "PRICE": item.PRICE,
              "SIZES": item.SIZES,
              "SIZES_UNIT": item.SIZES_UNIT,
              "QUANTITY": item.QUANTITY,
              "QUANTITY_UNIT": item.QUANTITY_UNIT,
              "VOLUMN": item.VOLUMN,
              "VOLUMN_UNIT": item.VOLUMN_UNIT,
              "REMARK": "",
              "IS_DOMESTIC": 1,
              "IS_ILLEGAL": 1,
              "IS_ACTIVE": 1,
              "ArrestProductMapping": [
                {
                  "PRODUCT_ID": item.PRODUCT_ID,
                  "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
                  "PRODUCT_CODE": item.PRODUCT_CODE,
                  "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
                  "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
                  "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
                  "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
                  "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
                  "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
                  "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
                  "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
                  "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
                  "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
                  "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
                  "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
                  "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
                  "PRODUCT_GROUP_CODE": "",
                  "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME!=null?item.PRODUCT_GROUP_NAME:"",
                  "PRODUCT_CATEGORY_CODE": "",
                  "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME!=null?item.PRODUCT_CATEGORY_NAME:"",
                  "PRODUCT_TYPE_CODE": "",
                  "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME!=null?item.PRODUCT_TYPE_NAME:"",
                  "PRODUCT_SUBTYPE_CODE": "",
                  "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME!=null?item.PRODUCT_SUBTYPE_NAME:"",
                  "PRODUCT_SUBSETTYPE_CODE": "",
                  "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME!=null?item.PRODUCT_SUBSETTYPE_NAME:"",
                  "PRODUCT_BRAND_CODE": "",
                  "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:"",
                  "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN!=null?item.PRODUCT_BRAND_NAME_EN:"",
                  "PRODUCT_SUBBRAND_CODE": "",
                  "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH!=null?item.PRODUCT_SUBBRAND_NAME_TH:"",
                  "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN!=null?item.PRODUCT_SUBBRAND_NAME_EN:"",
                  "PRODUCT_MODEL_CODE": "",
                  "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH!=null?item.PRODUCT_MODEL_NAME_TH:"",
                  "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN!=null?item.PRODUCT_MODEL_NAME_EN:"",
                  "IS_TAX_VALUE": 1,
                  "TAX_VALUE": "",
                  "IS_TAX_VOLUMN": 1,
                  "TAX_VOLUMN": "",
                  "TAX_VOLUMN_UNIT": "",
                  "LICENSE_PLATE": "",
                  "ENGINE_NO": "",
                  "CHASSIS_NO": "",
                  "PRODUCT_DESC": (item.PRODUCT_GROUP_NAME != null
                      ? (item.PRODUCT_GROUP_NAME
                      .toString() + ' ')
                      : '') +
                      (item.PRODUCT_CATEGORY_NAME != null
                          ? (item.PRODUCT_CATEGORY_NAME
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_TYPE_NAME != null
                          ? (item.PRODUCT_TYPE_NAME
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_BRAND_NAME_TH != null
                          ? (item.PRODUCT_BRAND_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_BRAND_NAME_EN != null
                          ? (item.PRODUCT_BRAND_NAME_EN
                          .toString() + ' ')
                          : '') +

                      (item.PRODUCT_SUBBRAND_NAME_TH != null
                          ? (item.PRODUCT_SUBBRAND_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_SUBBRAND_NAME_EN != null
                          ? (item.PRODUCT_SUBBRAND_NAME_EN
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_MODEL_NAME_TH != null
                          ? (item.PRODUCT_MODEL_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (item.PRODUCT_MODEL_NAME_EN != null
                          ? (item.PRODUCT_MODEL_NAME_EN
                          .toString() + ' ')
                          : '') +
                      (item.DEGREE != null
                          ? (item.DEGREE.toString() +
                          ' ดีกรี ')
                          : ' ') +
                      item.SIZES.toString() + ' ' +
                      item.SIZES_UNIT.toString(),
                  "SUGAR": item.SUGAR,
                  "CO2": item.CO2,
                  "DEGREE": item.DEGREE,
                  "PRICE": item.PRICE,
                  "SIZES": item.SIZES,
                  "SIZES_UNIT": item.SIZES_UNIT,
                  "QUANTITY": item.QUANTITY,
                  "QUANTITY_UNIT": item.QUANTITY_UNIT,
                  "VOLUMN": item.VOLUMN,
                  "VOLUMN_UNIT": item.VOLUMN_UNIT,
                  "REMARK": "",
                  "IS_DOMESTIC": 1,
                  "IS_ILLEGAL": 1,
                  "IS_ACTIVE": 1,
                }
              ]
            });
          });

          if(list_update_indicment.length>0){
            list_delete_indicment_delt.forEach((f){
              map_del_indic_detail_id.add({
                "INDICTMENT_DETAIL_ID": f
              });
            });
          }
        }

        Map local;
        if (list_update_location != null) {
          local = {
            "LOCALE_ID": _arrestMain.ArrestLocale[0].LOCALE_ID,
            "ARREST_ID": _arrestMain.ARREST_ID,
            "SUB_DISTRICT_ID": list_update_location.SUB_DISTICT.SUB_DISTRICT_ID,
            "GPS": list_update_location.GPS,
            "ADDRESS_NO": list_update_location.ADDRESS_NO,
            "VILLAGE_NO": "",
            "BUILDING_NAME": "",
            "ROOM_NO": "",
            "FLOOR": "",
            "VILLAGE_NAME": "",
            "ALLEY": list_update_location.ALLEY,
            "LANE": "",
            "ROAD": list_update_location.ROAD,
            "ADDRESS_TYPE": 4,
            "ADDRESS_STATUS": 0,
            "POLICE_STATION": "",
            "LOCATION": "",
            "IS_ACTIVE": 1
          };
        } else {
          local = {
            "LOCALE_ID": _arrestMain.ArrestLocale[0].LOCALE_ID,
            "ARREST_ID": _arrestMain.ARREST_ID,
            "SUB_DISTRICT_ID": _arrestMain.ArrestLocale[0].SUB_DISTRICT_ID,
            "GPS": _arrestMain.ArrestLocale[0].GPS,
            "ADDRESS_NO": _arrestMain.ArrestLocale[0].ADDRESS_NO,
            "VILLAGE_NO": "",
            "BUILDING_NAME": "",
            "ROOM_NO": "",
            "FLOOR": "",
            "VILLAGE_NAME": "",
            "ALLEY": _arrestMain.ArrestLocale[0].ALLEY,
            "LANE": "",
            "ROAD": _arrestMain.ArrestLocale[0].ROAD,
            "ADDRESS_TYPE": 4,
            "ADDRESS_STATUS": 0,
            "POLICE_STATION": "",
            "LOCATION": "",
            "IS_ACTIVE": 1
          };
        }

        Map map_arrest = {
          "ARREST_ID": _arrestMain.ARREST_ID,
          "OFFICE_ID": 13,
          "ARREST_CODE": _arrestMain.ARREST_CODE,
          "OFFICE_CODE": _arrestMain.OFFICE_CODE,
          "OFFICE_NAME": editArrestPlace.text,
          "ARREST_DATE": _arrestDate.toString(),
          "OCCURRENCE_DATE": _dtCreate.toString(),
          "BEHAVIOR_1": editArrestBehavior.text,
          "BEHAVIOR_2": "",
          "BEHAVIOR_3": "",
          "BEHAVIOR_4": "",
          "BEHAVIOR_5": "",
          "TESTIMONY": "",
          "IS_REQUEST": TESTIMONY==true ? 1 : 0,
          "REQUEST_DESC": TESTIMONY ? editNotificationOfRights.text : "",
          "IS_LAWSUIT_COMPLETE": 0,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 13,
          "UPDATE_DATE": "",
          "UPDATE_USER_ACCOUNT_ID": 0,
          "ArrestLocale": [
            local
          ]
        };

        print("is update pro : "+map_upadd_product.isEmpty.toString());

        await onLoadActionArrestLawbreakerupdDelete(
          map_arrest,
          map_del_law_id,
          map_del_indic_detail_id,
          map_del_staff_id,
          map_del_pro_id,
          map_del_indic_product_id,
          map_del_indic_id,
          map_up_staff,
          map_upadd_lawbreaker,
          map_upadd_product,
          map_upadd_indicment,
          map_up_indicment,
          map_up_indicment_pro,
          map_up_indicment_delt,
          map_up_product,
          map_del_law_id.isEmpty,
          map_del_indic_detail_id.isEmpty,
          map_del_staff_id.isEmpty,
          map_del_pro_id.isEmpty,
          map_del_indic_product_id.isEmpty,
          map_del_indic_id.isEmpty,
          map_up_staff.isEmpty,
          map_upadd_lawbreaker.isEmpty,
          map_upadd_product.isEmpty,
          map_upadd_indicment.isEmpty,
          map_up_indicment.isEmpty,
          map_up_indicment_pro.isEmpty,
          map_up_indicment_delt.isEmpty,
          map_up_product.isEmpty,
        );


        //load data again
        Map MAP_ARREST_ID = {"ARREST_ID": _arrestMain.ARREST_ID};
        await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
          _arrestMain = onValue;
        });
      } else {
        await onLoadActionInsAll(putDataRequest());
      }

      Navigator.pop(context);
    }
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
                Navigator.pop(mContext);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                Navigator.pop(mContext);
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

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /**********************async loading******************************/
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getMessage(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) =>
      new Text('Sorry, there was an error loading your joke'),
      renderSuccess: ({data}) => new Text(data),
    );

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
                _onSaved ? Navigator.pop(context) :
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
          child: Center(child: Text("งานจับกุม", style: appBarStyle),
          )),
      new SizedBox(
          width: width / 3,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _onSaved ? (_onSave ? new FlatButton(
                  onPressed: () {
                   /* setState(() {
                      _onSaved = true;
                      _onSave = false;
                      _onEdited = false;
                    });*/
                    //TabScreenArrest1().createAcceptAlert(context);
                  },
                  child: Text('บันทึก', style: appBarStyle))
                  :
              PopupMenuButton<Constants>(
                onSelected: choiceAction,
                icon: Icon(Icons.more_vert, color: Colors.white,),
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
              ))
                  :
              new FlatButton(
                  onPressed: () {
                    onSaved(context);
                    //editTestimony.text=putDataRequest().toString();
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
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
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
                    isScrollable: true,
                    tabs: choices.map((Choice choice) {
                      return Tab(
                        text: choice.title,
                      );
                    }).toList(),
                  ),
                ),
                body: Stack(
                  children: <Widget>[
                    BackgroundContent(),
                    TabBarView(
                      //physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: _onFinish ? <Widget>[
                        _buildContent_tab_1(),
                        _buildContent_tab_2(),
                        _buildContent_tab_3(),
                        _buildContent_tab_4(),
                        _buildContent_tab_5(),
                        _buildContent_tab_6(),
                        _buildContent_tab_7(),
                        _buildContent_tab_8(),
                      ] :
                      <Widget>[
                        _buildContent_tab_1(),
                        _buildContent_tab_2(),
                        _buildContent_tab_3(),
                        _buildContent_tab_4(),
                        _buildContent_tab_5(),
                        _buildContent_tab_6(),
                        _buildContent_tab_7(),
                      ],
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************start_tab_1*****************************
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

  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      final double Width = (size.width * 85) / 100;

      Widget _buildLine = Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
        width: Width,
        height: 1.0,
        color: Colors.grey[300],
      );
      final focus = FocusNode();

      return Container(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Container(
                    width: Width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "เลขที่ใบจับกุม", style: textLabelStyle,),
                          ),
                          new Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enabled: false,
                              focusNode: myFocusNodeArrestNumber,
                              controller: editArrestNumber,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          //_buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text("วันที่จับกุม", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode());
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ArrestDynamicDialog(
                                          Current: _dtArrest,
                                          MaxDate: _dtMaxDate,
                                          MinDate: null);
                                    }).then((s) {
                                  _currentDateArrestEN = s.toString();
                                  print(_currentDateArrestEN);
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtArrest = s;
                                    _currentDateArrestTH = date;
                                    editArrestDate.text = _currentDateArrestTH;
                                    _arrestDate = _dtArrest.toString();
                                    //myFocusNodeArrestDate.dispose();
                                  });
                                });
                                //_selectDate(context);
                              },
                              focusNode: myFocusNodeArrestDate,
                              controller: editArrestDate,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(FontAwesomeIcons.calendarAlt,
                                  color: Colors.grey,),
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text("เวลาจับกุม", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
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
                                        initialDateTime: time,
                                        onDateTimeChanged: (
                                            DateTime newDateTime) {
                                          setState(() {
                                            time = newDateTime;
                                            _time = dateFormatTime.format(time)
                                                .toString();
                                            editArrestTime.text = _time;

                                            List splitsArrestDate = _dtArrest
                                                .toUtc().toLocal()
                                                .toString()
                                                .split(" ");
                                            List splitsArrestTime = time
                                                .toString().split(" ");
                                            _arrestDate =
                                                splitsArrestDate[0].toString() +
                                                    " " + splitsArrestTime[1]
                                                    .toString();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              focusNode: myFocusNodeArrestTime,
                              controller: editArrestTime,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "สถานที่เกิดเหตุ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode());
                                _navigateMap(context);
                              },
                              focusNode: myFocusNodeArrestLocation,
                              controller: editArrestLocation,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(FontAwesomeIcons.mapMarkerAlt,
                                  color: Color(0xff087de1),),
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text("วันที่เขียน", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode());
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ArrestDynamicDialog(
                                        Current: _dtCreate,
                                        MaxDate: _dtMaxDate,
                                        MinDate: _dtArrest,
                                      );
                                    }).then((s) {
                                  _currentDateCreateEN = s.toString();
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtCreate = s;
                                    _currentDateCreateTH = date;
                                    editArrestDateCreate.text =
                                        _currentDateCreateTH;
                                    //myFocusNodeArrestDateCreate.dispose();
                                  });
                                });
                              },
                              focusNode: myFocusNodeArrestDateCreate,
                              controller: editArrestDateCreate,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(FontAwesomeIcons.calendarAlt,
                                  color: Colors.grey,),
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text("เขียนที่", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodeArrestPlace,
                              controller: editArrestPlace,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String address = "";
      _arrestMain.ArrestLocale.forEach((item) {
        address =
            (item.ADDRESS_NO == null ? "" : item.ADDRESS_NO) +
                (item.ALLEY == null ? "" : " ซอย " + item.ALLEY.toString())
                + (item.ROAD == null ? "" : " ถนน " + item.ROAD.toString())
                + " อำเภอ/เขต " + item.DISTRICT_NAME_TH.toString()
                + " ตำบล/แขวง " +
                item.SUB_DISTRICT_NAME_TH.toString() + " จังหวัด " +
                item.PROVINCE_NAME_TH.toString();
      });

      //OCCURRENCE_DATE
      DateTime dt_occourrence = DateTime.parse(_arrestMain.OCCURRENCE_DATE);
      String arrestDate = "";
      List splits1 = dateFormatDate.format(dt_occourrence).toString().split(
          " ");
      arrestDate = splits1[0] + " " + splits1[1] + " " +
          (int.parse(splits1[3]) + 543).toString();
      String arrestTime = "เวลา " +
          dateFormatTime.format(dt_occourrence).toString();
      //ARREST_DATE
      DateTime dt_arrest = DateTime.parse(_arrestMain.ARREST_DATE);
      String arrestCreateDate = "";
      List splits2 = dateFormatDate.format(dt_arrest).toString().split(" ");
      arrestCreateDate = splits2[0] + " " + splits2[1] + " " +
          (int.parse(splits2[3]) + 543).toString();
      String arrestCreateTime = "เวลา " +
          dateFormatTime.format(dt_arrest).toString();

      String arrestNumber = _arrestMain.ARREST_CODE;
      String arrestPlace = _arrestMain.OFFICE_NAME;


      return _arrestMain == null ? Container() : Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            //color: Colors.white,
            border: Border(
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        padding: EdgeInsets.only(
            top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 0.0,
              color: Colors.transparent,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขที่ใบจับกุม", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(arrestNumber, style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("วันที่จับกุม", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(arrestDate + " " + arrestTime,
                          style: textInputStyle,),
                      ),

                      Container(
                        padding: paddingLabel,
                        child: Text("สถานที่เกิดเหตุ", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(address, style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่เขียน", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(arrestCreateDate + " " + arrestCreateTime,
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("เขียนที่", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(arrestPlace, style: textInputStyle,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Center(
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
                  //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text('ILG60_B_01_00_03_00',
                    style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: new ListView(
                  children: <Widget>[
                    _onSaved
                        ? _buildContent_saved(context)
                        : _buildContent(
                        context),
                  ]
              ),
            ),
          ),

        ],
      ),
    );
  }

//************************end_tab_1*******************************

//************************start_tab_2*****************************
  _navigateSearchTab2(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest2Search()),
    );
    List<ItemsList> items = result;
    _itemsDataTab2 = result;
  }

  Widget _buildContent_tab_2() {
    //data result when search data
    Widget _buildContent() {
      return _itemsDataTab2.length==0?Center(
        child: Padding(
          padding: paddingInputBox,
          child: Text(
            "ค้นหาใบเเจ้งความที่ช่องค้นหา",
            style: TextStyle(fontSize: 20.0,fontFamily: FontStyles().FontFamily),),
        ),
      ):Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _itemsDataTab2.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            String title = _itemsDataTab2[index].STAFF_TITLE_SHORT_NAME_TH!=null
                ?_itemsDataTab2[index].STAFF_TITLE_SHORT_NAME_TH
                :_itemsDataTab2[index].STAFF_TITLE_NAME_TH;
            String firstname =  _itemsDataTab2[index].STAFF_FIRST_NAME!=null
                ?_itemsDataTab2[index].STAFF_FIRST_NAME
                :"";
            String lastname =  _itemsDataTab2[index].STAFF_LAST_NAME!=null
                ?_itemsDataTab2[index].STAFF_LAST_NAME
                :"";
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: index==0
                          ?Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                          :Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("เลขที่ใบจับกุม", style: textLabelStyle,),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: paddingInputBox,
                              child: Text(
                                _itemsDataTab2[index].NOTICE_CODE,
                                style: textDataStyle,),
                            ),
                          ),
                          Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _showDeleteItemsAlertDialog(index,"Notice");
                                  });
                                },
                                child: Container(
                                    child: Text(
                                      "ลบ", style: textLabelDeleteStyle,)
                                ),
                              )
                          ),
                        ],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้รับแจ้งความ " +
                              title+ firstname + " " + lastname,
                          style: textDataStyleSub,),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    Widget _buildContent_saved(BuildContext context) {
      return ListView.builder(
          itemCount: _arrestMain.ArrestNotice.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    //color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 0.0,
                      color: Colors.transparent,
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขที่ใบเเจ้งความ", style: textLabelStyle,),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  _arrestMain.ArrestNotice[index].NOTICE_CODE,
                                  style: textInputStyle,),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text(_arrestMain.ArrestNotice[index]
                                    .STAFF_TITLE_SHORT_NAME_TH +
                                    _arrestMain.ArrestNotice[index]
                                        .STAFF_FIRST_NAME + " " +
                                    _arrestMain.ArrestNotice[index]
                                        .STAFF_LAST_NAME,
                                  style: textDataSubStyle,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      );
    }

    return  Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //height: 34.0,
              decoration: BoxDecoration(
                //color: Colors.grey[200],
                  border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                children: <Widget>[Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /*Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_05_00',
                          style: textStylePageName,),
                      ),*/
                  ],
                ),
                  _onSaved ? Container()
                      : Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Card(
                        elevation: 0.0,
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: new GestureDetector(
                          onTap: () {
                            _navigateSearchTab2(context);
                          },
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('ค้นหาใบแจ้งความ', style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[500],fontFamily: FontStyles().FontFamily),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: _onSaved
                  ? _buildContent_saved(context)
                  : _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_2*******************************

//************************start_tab_3*****************************
  List _id_staff=[];
  List _id_staff_previos=[];
  _navigateSearchTab3(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          TabScreenArrest3Search(
            ItemsMain: _arrestMain, itemsTitle: widget.itemsTitle,)),
    );

    if (result.toString() != "back") {
      if (_onEdited) {
        List items = result;
        /*_arrestMain.ArrestStaff.forEach((item) {
          _id_staff.add(item.STAFF_ID);
          _id_staff_previos.add(item.STAFF_ID);
        });*/
        items.forEach((item) {
          //_id_staff.add(item.STAFF_ID);
          _arrestMain.ArrestStaff.add(item);
          list_add_staff.add(item);
        });
        /*var _removeDupicate = _id_staff.toSet().toList();
        List ItemsAll = [];
        List ItemsAll1 = [];
        for (int i = 0; i < _removeDupicate.length; i++) {
          for (int j = 0; j < _arrestMain.ArrestStaff.length; j++) {
            if (_removeDupicate[i] ==
                _arrestMain.ArrestStaff[j].STAFF_ID) {
              ItemsAll.add(_arrestMain.ArrestStaff[j]);
              ItemsAll1.add(_arrestMain.ArrestStaff[j]);
              break;
            }
          }
        }
        _arrestMain.ArrestStaff = ItemsAll;

        for (int i = 0; i < _id_staff_previos.length; i++) {
          ItemsAll1.removeWhere((item) => item.STAFF_ID == _id_staff_previos[i]);
        }
        list_add_staff = ItemsAll1;
        */
      } else {
        List items = result;
        items.forEach((item) {
          //_id_staff.add(item.STAFF_ID);
          _itemsDataTab3.add(item);
        });
        /*var _removeDupicate = _id.toSet().toList();
        List ItemsAll = [];
        for (int i = 0; i < _removeDupicate.length; i++) {
          for (int j = 0; j < _itemsDataTab3.length; j++) {
            if (_removeDupicate[i] == _itemsDataTab3[j].STAFF_ID) {
              ItemsAll.add(_itemsDataTab3[j]);
              break;
            }
          }
        }
        _itemsDataTab3 = ItemsAll;*/
        //_itemsDataTab3.add(item);
      }
    }
  }


    Widget _buildContent_tab_3() {
      Widget _buildContent() {
        return Container(
          padding: EdgeInsets.only(bottom: 12.0),
          child: ListView.builder(
            itemCount: _itemsDataTab3.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              String level = _itemsDataTab3[index].OPREATION_POS_LAVEL_NAME !=
                  null ? _itemsDataTab3[index].OPREATION_POS_LAVEL_NAME : "";
              String position = _itemsDataTab3[index].OPREATION_POS_NAME != null
                  ? _itemsDataTab3[index].OPREATION_POS_NAME
                  : "-";
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Container(
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        //color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: index == 0 ? Border(
                            //top: BorderSide(color: Colors.grey[300], width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          ) : Border(
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        _itemsDataTab3[index]
                                            .TITLE_SHORT_NAME_TH +
                                            _itemsDataTab3[index].FIRST_NAME +
                                            " " +
                                            _itemsDataTab3[index].LAST_NAME
                                        ,
                                        style: textDataStyle,),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      _itemsDataTab3[index].STAFF_TYPE==0
                                          ?Container(
                                        padding: EdgeInsets.only(right: 22.0),
                                        child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                _navigateEditStaff(
                                                    context,
                                                    _itemsDataTab3[index],
                                                    index);
                                              },
                                              child: index == 0 ? Container()
                                                  : Container(
                                                  child: Text(
                                                    "แก้ไข", style: textLabelDeleteStyle,)
                                              ),
                                            )
                                        ),
                                      ):Container(),
                                      Center(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _showDeleteItemsAlertDialog(
                                                    index, "Staff");
                                              });
                                            },
                                            child: index == 0 ? Container()
                                                : Container(
                                                child: Text(
                                                  "ลบ",
                                                  style: textLabelDeleteStyle,)
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  "ตำแหน่ง : " + position + level,
                                  style: textDataStyleSub,),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        "สังกัด : " + (_itemsDataTab3[index]
                                            .OPERATION_OFFICE_SHORT_NAME != null
                                            ? _itemsDataTab3[index]
                                            .OPERATION_OFFICE_SHORT_NAME
                                            : _itemsDataTab3[index]
                                            .OPERATION_OFFICE_NAME),
                                        //_itemsDataTab3[index].OPERATION_OFFICE_NAME,
                                        style: textDataStyleSub,),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _itemsDataTab3.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _itemsDataTab3[index]
                                                .ArrestType,
                                            isDense: true,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                if (!_itemsDataTab3[index]
                                                    .ArrestType.endsWith(
                                                    "ผู้จับกุม")) {
                                                  _itemsDataTab3[index]
                                                      .ArrestType =
                                                      newValue;
                                                }
                                                if (_itemsDataTab3[index]
                                                    .ArrestType.endsWith(
                                                    "ผู้จับกุม")) {
                                                  for (int i = 0; i <
                                                      _itemsDataTab3
                                                          .length; i++) {
                                                    if (index != i) {
                                                      _itemsDataTab3[i]
                                                          .ArrestType =
                                                      "ผู้ร่วมจับกุม";
                                                    }
                                                  }
                                                }
                                              });
                                            },
                                            items: _itemsDataTab3[index]
                                                .ArrestTypeItems
                                                .map<DropdownMenuItem<String>>((
                                                String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value, style: textDataStyle,),
                                              );
                                            })
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              );
            },
          ),
        );
      }
      Widget _buildContent_saved(BuildContext context) {
        return ListView.builder(
          itemCount: _arrestMain.ArrestStaff.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  //color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: index == 0 ? Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    ) : Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Stack(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: paddingInputBox,
                              child: Text(
                                _arrestMain.ArrestStaff[index]
                                    .TITLE_SHORT_NAME_TH +
                                    _arrestMain.ArrestStaff[index]
                                        .FIRST_NAME + " " +
                                    _arrestMain.ArrestStaff[index]
                                        .LAST_NAME,
                                style: textDataStyle,),
                            ),
                          ),
                          _onEdited ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _arrestMain.ArrestStaff[index].STAFF_TYPE==0
                                  ?Container(
                                padding: EdgeInsets.only(right: 22.0),
                                child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        _navigateEditStaff(
                                            context,
                                            _arrestMain.ArrestStaff[index],
                                            index);
                                      },
                                      child: _arrestMain.ArrestStaff[index]
                                          .CONTRIBUTOR_ID == 14 ? Container()
                                          : Container(
                                          child: Text(
                                            "แก้ไข", style: textLabelDeleteStyle,)
                                      ),
                                    )
                                ),
                              ):Container(),
                              Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _showDeleteItemsAlertDialog(
                                            index, "StaffUp");
                                      });
                                    },
                                    child: _arrestMain.ArrestStaff[index]
                                        .CONTRIBUTOR_ID == 14 ? Container()
                                        : Container(
                                        child: Text(
                                          "ลบ", style: textLabelDeleteStyle,)
                                    ),
                                  )
                              )
                            ],
                          ) : Container(),
                        ],
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "ตำแหน่ง : " + _arrestMain.ArrestStaff[index]
                              .OPREATION_POS_NAME,
                          style: textDataStyleSub,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "สังกัด : " +
                                    _arrestMain.ArrestStaff[index]
                                        .OPERATION_OFFICE_NAME,
                                style: textDataStyleSub,),
                            ),
                          ),
                          _onEdited ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _arrestMain.ArrestStaff[index]
                                          .ArrestType,
                                      isDense: true,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          if (!_arrestMain.ArrestStaff[index]
                                              .ArrestType
                                              .endsWith("ผู้จับกุม")) {
                                            _arrestMain.ArrestStaff[index]
                                                .ArrestType =
                                                newValue;
                                          }
                                          if (_arrestMain.ArrestStaff[index]
                                              .ArrestType
                                              .endsWith("ผู้จับกุม")) {
                                            for (int i = 0; i <
                                                _arrestMain.ArrestStaff
                                                    .length; i++) {
                                              if (index != i) {
                                                _arrestMain.ArrestStaff[i]
                                                    .ArrestType =
                                                "ผู้ร่วมจับกุม";
                                              }
                                            }
                                          }
                                        });
                                      },
                                      items: _arrestMain.ArrestStaff[index]
                                          .ArrestTypeItems
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value, style: textDataStyle,),
                                        );
                                      })
                                          .toList(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ) : Padding(
                            padding: paddingInputBox,
                            child: Text(
                              _arrestMain.ArrestStaff[index].CONTRIBUTOR_ID ==
                                  14
                                  ? "ผู้จับกุม"
                                  : "ผู้ร่วมจับกุม",
                              style: textDataStyle,),
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

      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //height: 34.0,
                  decoration: BoxDecoration(
                    //color: Colors.grey[200],
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_08_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                ),
                Expanded(
                  child: new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: _onSaved || _onEdited
                        ? _buildContent_saved(context)
                        : _buildContent(),
                  ),
                ),
              ],
            ),
          ),
          _onSaved ? Container()
              : Align(
            alignment: Alignment.bottomRight,
            child: new Padding(padding: EdgeInsets.all(18.0),
              child: FloatingActionButton(
                backgroundColor: Color(0xff087de1),
                onPressed: () {
                  _navigateSearchTab3(context);
                },
                mini: false,
                child: new Icon(Icons.add),
              ),
            ),
          )
        ],
      );
    }

  _navigateEditStaff(BuildContext context, ItemsListArrestStaff items, index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              TabScreenArrest3Create(Items: items,
                IsUpdate: true,
                ItemsMain: _arrestMain,
                itemsTitle: widget.itemsTitle,)),
    );
    if(result.toString()!="Back"){
      if(widget.IsUpdate){
        _arrestMain.ArrestStaff[index] = result;
      }else{
        _itemsDataTab3[index] = result;
      }
    }
    //_arrestMain.ArrestStaff[index] = result;
  }
//************************end_tab_3*******************************

//************************start_tab_4*******************************
  List _id = [];
  List _id_law_previos=[];
  _navigateScreenAddTab4(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest4Add(itemsTitle: widget.itemsTitle,)),
    );
    if(result.toString()!="back"){
      if(_onEdited){
        List items = result;
        _arrestMain.ArrestLawbreaker.forEach((item){
          _id.add(item.PERSON_ID);
          _id_law_previos.add(item.PERSON_ID);
        });
        items.forEach((item){
          _id.add(item.PERSON_ID);
          _arrestMain.ArrestLawbreaker.add(item);
        });
        var _removeDupicate = _id.toSet().toList();
        List ItemsAll=[];
        List ItemsAll1=[];
        for(int i=0;i<_removeDupicate.length;i++){
          for(int j=0;j< _arrestMain.ArrestLawbreaker.length;j++){
            if(_removeDupicate[i]== _arrestMain.ArrestLawbreaker[j].PERSON_ID){
              ItemsAll.add( _arrestMain.ArrestLawbreaker[j]);
              ItemsAll1.add( _arrestMain.ArrestLawbreaker[j]);
              break;
            }
          }
        }
        _arrestMain.ArrestLawbreaker = ItemsAll;

        for(int i=0;i<_id_law_previos.length;i++){
          ItemsAll1.removeWhere((item) => item.PERSON_ID == _id_law_previos[i]);
        }
        list_add_lawbreaker=ItemsAll1;

      }else{
        List items = result;
        //List itemsInit = _itemsDataTab4;
        items.forEach((item){
          _id.add(item.PERSON_ID);
          _itemsDataTab4.add(item);
        });
        var _removeDupicate = _id.toSet().toList();
        print(_removeDupicate);
        List ItemsAll=[];
        for(int i=0;i<_removeDupicate.length;i++){
          for(int j=0;j<_itemsDataTab4.length;j++){
            if(_removeDupicate[i]==_itemsDataTab4[j].PERSON_ID){
              ItemsAll.add(_itemsDataTab4[j]);
              break;
            }
          }
        }
        _itemsDataTab4 = ItemsAll;
      }
    }
    //_itemsDataTab4.add(item);
  }

  ItemsMasterTitleResponse itemsTitle;
  ItemsMasterCountryResponse itemsCountry;
  //on show dialog
  Future<bool> onLoadActionCountryMaster() async {
    Map map_title = {
      "TEXT_SEARCH" : ""
    };
    await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map_title).then((onValue) {
      itemsTitle = onValue;
    });
    Map map_country = {
      "TEXT_SEARCH" : ""
    };
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map_country).then((onValue) {
      itemsCountry = onValue;
    });

    setState(() {});
    return true;
  }
  _navigateCreaet(BuildContext mContext,var itemPerson) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionCountryMaster();
    Navigator.pop(context);

    if(itemsCountry!=null){
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(builder: (context) => TabScreenArrest4Create(
          ItemTitle: itemsTitle,
          ItemCountry: itemsCountry,
          IsUpdate: true,
          ItemsPerson: itemPerson,
          Title: itemPerson.TITLE_SHORT_NAME_TH.toString()+
              itemPerson.FIRST_NAME+" "+itemPerson.LAST_NAME,
        )),
      );
      if(result.toString()!="back"){
        Navigator.pop(context, result);
      }
    }
  }

  Widget _buildContent_tab_4() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _itemsDataTab4.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Container(
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: paddingLabel,
                              child: Text(
                                (_itemsDataTab4[index].TITLE_SHORT_NAME_TH !=
                                    null
                                    ? _itemsDataTab4[index].TITLE_SHORT_NAME_TH
                                    : _itemsDataTab4[index].TITLE_NAME_TH) +
                                    _itemsDataTab4[index].FIRST_NAME + " " +
                                    _itemsDataTab4[index].LAST_NAME,
                                style: textInputStyle,),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              _itemsDataTab4[index].IsCreate
                                  ?Container(
                                padding: EdgeInsets.only(right: 22.0),
                                child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        _navigateCreaet(context,_itemsDataTab4[index]);
                                      },
                                      child: Container(
                                          child: Text(
                                            "แก้ไข", style: textLabelDeleteStyle,)
                                      ),
                                    )
                                ),
                              ):Container(),
                              Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _showDeleteItemsAlertDialog(
                                            index, "Person");
                                      });
                                    },
                                    child: Container(
                                        child: Text(
                                          "ลบ", style: textLabelDeleteStyle,)
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                      _itemsDataTab4[index].MISTREAT_NO != 0
                          ? Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "จำนวนครั้งการกระทำผิด " +
                              _itemsDataTab4[index].MISTREAT_NO
                                  .toString() +
                              " ครั้ง",
                          style: textInputStyleSubCont,),
                      )
                          : Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "ยังไม่เคยกระทำผิด ",
                          style: textInputStyleSubCont,),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _arrestMain.ArrestLawbreaker.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Container(
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: paddingLabel,
                              child: Text(
                                (_arrestMain.ArrestLawbreaker[index]
                                    .TITLE_SHORT_NAME_TH != null
                                    ? _arrestMain.ArrestLawbreaker[index]
                                    .TITLE_SHORT_NAME_TH
                                    : _arrestMain.ArrestLawbreaker[index]
                                    .TITLE_NAME_TH) +
                                    _arrestMain.ArrestLawbreaker[index]
                                        .FIRST_NAME + " " +
                                    _arrestMain.ArrestLawbreaker[index]
                                        .LAST_NAME,
                                style: textInputStyle,),
                            ),
                          ),
                        ],
                      ),
                      _arrestMain.ArrestLawbreaker[index].MISTREAT_NO != 0
                          ? Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "จำนวนครั้งการกระทำผิด " +
                              _arrestMain.ArrestLawbreaker[index].MISTREAT_NO
                                  .toString() +
                              " ครั้ง",
                          style: textInputStyleSubCont,),
                      )
                          : Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "ยังไม่เคยกระทำผิด ",
                          style: textInputStyleSubCont,),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    Widget _buildContent_edited(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _arrestMain.ArrestLawbreaker.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Container(
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: paddingLabel,
                              child: Text(
                                _arrestMain.ArrestLawbreaker[index]
                                    .TITLE_SHORT_NAME_TH+
                                    _arrestMain.ArrestLawbreaker[index]
                                        .FIRST_NAME + " " +
                                    _arrestMain.ArrestLawbreaker[index]
                                        .LAST_NAME,
                                style: textInputStyle,),
                            ),
                          ),
                          _onSaved ? Container()
                              : Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _showDeleteItemsAlertDialog(index,"PersonUp");
                                  });
                                },
                                child: Container(
                                    child: Text(
                                      "ลบ", style: textLabelDeleteStyle,)
                                ),
                              )
                          ),
                        ],
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "จำนวนครั้งการกระทำผิด " +
                              _arrestMain.ArrestLawbreaker[index].MISTREAT_NO
                                  .toString() +
                              " ครั้ง",
                          style: textInputStyleSubCont,),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    //color: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_11_00',
                          style: textStylePageName,),
                      ),
                    ],
                  ),
                  ],
                )*/
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved
                      ? _buildContent_saved(context)
                      : (_onEdited?_buildContent_edited(context):_buildContent()),
                ),
              ),
            ],
          ),
        ),
        !_onSaved?Align(
          alignment: Alignment.bottomRight,
          child:new Padding(padding: EdgeInsets.all(18.0),
            child: FloatingActionButton(
              backgroundColor: Color(0xff087de1),
              onPressed: () {
                _navigateScreenAddTab4(context);
              },
              mini: false,
              child: new Icon(Icons.add),
            ),
          ),
        ):Container()
      ],
    );
  }

  //************************end_tab_4*****************************

  //************************start_tab_5*****************************
  ItemsMasterProductGroupResponse itemsProductGroup;
  //on show dialog
  Future<bool> onLoadActionProductGroupMaster() async {
    Map map= {
      "TEXT_SEARCH": "",
      "PRODUCT_GROUP_ID": ""
    };
    await new ArrestFutureMaster().apiRequestMasProductGroupgetByCon(map).then((onValue) {
      itemsProductGroup = onValue;
    });

    setState(() {});
    return true;
  }
  List _id_pro = [];
  List _id_pro_previos = [];
  _navigateScreenAddTab5(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionProductGroupMaster();
    Navigator.pop(context);

    if(itemsProductGroup!=null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest5Add(IsUpdate: false,ItemsProductGroup: itemsProductGroup,)),
      );
      if(result.toString()!="back"){
        if (_onEdited) {
          List items = result;
          _arrestMain.ArrestProduct.forEach((item){
            _id_pro.add(item.PRODUCT_MAPPING_ID);
            _id_pro_previos.add(item.PRODUCT_MAPPING_ID);
          });
          items.forEach((item){
            _id_pro.add(item.PRODUCT_MAPPING_ID);
            _arrestMain.ArrestProduct.add(item);
          });
          //print("AA : "+_id_pro_previos.length.toString());
          var _removeDupicate = _id_pro.toSet().toList();
          List ItemsAll=[];
          List ItemsAll1=[];
          for(int i=0;i<_removeDupicate.length;i++){
            for(int j=0;j<  _arrestMain.ArrestProduct.length;j++){
              if(_removeDupicate[i] ==  _arrestMain.ArrestProduct[j].PRODUCT_MAPPING_ID){
                ItemsAll.add(  _arrestMain.ArrestProduct[j]);
                ItemsAll1.add(  _arrestMain.ArrestProduct[j]);
                break;
              }
            }
          }
          _arrestMain.ArrestProduct = ItemsAll;
          for(int i=0;i<_id_pro_previos.length;i++){
            ItemsAll1.removeWhere((item) => item.PRODUCT_MAPPING_ID == _id_pro_previos[i]);
          }
          list_add_product=ItemsAll1;

        } else {
          List items = result;
          items.forEach((item){
            _id_pro.add(item.PRODUCT_MAPPING_ID);
            _itemsDataTab5.add(item);
          });
          var _removeDupicate = _id_pro.toSet().toList();
          List ItemsAll=[];
          for(int i=0;i<_removeDupicate.length;i++){
            for(int j=0;j<_itemsDataTab5.length;j++){
              if(_removeDupicate[i]==_itemsDataTab5[j].PRODUCT_MAPPING_ID){
                ItemsAll.add(_itemsDataTab5[j]);
                break;
              }
            }
          }
          _itemsDataTab5 = ItemsAll;
        }
      }
    }
  }

  _navigateScreenEditTab5(BuildContext context,int index) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionProductGroupMaster();
    Navigator.pop(context);

    if(itemsProductGroup!=null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest5Add(IsUpdate: true,ItemsProductGroup: itemsProductGroup)),
      );
      if(result.toString()!="back"){
        if (_onEdited) {
          List items = result;
          items.forEach((item) {
            item.PRODUCT_ID = _arrestMain.ArrestProduct[index].PRODUCT_ID;
            list_update_product.add(item);
            _arrestMain.ArrestProduct[index] = item;
          });
        } else {
          List items = result;
          print(index.toString() + " , " + items.toString());
          items.forEach((item) {
            _itemsDataTab5[index] = item;
          });
        }
      }
    }
  }

  Widget _buildContent_tab_5() {
    Widget _buildContent() {
      var size = MediaQuery
          .of(context)
          .size;
      return ListView.builder(
        itemCount: _itemsDataTab5.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    //color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
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
                          child: Text("ชื่อของกลาง", style: textLabelStyle,),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingInputBox,
                                child: Text(
                                  (index + 1).toString() + ". " +
                                      (_itemsDataTab5[index].PRODUCT_GROUP_NAME != null
                                          ? (_itemsDataTab5[index].PRODUCT_GROUP_NAME
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].PRODUCT_CATEGORY_NAME != null
                                          ? (_itemsDataTab5[index].PRODUCT_CATEGORY_NAME
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].PRODUCT_TYPE_NAME != null
                                          ? (_itemsDataTab5[index].PRODUCT_TYPE_NAME
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].PRODUCT_BRAND_NAME_TH != null
                                          ? (_itemsDataTab5[index].PRODUCT_BRAND_NAME_TH
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].PRODUCT_BRAND_NAME_EN != null
                                          ? (_itemsDataTab5[index].PRODUCT_BRAND_NAME_EN
                                          .toString() + ' ')
                                          : '') +

                                      (_itemsDataTab5[index].PRODUCT_SUBBRAND_NAME_TH != null
                                          ? (_itemsDataTab5[index].PRODUCT_SUBBRAND_NAME_TH
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].PRODUCT_SUBBRAND_NAME_EN != null
                                          ? (_itemsDataTab5[index].PRODUCT_SUBBRAND_NAME_EN
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].PRODUCT_MODEL_NAME_TH != null
                                          ? (_itemsDataTab5[index].PRODUCT_MODEL_NAME_TH
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].PRODUCT_MODEL_NAME_EN != null
                                          ? (_itemsDataTab5[index].PRODUCT_MODEL_NAME_EN
                                          .toString() + ' ')
                                          : '') +
                                      (_itemsDataTab5[index].DEGREE != null
                                          ? (_itemsDataTab5[index].DEGREE.toString() +
                                          ' ดีกรี ')
                                          : ' ') +
                                      _itemsDataTab5[index].SIZES.toString() + ' ' +
                                      _itemsDataTab5[index].SIZES_UNIT.toString(),
                                  style: textInputStyle,),
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
                                    child: Text(
                                      "ขนาดบรรจุ", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      formatter.format(_itemsDataTab5[index].SIZES).toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].SIZES_UNIT,
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "จำนวน", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].QUANTITY.toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].QUANTITY_UNIT,
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "ปริมาณสุทธิ", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      formatter.format(_itemsDataTab5[index].VOLUMN).toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].VOLUMN_UNIT,
                                      style: textInputStyle,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    bottom: 12.0, top: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    _navigateScreenEditTab5(context,index);
                                  },
                                  child: Container(
                                      child: Text("แก้ไข",
                                        style: textLabelDeleteStyle,)
                                  ),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    bottom: 12.0, top: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showDeleteItemsAlertDialog(index,"Product");
                                    });
                                  },
                                  child: Container(
                                      child: Text("ลบ",
                                        style: textLabelDeleteStyle,)
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
            ),
          );
        },
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return ListView.builder(
        itemCount: _arrestMain.ArrestProduct.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    //color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
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
                          child: Text("ชื่อของกลาง", style: textLabelStyle,),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingInputBox,
                                child: Text(
                                  (index + 1).toString() + ". " +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_GROUP_NAME != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_GROUP_NAME
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_CATEGORY_NAME != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_CATEGORY_NAME
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_TYPE_NAME != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_TYPE_NAME
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_BRAND_NAME_TH != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_BRAND_NAME_TH
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_BRAND_NAME_EN != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_BRAND_NAME_EN
                                          .toString() + ' ')
                                          : '') +

                                      (_arrestMain.ArrestProduct[index].PRODUCT_SUBBRAND_NAME_TH != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_SUBBRAND_NAME_TH
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_SUBBRAND_NAME_EN != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_SUBBRAND_NAME_EN
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_MODEL_NAME_TH != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_MODEL_NAME_TH
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].PRODUCT_MODEL_NAME_EN != null
                                          ? (_arrestMain.ArrestProduct[index].PRODUCT_MODEL_NAME_EN
                                          .toString() + ' ')
                                          : '') +
                                      (_arrestMain.ArrestProduct[index].DEGREE != null
                                          ? (_arrestMain.ArrestProduct[index].DEGREE.toString() +
                                          ' ดีกรี ')
                                          : ' ') +
                                      _arrestMain.ArrestProduct[index].SIZES.toString() + ' ' +
                                      _arrestMain.ArrestProduct[index].SIZES_UNIT.toString(),
                                  style: textInputStyle,),
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
                                    child: Text(
                                      "ขนาดบรรจุ", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      formatter.format(_arrestMain.ArrestProduct[index].SIZES)
                                          .toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _arrestMain.ArrestProduct[index]
                                          .SIZES_UNIT,
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "จำนวน", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _arrestMain.ArrestProduct[index].QUANTITY.toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _arrestMain.ArrestProduct[index]
                                          .QUANTITY_UNIT,
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "ปริมาณสุทธิ", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      formatter.format(_arrestMain.ArrestProduct[index].VOLUMN)
                                          .toString(),
                                      style: textInputStyle,),
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
                                    child: Text(
                                      "หน่วย", style: textLabelStyle,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _arrestMain.ArrestProduct[index]
                                          .VOLUMN_UNIT,
                                      style: textInputStyle,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _onSaved ? Container()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    bottom: 12.0, top: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    _navigateScreenEditTab5(context,index);
                                  },
                                  child: Container(
                                      child: Text("แก้ไข",
                                        style: textLabelDeleteStyle,)
                                  ),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    bottom: 12.0, top: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showDeleteItemsAlertDialog(index,"ProductUp");
                                    });
                                  },
                                  child: Container(
                                      child: Text("ลบ",
                                        style: textLabelDeleteStyle,)
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
            ),
          );
        },
      );
    }
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                  //color: Colors.grey[200],
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
                          child: new Text('ILG60_B_01_00_19_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved||_onEdited
                      ? _buildContent_saved(context)
                      : _buildContent(),
                ),
              ),
            ],
          ),
        ),
        _onSaved ? Container()
            : Align(
          alignment: Alignment.bottomRight,
          child: new Padding(padding: EdgeInsets.all(18.0),
            child: FloatingActionButton(
              backgroundColor: Color(0xff087de1),
              onPressed: () {
                _navigateScreenAddTab5(context);
              },
              mini: false,
              child: new Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }

  //************************start_tab_6*****************************
  _navigateSearchSelection(BuildContext context,List ItemLawbreaker,List ItemProduct,) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          TabScreenArrest6Search(
            ItemsLawbreaker: ItemLawbreaker, ItemsProduct: ItemProduct,IsUpdate: false,)),
    );
    if (result.toString() != "back") {
      if (_onEdited) {
        var items = result;
        _arrestMain.ArrestIndictment.add(items);
        list_add_indicment.add(items);
      } else {
        print(result.toString());
        //_itemsDataTab5 = result;

        setState(() {
          IsSelected_tab6 = true;
          ItemsListArrest6Section item = result;
          _itemsInitTab6.add(item);

          String textLawsuitBreaker = "";
          String Evidence = "";
          String Section = "";
          int counts = 0;

          if(widget.IsUpdate){
            if (_arrestMain.ArrestIndictment.length > 0) {
              _arrestMain.ArrestIndictment.forEach((f){
                counts+=f.ArrestIndictmentDetail.length;
              });
              textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " +
                  counts.toString() + " คน คือ ";
              Evidence = "พร้อมได้ยึดของกลาง ดังนี้ ";
              Section = "ในข้อกล่าวหา ";
              _itemsInitTab6.forEach((item) {
                item.ArrestIndictmentDetail.forEach((item) {
                  textLawsuitBreaker +=
                      item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " +
                          item.LAST_NAME + " ";
                });
                item.ArrestIndictmentProduct.forEach((item) {
                  Evidence += item.PRODUCT_CATEGORY_NAME + '/' +
                      item.PRODUCT_TYPE_NAME + '/' +
                      item.PRODUCT_BRAND_NAME_TH +
                      " จำนวน " + item.QUANTITY.toString() + " " +
                      item.QUANTITY_UNIT +
                      " ปริมาณสุทธิ " + item.VOLUMN.toString() + " " +
                      item.VOLUMN_UNIT + ", ";
                });
                Section += item.GUILTBASE_NAME;
              });
              setBehavior(textLawsuitBreaker + Evidence + Section);
            }
          }else{
            if (_itemsInitTab6.length > 0) {
              _itemsInitTab6.forEach((f){
                counts+=f.ArrestIndictmentDetail.length;
              });
              textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " +
                  counts.toString() + " คน คือ ";
              Evidence = "พร้อมได้ยึดของกลาง ดังนี้ ";
              Section = "ในข้อกล่าวหา ";
              _itemsInitTab6.forEach((item) {
                item.ArrestIndictmentDetail.forEach((item) {
                  textLawsuitBreaker +=
                      item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " +
                          item.LAST_NAME + " ";
                });
                item.ArrestIndictmentProduct.forEach((item) {
                  Evidence +=
                          (item.PRODUCT_GROUP_NAME != null
                              ? (item.PRODUCT_GROUP_NAME
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_CATEGORY_NAME != null
                              ? (item.PRODUCT_CATEGORY_NAME
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_TYPE_NAME != null
                              ? (item.PRODUCT_TYPE_NAME
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_BRAND_NAME_TH != null
                              ? (item.PRODUCT_BRAND_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_BRAND_NAME_EN != null
                              ? (item.PRODUCT_BRAND_NAME_EN
                              .toString() + ' ')
                              : '') +

                          (item.PRODUCT_SUBBRAND_NAME_TH != null
                              ? (item.PRODUCT_SUBBRAND_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_SUBBRAND_NAME_EN != null
                              ? (item.PRODUCT_SUBBRAND_NAME_EN
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_MODEL_NAME_TH != null
                              ? (item.PRODUCT_MODEL_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_MODEL_NAME_EN != null
                              ? (item.PRODUCT_MODEL_NAME_EN
                              .toString() + ' ')
                              : '') +
                          (item.DEGREE != null
                              ? (item.DEGREE.toString() +
                              ' ดีกรี ')
                              : ' ') +
                          item.SIZES.toString() + ' ' +
                          item.SIZES_UNIT.toString()+

                      " จำนวน " + item.QUANTITY.toString() + " " +
                      item.QUANTITY_UNIT +
                      " ปริมาณสุทธิ " + item.VOLUMN.toString() + " " +
                      item.VOLUMN_UNIT + ", ";
                });
                Section += item.GUILTBASE_NAME;
              });
              setBehavior(textLawsuitBreaker + Evidence + Section);
            }
          }

        });
      }
    }
  }
  _navigateSearchSelectionEdit(BuildContext context,index,itemLawbreaker,itemsProduct) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest6Search(ItemsLawbreaker: itemLawbreaker,ItemsProduct: itemsProduct,IsUpdate: true,)),
    );
    if (result.toString() != "back") {
      setState(() {
        if(_onEdited){
          _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.forEach((item) {
            print(item.INDICTMENT_ID);
            list_delete_indicment_delt.add(item.INDICTMENT_DETAIL_ID);
          });
          var item = result;
          /*List Checked = [];
          item.ArrestIndictmentDetail.forEach((item) {
            *//*if(item.IsCheckOffence){
              Checked.add(item.INDICTMENT_ID);
            }*//*
            for(int i=0;i<_arrestMain.ArrestLawbreaker.length;i++){
              if(item.IsCheckOffence){
                if(item.LAWBREAKER_ID==_arrestMain.ArrestLawbreaker[i].LAWBREAKER_ID){
                  if(_arrestMain.ArrestLawbreaker[i].IsCheckOffence){
                    Checked.add(item.LAWBREAKER_ID);
                    print("Match : "+item.LAWBREAKER_ID.toString());
                    break;
                  }else{
                    print("Don't Check : "+item.LAWBREAKER_ID.toString());
                  }
                }else{
                  print("Non-Match : "+item.LAWBREAKER_ID.toString());
                }
              }
            }
          });*/

          item.INDICTMENT_ID= _arrestMain.ArrestIndictment[index].INDICTMENT_ID;
          _arrestMain.ArrestIndictment[index]=item;
          list_update_indicment.add(_arrestMain.ArrestIndictment[index]);

          String textLawsuitBreaker = "";
          String Evidence = "";
          String Section = "";
          if (_arrestMain.ArrestIndictment.length > 0) {
            textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " +
                _arrestMain.ArrestLawbreaker.length.toString() + " คน คือ ";
            Evidence = "พร้อมได้ยึดของกลาง ดังนี้ ";
            Section = "ในข้อกล่าวหา ";
            _arrestMain.ArrestIndictment.forEach((item) {
              item.ArrestIndictmentDetail.forEach((item) {
                textLawsuitBreaker +=
                    item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " +
                        item.LAST_NAME + " ";
              });
              item.ArrestIndictmentProduct.forEach((item) {
                Evidence += item.PRODUCT_CATEGORY_NAME + '/' +
                    item.PRODUCT_TYPE_NAME + '/' +
                    item.PRODUCT_BRAND_NAME_TH +
                    " จำนวน " + item.QUANTITY.toString() + " " +
                    item.QUANTITY_UNIT +
                    " ปริมาณสุทธิ " + item.VOLUMN.toString() + " " +
                    item.VOLUMN_UNIT + ", ";
              });
              Section += item.GUILTBASE_NAME;
            });
            setBehavior(textLawsuitBreaker + Evidence + Section);
          }
        }else{
          IsSelected_tab6 = true;
          var item = result;
          _itemsInitTab6[index]=item;

          String textLawsuitBreaker = "";
          String Evidence = "";
          String Section = "";
          if (_itemsInitTab6.length > 0) {
            textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " +
                _itemsDataTab4.length.toString() + " คน คือ ";
            Evidence = "พร้อมได้ยึดของกลาง ดังนี้ ";
            Section = "ในข้อกล่าวหา ";
            _itemsInitTab6.forEach((item) {
              item.ArrestIndictmentDetail.forEach((item) {
                textLawsuitBreaker +=
                    item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " +
                        item.LAST_NAME + " ";
              });
              item.ArrestIndictmentProduct.forEach((item) {
                Evidence += item.PRODUCT_CATEGORY_NAME + '/' +
                    item.PRODUCT_TYPE_NAME + '/' +
                    item.PRODUCT_BRAND_NAME_TH +
                    " จำนวน " + item.QUANTITY.toString() + " " +
                    item.QUANTITY_UNIT +
                    " ปริมาณสุทธิ " + item.VOLUMN.toString() + " " +
                    item.VOLUMN_UNIT + ", ";
              });
              Section += item.GUILTBASE_NAME;
            });
            setBehavior(textLawsuitBreaker + Evidence + Section);
          }
        }

      });
    }
  }

  Widget _buildContent_tab_6() {
    Widget _buildContent() {
      buildCollapsed(index) {
        String suspect = "";
        String subSuspect = "";
        if (_itemsInitTab6[index].ArrestIndictmentDetail.length > 0) {
          suspect = _itemsInitTab6[index].ArrestIndictmentDetail[0]
              .TITLE_SHORT_NAME_TH +
              _itemsInitTab6[index].ArrestIndictmentDetail[0]
                  .FIRST_NAME + " " +
              _itemsInitTab6[index].ArrestIndictmentDetail[0]
                  .LAST_NAME;
          if (_itemsInitTab6[index].ArrestIndictmentDetail.length == 2) {
            subSuspect += _itemsInitTab6[index].ArrestIndictmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _itemsInitTab6[index].ArrestIndictmentDetail[1]
                    .FIRST_NAME + " " +
                _itemsInitTab6[index].ArrestIndictmentDetail[1]
                    .LAST_NAME;
          } else if (_itemsInitTab6[index].ArrestIndictmentDetail.length > 2) {
            subSuspect += _itemsInitTab6[index].ArrestIndictmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _itemsInitTab6[index].ArrestIndictmentDetail[1]
                    .FIRST_NAME + " " +
                _itemsInitTab6[index].ArrestIndictmentDetail[1]
                    .LAST_NAME + " และคนอื่นๆ " +
                (_itemsInitTab6[index].ArrestIndictmentDetail.length - 2)
                    .toString() + " คน";
          }
        } else {
          suspect = "-";
        }


        return Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        "ฐานความผิดมาตรา " +
                            _itemsInitTab6[index].SUBSECTION_NAME,
                        style: textDataTitleStyle,),
                    ),
                  ),
                  IsSelected_tab6 ? Column(
                    children: <Widget>[
                      Center(
                          child: InkWell(
                            onTap: () {
                              _itemsInitTab6[index].ArrestIndictmentDetail
                                  .forEach((f) {
                                for (int i = 0; i <
                                    _itemsInitTab6[index].ArrestIndictmentDetail
                                        .length; i++) {
                                  if (f.LAWBREAKER_ID == _itemsInitTab6[index]
                                      .ArrestIndictmentDetail[i]
                                      .LAWBREAKER_ID) {
                                    _itemsInitTab6[index]
                                        .ArrestIndictmentDetail[i]
                                        .IsCheckOffence = true;
                                    break;
                                  }
                                }
                              });
                              _navigateSearchSelectionEdit(context, index,
                                  _itemsInitTab6[index].ArrestIndictmentDetail,
                                  _itemsInitTab6[index]
                                      .ArrestIndictmentProduct);
                            },
                            child: Container(
                                child: Text("แก้ไข",
                                  style: textLabelDeleteStyle,)
                            ),
                          )
                      ),
                    ],
                  ) : Container()
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  !IsSelected_tab6
                      ? Icon(Icons.arrow_forward_ios,
                    color: Colors.grey[300], size: 18,)
                      : Container(),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        _itemsInitTab6[index]
                            .GUILTBASE_NAME,
                        style: textDataStyleSub,),
                    ),
                  ),
                  IsSelected_tab6 ? Center(
                      child: InkWell(
                        onTap: () {
                          _showDeleteItemsAlertDialog(index, "Indicment");
                        },
                        child: Container(
                            child: Text("ลบ",
                              style: textLabelDeleteStyle,)
                        ),
                      )
                  ) : Container(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ผู้ต้องหา", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(suspect,
                      style: textDataStyle,),
                  ),
                  _itemsInitTab6[index].ArrestIndictmentDetail.length > 1
                      ? Container(
                    padding: paddingInputBox,
                    child: Text(subSuspect,
                      style: textDataSubStyle,),
                  )
                      : Container(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ของกลาง ", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(_itemsInitTab6[index]
                        .ArrestIndictmentProduct.length > 0
                        ? _itemsInitTab6[index]
                        .ArrestIndictmentProduct.length.toString() +
                        " รายการ"
                        : "-", style: textDataSubStyle,),
                  ),
                ],
              ),
            ],
          ),
        );
      }

      buildExpanded(index) {
        var size = MediaQuery
            .of(context)
            .size;
        return Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        "ฐานความผิดมาตรา " +
                            _itemsInitTab6[index].SUBSECTION_NAME,
                        style: textDataTitleStyle,),
                    ),
                  ),
                  IsSelected_tab6 ? Column(
                    children: <Widget>[
                      Center(
                          child: InkWell(
                            onTap: () {
                              _itemsInitTab6[index].ArrestIndictmentDetail
                                  .forEach((f) {
                                for (int i = 0; i <
                                    _itemsInitTab6[index].ArrestIndictmentDetail
                                        .length; i++) {
                                  if (f.LAWBREAKER_ID == _itemsInitTab6[index]
                                      .ArrestIndictmentDetail[i]
                                      .LAWBREAKER_ID) {
                                    _itemsInitTab6[index]
                                        .ArrestIndictmentDetail[i]
                                        .IsCheckOffence = true;
                                    break;
                                  }
                                }
                              });
                              _navigateSearchSelectionEdit(context, index,
                                  _itemsInitTab6[index].ArrestIndictmentDetail,
                                  _itemsInitTab6[index]
                                      .ArrestIndictmentProduct);
                            },
                            child: Container(
                                child: Text("แก้ไข",
                                  style: textLabelDeleteStyle,)
                            ),
                          )
                      ),
                    ],
                  ) : Container()
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        _itemsInitTab6[index]
                            .GUILTBASE_NAME,
                        style: textDataStyleSub,),
                    ),
                  ),
                  IsSelected_tab6 ? Center(
                      child: InkWell(
                        onTap: () {
                          _showDeleteItemsAlertDialog(index, "Indicment");
                        },
                        child: Container(
                            child: Text("ลบ",
                              style: textLabelDeleteStyle,)
                        ),
                      )
                  ) : Container(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ผู้ต้องหา", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // new
                        itemCount: _itemsInitTab6[index]
                            .ArrestIndictmentDetail.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int j) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: paddingInputBox,
                                child: Text((j + 1).toString() + ". " +
                                    _itemsInitTab6[index]
                                        .ArrestIndictmentDetail[j]
                                        .TITLE_SHORT_NAME_TH +
                                    _itemsInitTab6[index]
                                        .ArrestIndictmentDetail[j]
                                        .FIRST_NAME + " " +
                                    _itemsInitTab6[index]
                                        .ArrestIndictmentDetail[j]
                                        .LAST_NAME,
                                  style: textDataStyle,),
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ของกลาง", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // new
                        itemCount: _itemsInitTab6[index]
                            .ArrestIndictmentProduct.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int j) {
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
                                              ItemsProductEdit: _itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j],
                                              IsComplete: false,
                                            )),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: paddingInputBoxSub,
                                        child: Text(
                                          (j + 1).toString() + ". " +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_GROUP_NAME != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_GROUP_NAME
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_CATEGORY_NAME != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_CATEGORY_NAME
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_TYPE_NAME != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_TYPE_NAME
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_BRAND_NAME_TH != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_BRAND_NAME_TH
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_BRAND_NAME_EN != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_BRAND_NAME_EN
                                                  .toString() + ' ')
                                                  : '') +

                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_SUBBRAND_NAME_TH !=
                                                  null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_SUBBRAND_NAME_TH
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_SUBBRAND_NAME_EN !=
                                                  null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_SUBBRAND_NAME_EN
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_MODEL_NAME_TH != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_MODEL_NAME_TH
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_MODEL_NAME_EN != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .PRODUCT_MODEL_NAME_EN
                                                  .toString() + ' ')
                                                  : '') +
                                              (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .DEGREE != null
                                                  ? (_itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .DEGREE.toString() +
                                                  ' ดีกรี ')
                                                  : ' ') +
                                              _itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .SIZES.toString() + ' ' +
                                              _itemsInitTab6[index]
                                                  .ArrestIndictmentProduct[j]
                                                  .SIZES_UNIT.toString(),
                                          style: textDataStyle,),
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
          ),
        );
      }
      return _onSaved ? Container()
          : (_itemsInitTab6.length > 0
          ? new Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          itemCount: _itemsInitTab6.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  //color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: index==0
                        ?Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                        :Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: ExpandableNotifier(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expandable(
                        collapsed: buildCollapsed(index),
                        expanded: buildExpanded(index),
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
              ),
            );
          },
        ),
      )
          :
      ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              _onEdited
                  ? _navigateSelection_top(context, 'ฐานความผิดมาตรา ' +
                  widget.ItemsGuiltbase[index].SUBSECTION_NAME,
                  widget.ItemsGuiltbase[index],
                  _arrestMain.ArrestLawbreaker,
                  _arrestMain.ArrestProduct)
                  :_navigateSelection_top(context, 'ฐานความผิดมาตรา ' +
                  widget.ItemsGuiltbase[index].SUBSECTION_NAME,
                  widget.ItemsGuiltbase[index],
                  _itemsDataTab4,
                  _itemsDataTab5);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                  //color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: index==0
                        ?Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                        :Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    ListTile(
                      title: Container(
                        padding: paddingLabel,
                        child: Text('ฐานความผิดมาตรา ' +
                            widget.ItemsGuiltbase[index].SUBSECTION_NAME,
                          style: textInputStyleTitle,),
                      ),
                      subtitle: Padding(
                        padding: paddingInputBox,
                        child: Text(
                          widget.ItemsGuiltbase[index].GUILTBASE_NAME,
                          style: textInputStyleSub,),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[400],
                        size: 18,),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      buildCollapsed(index) {
        String suspect = "";
        String subSuspect = "";
        if (_arrestMain.ArrestIndictment[index]
            .ArrestIndictmentDetail.length > 0) {
          suspect = _arrestMain.ArrestIndictment[index]
              .ArrestIndictmentDetail[0]
              .TITLE_SHORT_NAME_TH +
              _arrestMain.ArrestIndictment[index]
                  .ArrestIndictmentDetail[0]
                  .FIRST_NAME + " " +
              _arrestMain.ArrestIndictment[index]
                  .ArrestIndictmentDetail[0]
                  .LAST_NAME;

          if (_arrestMain.ArrestIndictment[index]
              .ArrestIndictmentDetail.length == 2) {
            subSuspect += _arrestMain.ArrestIndictment[index]
                .ArrestIndictmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _arrestMain.ArrestIndictment[index]
                    .ArrestIndictmentDetail[1]
                    .FIRST_NAME + " " +
                _arrestMain.ArrestIndictment[index]
                    .ArrestIndictmentDetail[1]
                    .LAST_NAME;
          } else if (_arrestMain.ArrestIndictment[index]
              .ArrestIndictmentDetail.length > 2) {
            subSuspect += _arrestMain.ArrestIndictment[index]
                .ArrestIndictmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _arrestMain.ArrestIndictment[index]
                    .ArrestIndictmentDetail[1]
                    .FIRST_NAME + " " +
                _arrestMain.ArrestIndictment[index]
                    .ArrestIndictmentDetail[1]
                    .LAST_NAME + " และคนอื่นๆ " +
                (_arrestMain.ArrestIndictment[index]
                    .ArrestIndictmentDetail.length - 2).toString() + " คน";
          }
        } else {
          suspect = "-";
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      "ฐานความผิดมาตรา " +
                          _arrestMain.ArrestIndictment[index].SUBSECTION_NAME,
                      style: textDataTitleStyle,),
                  ),
                ),
                _onEdited ? Column(
                  children: <Widget>[
                    Center(
                        child: InkWell(
                          onTap: () {
                            _arrestMain.ArrestIndictment[index]
                                .ArrestIndictmentDetail.forEach((f) {
                              for (int i = 0; i <
                                  _arrestMain.ArrestLawbreaker.length; i++) {
                                if (f.LAWBREAKER_ID ==
                                    _arrestMain.ArrestLawbreaker[i]
                                        .LAWBREAKER_ID) {
                                  _arrestMain.ArrestLawbreaker[i]
                                      .IsCheckOffence = true;
                                  break;
                                }
                              }
                            });
                            _navigateSearchSelectionEdit(
                                context, index, _arrestMain.ArrestLawbreaker,
                                _arrestMain.ArrestProduct);
                          },
                          child: Container(
                              child: Text("แก้ไข",
                                style: textLabelDeleteStyle,)
                          ),
                        )
                    ),
                  ],
                ) : Container(),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _arrestMain.ArrestIndictment[index]
                          .GUILTBASE_NAME,
                      style: textDataStyleSub,),
                  ),
                ),
                _onEdited ? Center(
                    child: InkWell(
                      onTap: () {
                        _showDeleteItemsAlertDialog(index, "IndicmentUp");
                      },
                      child: Container(
                          child: Text("ลบ",
                            style: textLabelDeleteStyle,)
                      ),
                    )
                ) : Container(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text("ผู้ต้องหา", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingInputBox,
                  child: Text(suspect,
                    style: textDataStyle,),
                ),
                _arrestMain.ArrestIndictment[index]
                    .ArrestIndictmentDetail.length > 1 ? Container(
                  padding: paddingInputBox,
                  child: Text(subSuspect,
                    style: textDataSubStyle,),
                )
                    : Container(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text("ของกลาง ", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(_arrestMain.ArrestIndictment[index]
                      .ArrestIndictmentProduct.length > 0 ? _arrestMain
                      .ArrestIndictment[index]
                      .ArrestIndictmentProduct.length.toString() +
                      " รายการ" : "-", style: textDataSubStyle,),
                ),
              ],
            ),
          ],
        );
      }

      buildExpanded(index) {
        EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      "ฐานความผิดมาตรา " +
                          _arrestMain.ArrestIndictment[index].SUBSECTION_NAME,
                      style: textDataTitleStyle,),
                  ),
                ),
                _onEdited ? Column(
                  children: <Widget>[
                    Center(
                        child: InkWell(
                          onTap: () {
                            _arrestMain.ArrestIndictment[index]
                                .ArrestIndictmentDetail.forEach((f) {
                              for (int i = 0; i <
                                  _arrestMain.ArrestLawbreaker.length; i++) {
                                print(f.LAWBREAKER_ID.toString() + "==" +
                                    _arrestMain.ArrestLawbreaker[i]
                                        .LAWBREAKER_ID.toString());
                                if (f.LAWBREAKER_ID ==
                                    _arrestMain.ArrestLawbreaker[i]
                                        .LAWBREAKER_ID) {
                                  _arrestMain.ArrestLawbreaker[i]
                                      .IsCheckOffence = true;
                                  break;
                                }
                              }
                            });
                            _navigateSearchSelectionEdit(
                                context, index, _arrestMain.ArrestLawbreaker,
                                _arrestMain.ArrestProduct);
                          },
                          child: Container(
                              child: Text("แก้ไข",
                                style: textLabelDeleteStyle,)
                          ),
                        )
                    ),
                  ],
                ) : Container(),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _arrestMain.ArrestIndictment[index]
                          .GUILTBASE_NAME,
                      style: textDataStyleSub,),
                  ),
                ),
                _onEdited ? Center(
                    child: InkWell(
                      onTap: () {
                        _showDeleteItemsAlertDialog(index, "IndicmentUp");
                      },
                      child: Container(
                          child: Text("ลบ",
                            style: textLabelDeleteStyle,)
                      ),
                    )
                ) : Container(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text("ผู้ต้องหา", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingLabel,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // new
                      itemCount: _arrestMain.ArrestIndictment[index]
                          .ArrestIndictmentDetail.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int j) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: paddingInputBox,
                              child: Text((j + 1).toString() + ". " +
                                  _arrestMain.ArrestIndictment[index]
                                      .ArrestIndictmentDetail[j]
                                      .TITLE_SHORT_NAME_TH +
                                  _arrestMain.ArrestIndictment[index]
                                      .ArrestIndictmentDetail[j]
                                      .FIRST_NAME + " " +
                                  _arrestMain.ArrestIndictment[index]
                                      .ArrestIndictmentDetail[j]
                                      .LAST_NAME,
                                style: textDataStyle,),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text("ของกลาง", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingLabel,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // new
                      itemCount: _arrestMain.ArrestIndictment[index]
                          .ArrestIndictmentProduct.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int j) {
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
                                            ItemsProduct: _arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j],
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
                                      padding: paddingInputBoxSub,
                                      child: Text(
                                        (j + 1).toString() + ". " +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_GROUP_NAME != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_GROUP_NAME
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_CATEGORY_NAME != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_CATEGORY_NAME
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_TYPE_NAME != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_TYPE_NAME
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_BRAND_NAME_TH != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_BRAND_NAME_TH
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_BRAND_NAME_EN != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_BRAND_NAME_EN
                                                .toString() + ' ')
                                                : '') +

                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_SUBBRAND_NAME_TH !=
                                                null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_SUBBRAND_NAME_TH
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_SUBBRAND_NAME_EN !=
                                                null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_SUBBRAND_NAME_EN
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_MODEL_NAME_TH != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_MODEL_NAME_TH
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_MODEL_NAME_EN != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .PRODUCT_MODEL_NAME_EN
                                                .toString() + ' ')
                                                : '') +
                                            (_arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .DEGREE != null
                                                ? (_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .DEGREE.toString() +
                                                ' ดีกรี ')
                                                : ' ') +
                                            _arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .SIZES.toString() + ' ' +
                                            _arrestMain.ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]
                                                .SIZES_UNIT.toString(),
                                        style: textDataStyle,),
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
      return ListView.builder(
        itemCount: _arrestMain.ArrestIndictment.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(/*top: 4.0, */ bottom: 4.0),
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: index==0
                      ?Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
                      :Border(
                    //top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: ExpandableNotifier(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expandable(
                      collapsed: buildCollapsed(index),
                      expanded: buildExpanded(index),
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
            ),
          );
        },
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //height: 34.0,
              decoration: BoxDecoration(
                //color: Colors.grey[200],
                  border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                children: <Widget>[Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /*Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_22_00',
                          style: textStylePageName,),
                      ),*/
                  ],
                ),
                  _onSaved ? Container()
                      : Container(
                    //width: itemWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Card(
                        elevation: 0.0,
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: new GestureDetector(
                          onTap: () {
                            _onEdited ?
                            _navigateSearchSelection(
                                context, _arrestMain.ArrestLawbreaker,
                                _arrestMain.ArrestProduct)
                                : _navigateSearchSelection(
                                context, _itemsDataTab4, _itemsDataTab5);
                          },
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('ค้นหาข้อกล่าวหา', style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[500],
                                    fontFamily: FontStyles().FontFamily),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
          _onSaved ? Container()
              : (_itemsInitTab6.length == 0
              ? Container(
            padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 12.0),
            child: Text(
              'ข้อกล่าวหาที่ใช้งานมากที่สุด', style: textStyleTitle,),
          ) : Container()),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: _onSaved || _onEdited
                  ? _buildContent_saved(context)
                  : _buildContent(),
            ),
          ),
        ],
      ),
    );
  }
  _navigateSelection_top(BuildContext context, String title,ItemsListArrest6Section itemMain,List ItemLawbreaker,List ItemProduct,) async {
    var result;
    print(ItemLawbreaker.length.toString()+" , "+ItemProduct.length.toString());
    if(ItemLawbreaker.length==0&&ItemProduct.length>0){
      itemMain.ArrestIndictmentDetail = [];
      result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabScreenArrest6Evidence(
          IsUpdate:false,
          Title: title,
          ItemsData: itemMain,
          ItemsProduct: ItemProduct,)),
      );
    }else{
      result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            TabScreenArrest6Section(
              Title: title,
              ItemsLawbreaker: ItemLawbreaker,
              ItemsProduct: ItemProduct,
              ItemsSection: itemMain,
              IsUpdate: false,)),
      );
    }
    //_itemsData=result;
    //Navigator.pop(context);
    if (result.toString() != "back") {
      if (_onEdited) {
        var items = result;
        _arrestMain.ArrestIndictment.add(items);
        list_add_indicment.add(items);
      } else {
        print(result.toString());
        //_itemsDataTab5 = result;

        setState(() {
          IsSelected_tab6 = true;
          ItemsListArrest6Section item = result;
          _itemsInitTab6.add(item);

          String textLawsuitBreaker = "";
          String Evidence = "";
          String Section = "";
          int counts = 0;

          if(widget.IsUpdate){
            if (_arrestMain.ArrestIndictment.length > 0) {
              _arrestMain.ArrestIndictment.forEach((f){
                counts+=f.ArrestIndictmentDetail.length;
              });
              textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " +
                  counts.toString() + " คน คือ ";
              Evidence = "พร้อมได้ยึดของกลาง ดังนี้ ";
              Section = "ในข้อกล่าวหา ";
              _itemsInitTab6.forEach((item) {
                item.ArrestIndictmentDetail.forEach((item) {
                  textLawsuitBreaker +=
                      item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " +
                          item.LAST_NAME + " ";
                });
                item.ArrestIndictmentProduct.forEach((item) {
                  Evidence += item.PRODUCT_CATEGORY_NAME + '/' +
                      item.PRODUCT_TYPE_NAME + '/' +
                      item.PRODUCT_BRAND_NAME_TH +
                      " จำนวน " + item.QUANTITY.toString() + " " +
                      item.QUANTITY_UNIT +
                      " ปริมาณสุทธิ " + item.VOLUMN.toString() + " " +
                      item.VOLUMN_UNIT + ", ";
                });
                Section += item.GUILTBASE_NAME;
              });
              setBehavior(textLawsuitBreaker + Evidence + Section);
            }
          }else{
            if (_itemsInitTab6.length > 0) {
              _itemsInitTab6.forEach((f){
                counts+=f.ArrestIndictmentDetail.length;
              });
              textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " +
                  counts.toString() + " คน คือ ";
              Evidence = "พร้อมได้ยึดของกลาง ดังนี้ ";
              Section = "ในข้อกล่าวหา ";
              _itemsInitTab6.forEach((item) {
                item.ArrestIndictmentDetail.forEach((item) {
                  textLawsuitBreaker +=
                      item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " +
                          item.LAST_NAME + " ";
                });
                item.ArrestIndictmentProduct.forEach((item) {
                  Evidence +=
                      (item.PRODUCT_GROUP_NAME != null
                          ? (item.PRODUCT_GROUP_NAME
                          .toString() + ' ')
                          : '') +
                          (item.PRODUCT_CATEGORY_NAME != null
                              ? (item.PRODUCT_CATEGORY_NAME
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_TYPE_NAME != null
                              ? (item.PRODUCT_TYPE_NAME
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_BRAND_NAME_TH != null
                              ? (item.PRODUCT_BRAND_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_BRAND_NAME_EN != null
                              ? (item.PRODUCT_BRAND_NAME_EN
                              .toString() + ' ')
                              : '') +

                          (item.PRODUCT_SUBBRAND_NAME_TH != null
                              ? (item.PRODUCT_SUBBRAND_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_SUBBRAND_NAME_EN != null
                              ? (item.PRODUCT_SUBBRAND_NAME_EN
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_MODEL_NAME_TH != null
                              ? (item.PRODUCT_MODEL_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (item.PRODUCT_MODEL_NAME_EN != null
                              ? (item.PRODUCT_MODEL_NAME_EN
                              .toString() + ' ')
                              : '') +
                          (item.DEGREE != null
                              ? (item.DEGREE.toString() +
                              ' ดีกรี ')
                              : ' ') +
                          item.SIZES.toString() + ' ' +
                          item.SIZES_UNIT.toString()+

                          " จำนวน " + item.QUANTITY.toString() + " " +
                          item.QUANTITY_UNIT +
                          " ปริมาณสุทธิ " + item.VOLUMN.toString() + " " +
                          item.VOLUMN_UNIT + ", ";
                });
                Section += item.GUILTBASE_NAME;
              });
              setBehavior(textLawsuitBreaker + Evidence + Section);
            }
          }

        });
      }
    }
  }

  //************************end_tab_6*****************************

  //************************start_tab_7*****************************
  Widget _buildContent_tab_7() {
    Widget _buildContent() {
      EdgeInsets paddindTextTitle = EdgeInsets.only(bottom: 18.0);
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: new Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    //color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: paddindTextTitle,
                      child: Text(
                        "พฤติกรรมการจับกุม", style: textLabelStyle,),
                    ),
                    TextField(
                      style: textInputStyle,
                      maxLines: 10,
                      focusNode: myFocusNodeArrestBehavior,
                      controller: editArrestBehavior,
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
                  ],
                )
              ),
            ),
           /* new Container(
              padding: EdgeInsets.only(bottom: 24.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: paddindTextTitle,
                      child: Text(
                        "คำให้การของผู้ต้องหา", style: textLabelStyle,),
                    ),
                    TextField(
                      style: textInputStyle,
                      focusNode: myFocusNodeTestimony,
                      controller: editTestimony,
                      maxLines: 10,
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
                  ],
                )
              ),
            ),*/

            new Container(
              padding: EdgeInsets.only(bottom: 24.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 12.0,bottom: 12.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 18.0, top: 4, bottom: 4.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  TESTIMONY = !TESTIMONY;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: TESTIMONY ? Color(0xff3b69f3) : Colors
                                      .white,
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.black38
                                  ),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: TESTIMONY
                                        ? Icon(
                                      Icons.check,
                                      size: 16.0,
                                      color: Colors.white,
                                    )
                                        : Container(
                                      height: 16.0,
                                      width: 16.0,
                                      color: Colors.transparent,
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "ร้องขอ", style: textLabelStyle,),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      enabled: TESTIMONY?true:false,
                      style: textInputStyle,
                      focusNode: myFocusNodeNotificationOfRights,
                      controller: editNotificationOfRights,
                      maxLines: 10,
                      decoration: new InputDecoration(
                        filled: true,
                        //fillColor: TESTIMONY?Colors.white:Colors.grey[200],
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
                  ],
                )
              ),
            ),
          ],
        ),
      );
    }

    /*********************************when save data************************************/
    Widget _buildContent_saved() {
      List<String> list = [];
      list.add(_arrestMain.BEHAVIOR_1);
      list.add(_arrestMain.BEHAVIOR_2);
      list.add(_arrestMain.BEHAVIOR_3);
      list.add(_arrestMain.BEHAVIOR_4);
      list.add(_arrestMain.BEHAVIOR_5);
      String behavior = "";
      list.forEach((string) {
        if (string != null) {
          behavior += string;
        }
      });
      var size = MediaQuery
          .of(context)
          .size;

      return Container(
          height: size.height,
          decoration: BoxDecoration(
              //color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          padding: EdgeInsets.only(
              /*top: 4.0,*/ bottom: 12.0, left: 22.0, right: 22.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text("พฤติกรรมการจับกุม", style: textLabelStyle,),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: Text(behavior, style: textInputStyle,),
                ),
                /*Padding(
                  padding: paddingInputBox,
                  child: Text("คำให้การของผู้ต้องหา", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(_arrestMain.TESTIMONY!=null?_arrestMain.TESTIMONY:"-",
                    style: textInputStyle,),
                ),*/
                Container(
                  padding: paddingLabel,
                  child: Text("ร้องขอ", style: textLabelStyle,),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: Text(_arrestMain.REQUEST_DESC!=null?_arrestMain.REQUEST_DESC:"-", style: textInputStyle,),
                ),
              ],
            ),
          )
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //height: 34.0,
            decoration: BoxDecoration(
                //color: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_27_00',
                          style: textStylePageName,),
                      ),
                    ],
                  ),
                  ],
                )*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved ? _buildContent_saved() : _buildContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //************************end_tab_7*****************************


//************************start_tab_8*****************************

  Widget _buildContent_tab_8() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: _itemsDataTab8.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: index == 0 ? Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      ) : Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: ListTile(
                      title: Text((index + 1).toString() + '. ' +
                          _itemsDataTab8[index].FormsName,
                        style: textInputStyle,),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[400],),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              TabScreenArrest8Dowload(
                                Title: _itemsDataTab8[index].FormsName,)),
                        );
                      }
                  ),
                ),
              );
            }
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //height: 34.0,
            decoration: BoxDecoration(
                //color: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_28_00',
                          style: textStylePageName),
                      ),
                    ],
                  ),
                  ],
                )*/
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
    );
  }
//************************end_tab_8*****************************

  void _onSelectCountry(int COUNTRY_ID) async {
    await onLoadActionProvinceMaster(COUNTRY_ID);
  }
  Future<bool> onLoadActionProvinceMaster(int COUNTRY_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "COUNTRY_ID": COUNTRY_ID
    };
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((
        onValue) {
      ItemProvince = onValue;
      ItemProvince.RESPONSE_DATA.forEach((province) {
        if (_province.trim().endsWith(
            province.PROVINCE_NAME_TH.trim())) {
          sProvince = province;
          onLoadActionDistinctMaster(sProvince.PROVINCE_ID);
        }
      });
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionDistinctMaster(int PROVINCE_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "DISTRICT_ID": "",
      "PROVINCE_ID": PROVINCE_ID
    };
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((
        onValue) {
      ItemDistrict = onValue;
      ItemDistrict.RESPONSE_DATA.forEach((district) {
        if (_distict.trim().endsWith(
            district.DISTRICT_NAME_TH.trim())) {
          setState(() {
            sSubDistrict = null;
            sDistrict = district;
            this.onLoadActionSubDistinctMaster(sDistrict.DISTRICT_ID);
          });
        }
      });
      setState(() {});
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionSubDistinctMaster(int DISTRICT_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "SUB_DISTRICT_ID": "",
      "DISTRICT_ID": DISTRICT_ID
    };
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((
        onValue) {
      ItemSubDistrict = onValue;
      if (ItemSubDistrict != null) {
        ItemSubDistrict.RESPONSE_DATA.forEach((subdistrict) {
          if (_sub_distinct.trim().endsWith(
              subdistrict.SUB_DISTRICT_NAME_TH.trim())) {
            setState(() {
              sSubDistrict = subdistrict;


              //finish
              _itemsLocale = new ItemsListArrestLocation(
                  sProvince,
                  sDistrict,
                  sSubDistrict,
                  _road,
                  _alley,
                  _addressno,
                  _gps,
                  placeAddress,
                false,
                ""
              );
              String address = _itemsLocale.ADDRESS_NO+(_itemsLocale.ALLEY.isEmpty?"":" ซอย "+_itemsLocale.ALLEY)
                  +(_itemsLocale.ROAD.isEmpty?"":" ถนน "+_itemsLocale.ROAD)
                  + " อำเภอ/เขต " +  _itemsLocale.DISTICT.DISTRICT_NAME_TH
                  + " ตำบล/แขวง " +
                  _itemsLocale.SUB_DISTICT.SUB_DISTRICT_NAME_TH + " จังหวัด " +
                  _itemsLocale.PROVINCE.PROVINCE_NAME_TH;
              editArrestLocation.text = address;
            });
          }
        });
      }
    });
    setState(() {});
    return true;
  }
}