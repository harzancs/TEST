import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/export/export_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';

class ExportFragment extends StatefulWidget {
  ItemsPersonInformation ItemsData;
  ExportFragment({
    Key key,
    @required this.ItemsData,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ExportFragment>  {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return new Scaffold(
        body: new Center(
            child: new Container(
              padding: EdgeInsets.only(top: size.height / 4.5),
              child: new Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                      height: (size.width*50)/100,
                      width: (size.width*50)/100,
                      child: new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        color: Colors.white,
                        icon: new Icon(
                            Icons.add_circle, color: Color(0xff087de1),
                            size: (size.width*50)/100),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => ExportMainScreenFragment(
                                    ItemsexportMain: null,
                                    IsPreview: false,
                                    IsCreate: true,
                                    IsUpdate: false,
                                    //ItemsMain: widget.ItemsData,
                                  )));
                        },
                      )
                  ),
                  new Padding(padding: EdgeInsets.only(top: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("สร้างงานนำขอกลาง", style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily),),
                        Text("ออกจากคลังไปใช้ทางราชการ / บริจาค", style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily),),
                      ],
                    )
                  )
                ],
              ),
            )
        )
    );
  }
}