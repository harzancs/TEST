import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/home.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/model/ItemsEOfficeInfor.dart';
import 'package:prototype_app_pang/model/ItemsLogin.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}
class _SplashScreenState extends State<LoginScreen> {
  Future<ItemsLogin> apiRequestLDPAGAuthen(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressLogin + "/LDPAGAuthen",
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      ItemsLogin item = null;
      if (responseJson['Body']['ResponseObj']['message']['success']
          .toString()
          .endsWith("true")) {
        item = new ItemsLogin(
            responseJson['Body']['ResponseObj']['userThaiId'],
            responseJson['Body']['ResponseObj']['userThaiName'],
            responseJson['Body']['ResponseObj']['userThaiSurname'],
            responseJson['Body']['ResponseObj']['userEngName'],
            responseJson['Body']['ResponseObj']['userEngSurname'],
            responseJson['Body']['ResponseObj']['title'],
            responseJson['Body']['ResponseObj']['userId'],
            responseJson['Body']['ResponseObj']['email'],
            responseJson['Body']['ResponseObj']['cnName'],
            responseJson['Body']['ResponseObj']['officeId'],
            responseJson['Body']['ResponseObj']['accessAttr']);
      }
      return item;
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsEOfficeInfor> apiRequestEOfficeInfo(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressLogin + "/eofficeInfo",
      headers: {"Content-Type": "application/json"},
      encoding: Encoding.getByName("utf-8"),
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsEOfficeInfor.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //set Font
  FontStyles _fontStyles = FontStyles();

  final FocusNode myFocusNodeUsername = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  TextEditingController editUsername = new TextEditingController();
  TextEditingController editPassword = new TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    var date_now = new DateTime.now();
    var date = new DateTime(date_now.year,date_now.month,0);
    print(date.day);
  }

  ItemsPersonInformation _information = new ItemsPersonInformation(
      1,
      "1",
      0,
      "นาย",
      "โสภณ",
      "สุทธิพันธ์",
      "Mr.",
      "sopon",
      "sutthiphun",
      "090601",
      "สำนักงานสรรพสามิตพื้นที่ยะลา",
      11457,
      "สำนักงานสรรพสามิตพื้นที่ยะลา",
      "090601",
      "สำนักงานสรรพสามิตพื้นที่ยะลา",
    "สสพ.ยะลา",
      11457,
      "สำนักงานสรรพสามิตพื้นที่ยะลา",
      "1-521412",
      "อาวุโส",
      "เจ้าพนักงานสรรพสามิต",
      null,
      null,
      null,
      null,
      null,
      null,
      "1",
    14,
    "ผู้จับกุม",
    ["ผู้จับกุม","ผู้ร่วมจับกุม"],
  );

  @override
  void dispose() {
    super.dispose();
    myFocusNodeUsername.dispose();
    myFocusNodePassword.dispose();
  }

  void getInfor(SystemID, UserName, Password, PersonNID) async {
    Map request = {
      "PersonNID": PersonNID
    };
    Map map = {
      'SystemID': SystemID,
      'UserName': UserName,
      'Password': Password,
      "RequestData": request,
    };
    String success ="";
    var ItemPerson;
    await apiRequestEOfficeInfo(map).then((onValue) {
      success = onValue.Status;
      ItemPerson=onValue.PersonInformation;
    });
    Map map_title = {
      "TEXT_SEARCH" : ""
    };
    await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map_title).then((onValue) {
      itemsTitle = onValue;
    });
    if (success.endsWith("OK")) {
      Navigator.push(
        context,
        new MyCustomRoute(builder: (context) => new HomeScreen(
          ItemsData: ItemPerson,
          itemsTitle: itemsTitle,
        )),
      );
    }
  }

  //on show dialog
  Future<bool> onLoadAction(Map map, username, password) async {
    await apiRequestLDPAGAuthen(map).then((onValue) {
      if (onValue == null) {
        _showDialogErrorLogin(context, "Username หรือ Password ไม่ถูกต้อง");
      } else {
        getInfor("sso",
            "pccsso",
            "sso2561",
            onValue.userThaiId);
      }
    });
    Navigator.pop(context);
    setState(() {});
    return true;
  }

