import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakeCamera extends StatefulWidget {
  @override
  _TakeCameraState createState() => _TakeCameraState();
}

class _TakeCameraState extends State<TakeCamera> {
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
                        Icon(Icons.image),
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
                        Icon(Icons.camera_alt),
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
    if (imageFile == null) {
      return Text('ไม่มีรูปที่คุณเลือก');
    } else {
      Image.file(imageFile, width: 400, height: 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกรูปภาพ')),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              RaisedButton(
                color: Color(0xff2e76bc),
                child: Text('เลือกรูป...',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  _showChoiceDialog(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
