import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/zan/search/SearchPerson.dart';
import 'package:prototype_app_pang/zan/search/result/Search_result_Camera.dart';

class NetworkFragment extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<NetworkFragment> {
  File imageFile;
  _openGallory() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
  }

  _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
  }

  _openvalue() async {
    var picture = null;
    this.setState(() {
      imageFile = picture;
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ทางเลือก...'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image,color: Color(0xff2e76bc)),
                        Text('   อัลบั้มรูป'),
                      ],
                    ),
                    onTap: () {
                      _openGallory();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera_alt,color: Color(0xff2e76bc)),
                        Text('   กล้องถ่ายรูป')
                      ],
                    ),
                    onTap: () {
                      _openCamera();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile != null) {
      return AlertDialog(
          title: Text('ทดสอบรูปภาพ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.file(imageFile,width: 150,height: 150),
                Padding(padding: EdgeInsets.all(5),),
                RaisedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.check),
                      Text('   ตกลง ( Next page )')],
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SearchResultCamera(),
                    ),
                  ),
                ),
                RaisedButton(
                    child: Row(

                      children: <Widget>[Icon(Icons.clear),Text('   Reset Picture')],
                    ),
                    onPressed: () {
                      _openvalue();
                    })
              ],
            ),
          ));
    } else {
      return Text('');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      /*appBar: AppBar(
        title: Text('วิเคราะห์ข้อมูลผู้ต้องหา',
            style: TextStyle(fontFamily: 'Kanit')),
        centerTitle: true,
        backgroundColor: Color(0xff2e76bc),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchPerson(),
                  ))),
        ],
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _decideImageView(),
            FlatButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      size: 200,
                      color: Color(0xff2e76bc),
                    ),
                    Text(
                      'ค้นหาด้วยภาพ',
                      style: TextStyle(
                          fontFamily: FontStyles().FontFamily, fontSize: 25),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