  CupertinoAlertDialog _cupertinoDialogLogin(mContext, text) {
    TextStyle TitleStyle = TextStyle(
        fontSize: 16.0, fontFamily: _fontStyles.FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: _fontStyles.FontFamily);
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

  void _showDialogErrorLogin(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoDialogLogin(context, text);
      },
    );
  }

  void _putDataLogin(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      _showDialogErrorLogin(context, "กรุณากรอกข้อมูลให้ครบ.");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(
              ),
            );
          });
      Map map = {'UserName': username, 'Password': password};
      await onLoadAction(map, username, password);
      Navigator.pop(context);
    }
    //print(username+" "+password);
  }

  void _getDataMaster()async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionMaster();
    Navigator.pop(context);

    if(itemsTitle!=null&&itemsOffice!=null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            HomeScreen(ItemsData: _information,itemsTitle: itemsTitle,itemsOffice: itemsOffice,)),
      );
    }else{
      _showDialogErrorLogin(context, "Network Error");
    }
  }

  ItemsMasterTitleResponse itemsTitle;
  ItemsArrestResponseGetOffice itemsOffice;
  Future<bool> onLoadActionMaster() async {
    Map map_title = {
      "TEXT_SEARCH" : ""
    };
    await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map_title).then((onValue) {
      itemsTitle = onValue;
    });
    Map map_office = {
      "TEXT_SEARCH" : "",
      "STAFF_ID" : ""
    };
    await new ArrestFutureMaster().apiRequestMasOfficegetByCon(map_office).then((onValue) {
      itemsOffice = onValue;
    });

    setState(() {});
    return true;
  }

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  CupertinoAlertDialog _createCupertinoCloseAppDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ต้องการปิดแอพพลิเคชั่น.",
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
              onPressed: ()=> exit(0),
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void onChange(text){
    print(text);
  }

  void _showCloseAppAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCloseAppDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Color _color_button = Color(0xff81b4d5);
    Color _color_bg = Color(0xff0069aa);

    TextStyle textStyleTitle = TextStyle(fontSize: 18.0,
        color: Colors.white70,
        fontFamily: _fontStyles.FontFamily);
    TextStyle textStyleLogin = TextStyle(
        fontSize: 18.0,
        color: Colors.white70,
        fontWeight: FontWeight.w400,
        fontFamily: _fontStyles.FontFamily);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0,
        color: Colors.white54,
        fontFamily: _fontStyles.FontFamily);
    TextStyle textInputStyleVersion = TextStyle(fontSize: 14.0,
        color: Colors.white54,
        fontFamily: _fontStyles.FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 8.0, bottom: 8.0);

    var size = MediaQuery
        .of(context)
        .size;
    double width = (size.width * 85) / 100;

    final _button_login = Container(
      width: width,
      //height: (size.height * 7) / 100,
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF00000),
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: Color(0xFF00000),
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: new LinearGradient(
            colors: [
              Color(0xff51b8d8),
              Color(0xFF1d9cc3),
              //Color(0xff2984b9),
            ],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: Color(0xFF00000),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 42.0),
            child: Text(
              "เข้าสู่ระบบ",
              style: textStyleLogin,
            ),
          ),
          onPressed: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  HomeScreen(ItemsData: _information,itemsTitle: itemsTitle,)),
            );*/
            _getDataMaster();
            //_putDataLogin(editUsername.text, editPassword.text);

          } //
      ),
    );

    final _logo = Padding(
      padding: EdgeInsets.only(
        //top: 65.0, left: 38.0, right: 38.0, bottom: 35.0),
          top: (size.height * 10) / 100,
          left: 38.0,
          right: 38.0,
          bottom: (size.height * 3) / 100),
      child: new Image(
          fit: BoxFit.cover,
          image: new AssetImage(
              'assets/images/logo_login.png')),
    );

    final _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: width,
      height: 1.0,
      color: Colors.grey[300],
    );

    final _inputBox = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeUsername,
            controller: editUsername,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'ชื่อผู้ใช้งาน',
                labelStyle: textInputStyle
            ),
            onChanged: onChange,
          ),
        ),
        _buildLine,
        Container(
          width: width,
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodePassword,
            controller: editPassword,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'รหัสผ่าน',
                labelStyle: textInputStyle
            ),
          ),
        ),
        _buildLine,
      ],
    );

    return WillPopScope(
      onWillPop: () {
        _showCloseAppAlertDialog();
      }, child: Scaffold(
      backgroundColor: _color_bg,
      body: /*new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight((size.height * 20) / 100),
              child: Align(
                alignment: Alignment.topLeft,
                child: _logo,
              )
          ),
          body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('ระบบงานผู้กระทำผิดกฏหมายสรรพสามิต',
                      style: textStyleTitle,),
                    Padding(
                      padding: EdgeInsets.only(top: (size.height * 5) / 100,
                          bottom: (size.height * 5) / 100),
                      child: _inputBox,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: (size.height * 5) / 100,
                          bottom: (size.height * 5) / 100),
                      child: _button_login,
                    )
                  ],
                ),
              )
          ),
        ),
      ),*/Stack(
        children: <Widget>[
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight((size.height * 20) / 100),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: _logo,
                )
            ),
            body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('ระบบงานผู้กระทำผิดกฏหมายสรรพสามิต',
                        style: textStyleTitle,),
                      Padding(
                        padding: EdgeInsets.only(top: (size.height * 5) / 100,
                            bottom: (size.height * 5) / 100),
                        child: _inputBox,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: (size.height * 5) / 100,
                            bottom: (size.height * 5) / 100),
                        child: _button_login,
                      )
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('เวอร์ชั่น 0.0.4', style: textInputStyleVersion,)
            ],
          )
      ),
    ),
    );
  }
}
class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}