import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_5.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_indictment_product.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_product.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_search.dart';

class TabScreenLawsuitProduct extends StatefulWidget {
  var ItemsProduct;
  var ItemsProductEdit;
  bool IsComplete;
  String Title;
  TabScreenLawsuitProduct({
    Key key,
    @required this.ItemsProduct,
    @required this.ItemsProductEdit,
    @required this.IsComplete,
    @required this.Title,
  }) : super(key: key);
  @override
  _state createState() => new _state();
}
class _state extends State<TabScreenLawsuitProduct>  {
  var ItemsProduct;
  var ItemsProductEdit;

  final formatter = new NumberFormat("#,###.###");
  final formatter_money = new NumberFormat("#,###");

  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);

  final FocusNode myFocusNodeProductUnit = FocusNode();
  final FocusNode myFocusNodeVolumeUnit = FocusNode();
  TextEditingController editProductUnit = new TextEditingController();
  TextEditingController editVolumeUnit = new TextEditingController();
  String dropdownValueProductUnit = "ลิตร";
  String dropdownValueVolumeUnit = "ขวด";
  List<String> dropdownItemsProductUnit = ["ลิตร",'มิลลิกรัม'];
  List<String> dropdownItemsVolumeUnit = ["ขวด","ลิตร","ลิตร"];


  @override
  void initState() {
    super.initState();
    if(widget.IsComplete){
      ItemsProduct = widget.ItemsProduct;
    }else{
      ItemsProductEdit = widget.ItemsProductEdit;
      //dropdownValueVolumeUnit = widget.ItemsProductEdit.VOLUMN_UNIT;
      //dropdownValueProductUnit = widget.ItemsProductEdit.QUANTITY_UNIT;
    }
  }

  @override
  void dispose() {
    super.dispose();
    editProductUnit.dispose();
    editVolumeUnit.dispose();
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 100) / 100;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return Padding(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
        height: size.height,
          padding: EdgeInsets.all(22.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide(color: Colors.grey[300], width: 1.0),
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
                            ItemsProductEdit.PRODUCT_CATEGORY_NAME + '/' +
                                  ItemsProductEdit.PRODUCT_TYPE_NAME + '/' +
                                ItemsProductEdit.PRODUCT_BRAND_NAME_TH,
                            style: textInputStyleTitle,),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width*75)/100)/2,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวน", style: textLabelStyle,),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: myFocusNodeProductUnit,
                                controller: editProductUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            _buildLine,
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width*75)/100)/2,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textLabelStyle,),
                            ),
                            Container(
                              width: Width,
                              //padding: paddingInputBox,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValueProductUnit,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValueProductUnit= newValue;
                                    });
                                  },
                                  items: dropdownItemsProductUnit
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style: textInputStyle),
                                    );
                                  })
                                      .toList(),
                                ),
                              ),
                            ),
                            _buildLine,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width*75)/100)/2,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ปริมาณสุทธิ", style: textLabelStyle,),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: myFocusNodeVolumeUnit,
                                controller: editVolumeUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            _buildLine,
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width*75)/100)/2,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textLabelStyle,),
                            ),
                            Container(
                              width: Width,
                              //padding: paddingInputBox,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValueVolumeUnit,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValueVolumeUnit= newValue;
                                    });
                                  },
                                  items: dropdownItemsVolumeUnit
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style: textInputStyle),
                                    );
                                  })
                                      .toList(),
                                ),
                              ),
                            ),
                            _buildLine,
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
  Widget _buildContent_saved(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 100) / 100;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return Padding(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
          height: size.height,
          padding: EdgeInsets.all(22.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide(color: Colors.grey[300], width: 1.0),
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: paddingInputBox,
                          child: Text(
                            ItemsProduct.PRODUCT_CATEGORY_NAME+ ' > '+ ItemsProduct.PRODUCT_TYPE_NAME+ ' > ' +
                                ItemsProduct.PRODUCT_BRAND_NAME_TH,
                            style: textInputStyleTitle,),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ค่าปรับประมาณการ : ", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          formatter_money.format( ItemsProduct.FINE_ESTIMATE).toString()+ " บาท",
                          style: textInputStyle,),
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
                                formatter.format(ItemsProduct.SIZES).toString(),
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
                                ItemsProduct.SIZES_UNIT,
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
                                ItemsProduct.QUANTITY.toString(),
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
                                ItemsProduct.QUANTITY_UNIT,
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
                                formatter.format(ItemsProduct.VOLUMN).toString(),
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
                                ItemsProduct.VOLUMN_UNIT,
                                style: textInputStyle,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
  Widget _buildBottom() {
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: FontStyles().FontFamily);
    var size = MediaQuery
        .of(context)
        .size;
    return widget.IsComplete?null: Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          widget.ItemsProductEdit.QUANTITY = double.parse(editProductUnit.text);
          widget.ItemsProductEdit.VOLUMN = double.parse(editVolumeUnit.text);
          widget.ItemsProductEdit.VOLUMN_UNIT = dropdownValueVolumeUnit;
          widget.ItemsProductEdit.QUANTITY_UNIT = dropdownValueProductUnit;
          Navigator.pop(context, widget.ItemsProductEdit);
        },
        child: Center(
          child: Text('ตกลง', style: textStyleButton,),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },child:Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text(widget.Title,
              style: styleTextAppbar,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, ItemsProduct);
              }),
        ),
      ),
      body: Center(
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
                    )
                ),
                /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_02_00_12_00',
                          style: TextStyle(color: Colors.grey[400],fontSize: 12.0,fontFamily: FontStyles().FontFamily),),
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
                    child: widget.IsComplete?_buildContent_saved(context):_buildContent(context),
                  )
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottom(),
    ),
    );
  }
}