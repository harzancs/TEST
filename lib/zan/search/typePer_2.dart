import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'result/Search_result_Text.dart';

class FormSearch2 extends StatefulWidget {
  @override
  _FormSearch2State createState() => _FormSearch2State();
}

class _FormSearch2State extends State<FormSearch2> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _numberRegPreson;
  String _nameCompany;
  String _nameTrade;

  // Data Test //
  String nRegPerson = '2222222222222';
  String nCompany = 'ช้าง';
  String nTrade = 'เบียร์';
  // Data Test //

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
    if (_numberRegPreson == nRegPerson ||
        _nameCompany == nCompany ||
        _nameTrade == nTrade) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchResultText()));
    } else if (_numberRegPreson == '' &&
        _nameCompany == '' &&
        _nameTrade == '') {
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
          child: Column(children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'x-xx-x-xxx-xxxxx-x',
                        hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                        labelText: 'เลขทะเบียนนิติบุคคล'),
                    onSaved: (val) => _numberRegPreson = val,
                    validator: (val) =>
                        val.isNotEmpty&&val.length < 13 ? 'ป้อนเลขให้ครบ 13 หลัก' : null,
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
                        labelText: 'บริษัทที่จดทะเบียนชื่อ'),
                    onSaved: (val) => _nameCompany = val,
                    maxLengthEnforced: true,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(),
                        filled: true,
                        labelText: 'ชื่อทางการค้า'),
                    onSaved: (val) => _nameTrade = val,
                    maxLengthEnforced: true,
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
          ]),
        ),
      ),
    ]);
  }
}
