import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'result/Search_result_Text.dart';
import 'result/Search_result_Camera.dart';

class FormSearch1 extends StatefulWidget {
  @override
  _FormSearch1State createState() => _FormSearch1State();
}

class _FormSearch1State extends State<FormSearch1> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _numberPerson;
  String _numberBook;
  String _namePerson;
  String _nameFather;
  String _nameMather;
  String _addressPerson;

  /// Value Test ///
  String nPerson = '1111111111111';
  String nBook = '';
  String naPerson = 'กิตติ';
  String nFather = 'ชาย';
  String nMather = 'หญิง';
  String aPerson = '123456789';

  /// Value Test ///

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _showPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '! ไม่พบข้อมูล !',
              style: TextStyle(color: Color(0xff2e76bc)),textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ปิด'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showPopupEmply() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '- กรุณาป้อนข้อมูล -',
              style: TextStyle(color: Color(0xff2e76bc)),textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ปิด'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _perform() {
    if (_numberPerson == nPerson ||
        _namePerson == naPerson ||
        _nameFather == nFather ||
        _nameMather == nMather ||
        _addressPerson == aPerson) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchResultText()));
    } else if (_numberPerson == '' &&
        _namePerson == '' &&
        _nameFather == '' &&
        _nameMather == '' &&
        _addressPerson == '') {
      _showPopupEmply();
    } else {
      _showPopup();
    }
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _perform();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'x-xxxx-xxxxx-xx-x',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          labelText: 'เลขประจำตัวประชาชน'),
                      onSaved: (val) => _numberPerson = val,
                      validator: (val) => val.isNotEmpty && val.length < 13
                          ? 'ป้อนเลขให้ครบ 13 หลัก'
                          : null,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(13),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'xxxxxxx',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          labelText: 'เลขหนังสือเดินทาง'),
                      onSaved: (val) => _numberBook = val,
                      validator: (val) => val.isNotEmpty && val.length < 7
                          ? 'ป้อนให้ครบ 7 หลัก'
                          : null,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                      ],
                      maxLengthEnforced: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'ผู้ต้องหา',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          labelText: 'ชื่อ นามสกุล'),
                      onSaved: (val) => _namePerson = val,
                      maxLengthEnforced: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'ชื่อ นามสกุล',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          labelText: 'บิดา'),
                      onSaved: (val) => _nameFather = val,
                      maxLengthEnforced: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'ชื่อ นามสกุล',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          labelText: 'มารดา'),
                      onSaved: (val) => _nameMather = val,
                      maxLengthEnforced: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'ที่อยู่ผู้ต้องหา',
                          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          labelText: 'ที่อยู่'),
                      onSaved: (val) => _addressPerson = val,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Color(0xff2e76bc),
                child: Text(
                  'ค้นหา',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
