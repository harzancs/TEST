import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest6Product extends StatefulWidget {
  var ItemsProduct;
  var ItemsProductEdit;
  bool IsComplete;
  TabScreenArrest6Product({
    Key key,
    @required this.ItemsProduct,
    @required this.ItemsProductEdit,
    @required this.IsComplete,
  }) : super(key: key);
  @override
  _TabScreenArrest6EditAddState createState() => new _TabScreenArrest6EditAddState();
}
class _TabScreenArrest6EditAddState extends State<TabScreenArrest6Product> {
  var ItemsProduct;
  var ItemsProductEdit;

  final formatter = new NumberFormat("#,###.###");
  final formatter_money = new NumberFormat("#,###");

  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  TextStyle styleTextAppbar = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = TextStyle(
      color: Colors.red, fontFamily: FontStyles().FontFamily);

  final FocusNode myFocusNodeSize = FocusNode();
  final FocusNode myFocusNodeQuantity = FocusNode();
  final FocusNode myFocusNodeVolumn = FocusNode();
  final FocusNode myFocusNodeVolumeUnit = FocusNode();
  TextEditingController editSize = new TextEditingController();
  TextEditingController editQuantity = new TextEditingController();
  TextEditingController editVolume = new TextEditingController();
  TextEditingController editVolumeUnit = new TextEditingController();
  String dropdownValueSizeUnit = "ลิตร";
  String dropdownValueQuantityUnit = "ขวด";
  List<String> dropdownItemsSizeUnit = ["ลิตร", 'มิลลิกรัม'];
  List<String> dropdownItemsQuantityUnit = ["ขวด", "ลิตร", "ลิตร"];


  double xSize=0;
  int yCount=0;
  double zTotal=0;

  @override
  void initState() {
    super.initState();
    if (widget.IsComplete) {
      ItemsProduct = widget.ItemsProduct;
    } else {
      ItemsProductEdit = widget.ItemsProductEdit;
      editSize.text = ItemsProductEdit.SIZES.toString();
      editQuantity.text = ItemsProductEdit.QUANTITY.toString();
      editVolume.text = ItemsProductEdit.VOLUMN.toString();
      editVolumeUnit.text = ItemsProductEdit.VOLUMN_UNIT.toString();
      //dropdownValueVolumeUnit = widget.ItemsProductEdit.VOLUMN_UNIT;
      //dropdownValueProductUnit = widget.ItemsProductEdit.QUANTITY_UNIT;
    }
  }

  @override
  void dispose() {
    super.dispose();
    editSize.dispose();
    editQuantity.dispose();
    editVolume.dispose();
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
                 /* Container(
                    padding: paddingLabel,
                    child: Text("ชื่อของกลาง", style: textLabelStyle,),
                  ),*/
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: paddingInputBox,
                          child: Text(
                            (ItemsProductEdit.PRODUCT_GROUP_NAME != null
                                ? (ItemsProductEdit.PRODUCT_GROUP_NAME
                                .toString() + ' ')
                                : '') +
                                (ItemsProductEdit.PRODUCT_CATEGORY_NAME != null
                                    ? (ItemsProductEdit.PRODUCT_CATEGORY_NAME
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProductEdit.PRODUCT_TYPE_NAME != null
                                    ? (ItemsProductEdit.PRODUCT_TYPE_NAME
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProductEdit.PRODUCT_BRAND_NAME_TH != null
                                    ? (ItemsProductEdit.PRODUCT_BRAND_NAME_TH
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProductEdit.PRODUCT_BRAND_NAME_EN != null
                                    ? (ItemsProductEdit.PRODUCT_BRAND_NAME_EN
                                    .toString() + ' ')
                                    : '') +

                                (ItemsProductEdit.PRODUCT_SUBBRAND_NAME_TH !=
                                    null
                                    ? (ItemsProductEdit.PRODUCT_SUBBRAND_NAME_TH
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProductEdit.PRODUCT_SUBBRAND_NAME_EN !=
                                    null
                                    ? (ItemsProductEdit.PRODUCT_SUBBRAND_NAME_EN
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProductEdit.PRODUCT_MODEL_NAME_TH != null
                                    ? (ItemsProductEdit.PRODUCT_MODEL_NAME_TH
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProductEdit.PRODUCT_MODEL_NAME_EN != null
                                    ? (ItemsProductEdit.PRODUCT_MODEL_NAME_EN
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProductEdit.DEGREE != null
                                    ? (ItemsProductEdit.DEGREE.toString() +
                                    ' ดีกรี ')
                                    : ' ') +
                                ItemsProductEdit.SIZES.toString() + ' ' +
                                ItemsProductEdit.SIZES_UNIT.toString(),
                            style: textInputStyleTitle,),
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
                              child: Row(
                                children: <Widget>[
                                  Text("ขนาดบรรจุ",
                                    style: textLabelStyle,),
                                  Text(" *", style: textStyleStar,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: myFocusNodeSize,
                                controller: editSize,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  xSize = double.parse(text);
                                  zTotal = xSize * yCount;
                                  editVolume.text = formatter.format(zTotal).toString();
                                },
                              ),
                            ),
                            _buildLine,
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
                              child: Text("หน่วย", style: textLabelStyle,),
                            ),
                            Container(
                              width: Width,
                              //padding: paddingInputBox,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValueSizeUnit,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValueSizeUnit = newValue;
                                      editVolumeUnit.text = dropdownValueSizeUnit;
                                    });
                                  },
                                  items: dropdownItemsSizeUnit
                                      .map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: textInputStyle),
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
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Row(
                                children: <Widget>[
                                  Text("จำนวน",
                                    style: textLabelStyle,),
                                  Text(" *", style: textStyleStar,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: myFocusNodeQuantity,
                                controller: editQuantity,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  yCount = int.parse(text);
                                  zTotal = xSize * yCount;
                                  editVolume.text = formatter.format(zTotal).toString();
                                },
                              ),
                            ),
                            _buildLine,
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
                              child: Text("หน่วย", style: textLabelStyle,),
                            ),
                            Container(
                              width: Width,
                              //padding: paddingInputBox,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValueQuantityUnit,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValueQuantityUnit = newValue;
                                    });
                                  },
                                  items: dropdownItemsQuantityUnit
                                      .map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: textInputStyle),
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
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ปริมาณสุทธิ",
                                style: textLabelStyle,),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: myFocusNodeVolumn,
                                controller: editVolume,
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
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย",
                                style: textLabelStyle,),
                            ),
                            Container(
                              width: Width,
                              //padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: myFocusNodeVolumeUnit,
                                controller: editVolumeUnit,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
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
              //color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                //top: BorderSide(color: Colors.grey[300], width: 1.0),
                //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                            (ItemsProduct.PRODUCT_GROUP_NAME != null
                                ? (ItemsProduct.PRODUCT_GROUP_NAME
                                .toString() + ' ')
                                : '') +
                                (ItemsProduct.PRODUCT_CATEGORY_NAME != null
                                    ? (ItemsProduct.PRODUCT_CATEGORY_NAME
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProduct.PRODUCT_TYPE_NAME != null
                                    ? (ItemsProduct.PRODUCT_TYPE_NAME
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProduct.PRODUCT_BRAND_NAME_TH != null
                                    ? (ItemsProduct.PRODUCT_BRAND_NAME_TH
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProduct.PRODUCT_BRAND_NAME_EN != null
                                    ? (ItemsProduct.PRODUCT_BRAND_NAME_EN
                                    .toString() + ' ')
                                    : '') +

                                (ItemsProduct.PRODUCT_SUBBRAND_NAME_TH != null
                                    ? (ItemsProduct.PRODUCT_SUBBRAND_NAME_TH
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProduct.PRODUCT_SUBBRAND_NAME_EN != null
                                    ? (ItemsProduct.PRODUCT_SUBBRAND_NAME_EN
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProduct.PRODUCT_MODEL_NAME_TH != null
                                    ? (ItemsProduct.PRODUCT_MODEL_NAME_TH
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProduct.PRODUCT_MODEL_NAME_EN != null
                                    ? (ItemsProduct.PRODUCT_MODEL_NAME_EN
                                    .toString() + ' ')
                                    : '') +
                                (ItemsProduct.DEGREE != null
                                    ? (ItemsProduct.DEGREE.toString() +
                                    ' ดีกรี ')
                                    : ' ') +
                                ItemsProduct.SIZES.toString() + ' ' +
                                ItemsProduct.SIZES_UNIT.toString(),
                            style: textInputStyleTitle,),
                        ),
                      ),
                    ],
                  ),
                  /*Row(
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ค่าปรับประมาณการ : ", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          formatter_money.format(ItemsProduct.FINE_ESTIMATE)
                              .toString() + " บาท",
                          style: textInputStyle,),
                      ),
                    ],
                  ),*/
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
                                formatter.format(ItemsProduct.VOLUMN)
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
    TextStyle textStyleButton = TextStyle(color: Colors.white,
        fontSize: 18.0,
        fontFamily: FontStyles().FontFamily);
    var size = MediaQuery
        .of(context)
        .size;
    return widget.IsComplete ? null : Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          widget.ItemsProductEdit.SIZES = double.parse(editSize.text);
          widget.ItemsProductEdit.QUANTITY = double.parse(editQuantity.text);
          widget.ItemsProductEdit.VOLUMN = double.parse(editVolume.text);
          widget.ItemsProductEdit.SIZES_UNIT = dropdownValueSizeUnit;
          widget.ItemsProductEdit.QUANTITY_UNIT = dropdownValueQuantityUnit;
          widget.ItemsProductEdit.VOLUMN_UNIT = editVolumeUnit.text;
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
        }, child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text(!widget.IsComplete ? "งานจับกุม" : "ของกลาง",
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
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
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
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_31_00',
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
                        child: widget.IsComplete
                            ? _buildContent_saved(context)
                            : _buildContent(context),
                      )
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: _buildBottom(),
    )
    );
  }
}