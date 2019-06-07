import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest5Created extends StatefulWidget {
  List ItemsData;
  TabScreenArrest5Created({
    Key key,
    @required this.ItemsData,
  }) : super(key: key);
  @override
  _TabScreenArrest5CreateState createState() => new _TabScreenArrest5CreateState();
}
class _TabScreenArrest5CreateState extends State<TabScreenArrest5Created> {

  List<ItemsListArrest5Controller> itemsController=[];

  int _countItem=0;
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = TextStyle(
      color: Colors.red, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingLabelTitle = EdgeInsets.only(bottom: 16.0);

  final formatter = new NumberFormat("#,###.###");
  double xSize=0;
  int yCount=0;
  double zTotal=0;

  @override
  void initState() {
    super.initState();
    widget.ItemsData.forEach((item){
      TextEditingController editSize= new TextEditingController();
      TextEditingController editQauntity= new TextEditingController();
      TextEditingController editVolume= new TextEditingController();
      TextEditingController editVolumeUnit= new TextEditingController();
      FocusNode focusNodeSize = FocusNode();
      FocusNode focusNodeQauntity = FocusNode();
      FocusNode focusNodeVolume = FocusNode();
      FocusNode focusNodeVolumeUnit = FocusNode();
      itemsController.add(new ItemsListArrest5Controller(
          editSize,
          editQauntity,
          editVolume,
          editVolumeUnit,
          focusNodeSize,
          focusNodeQauntity,
          focusNodeVolume,
          focusNodeVolumeUnit,
          ["ลิตร",'มิลลิลิตร'],
          ["ขวด",'ลัง']
          ,"ลิตร",
          "ขวด"));
    });
    itemsController.forEach((item){
      /*item.Arrest6Controller.editSize.text = item.SIZES!=null?item.SIZES.toString():"";
      item.Arrest6Controller.editQuantity.text = item.QUANTITY!=null?item.QUANTITY.toString():"";
      item.Arrest6Controller.editVolume.text = item.VOLUMN!=null?item.VOLUMN.toString():"";*/
      item.editVolumeUnit.text = item.dropdownValueSizeUnit;
    });
  }


  @override
  void dispose() {
    super.dispose();
    /*widget.ItemsData.forEach((item){
      item.Arrest6Controller.myFocusNodeSize.dispose();
      item.Arrest6Controller.myFocusNodeQuantity.dispose();
      item.Arrest6Controller.myFocusNodeVolume.dispose();
    });*/
  }

  Widget _buildSearchResults() {
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
    return ListView.builder(
      itemCount: widget.ItemsData.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        xSize=0;
        yCount=0;
        zTotal=0;
        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(22.0),
            decoration: BoxDecoration(
                //color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
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
                        padding: paddingLabelTitle,
                        child: Text(
                          (widget.ItemsData[index].PRODUCT_GROUP_NAME != null
                              ? (widget.ItemsData[index].PRODUCT_GROUP_NAME
                              .toString() + ' ')
                              : '') +
                              (widget.ItemsData[index].PRODUCT_CATEGORY_NAME != null
                                  ? (widget.ItemsData[index].PRODUCT_CATEGORY_NAME
                                  .toString() + ' ')
                                  : '') +
                              (widget.ItemsData[index].PRODUCT_TYPE_NAME != null
                                  ? (widget.ItemsData[index].PRODUCT_TYPE_NAME
                                  .toString() + ' ')
                                  : '') +
                              (widget.ItemsData[index].PRODUCT_BRAND_NAME_TH != null
                                  ? (widget.ItemsData[index].PRODUCT_BRAND_NAME_TH
                                  .toString() + ' ')
                                  : '') +
                              (widget.ItemsData[index].PRODUCT_BRAND_NAME_EN != null
                                  ? (widget.ItemsData[index].PRODUCT_BRAND_NAME_EN
                                  .toString() + ' ')
                                  : '') +

                              (widget.ItemsData[index].PRODUCT_SUBBRAND_NAME_TH != null
                                  ? (widget.ItemsData[index].PRODUCT_SUBBRAND_NAME_TH
                                  .toString() + ' ')
                                  : '') +
                              (widget.ItemsData[index].PRODUCT_SUBBRAND_NAME_EN != null
                                  ? (widget.ItemsData[index].PRODUCT_SUBBRAND_NAME_EN
                                  .toString() + ' ')
                                  : '') +
                              (widget.ItemsData[index].PRODUCT_MODEL_NAME_TH != null
                                  ? (widget.ItemsData[index].PRODUCT_MODEL_NAME_TH
                                  .toString() + ' ')
                                  : '') +
                              (widget.ItemsData[index].PRODUCT_MODEL_NAME_EN != null
                                  ? (widget.ItemsData[index].PRODUCT_MODEL_NAME_EN
                                  .toString() + ' ')
                                  : '') +
                              (widget.ItemsData[index].DEGREE != null
                                  ? (widget.ItemsData[index].DEGREE.toString() +
                                  ' ดีกรี ')
                                  : ' ') +
                              widget.ItemsData[index].SIZES.toString() + ' ' +
                              widget.ItemsData[index].SIZES_UNIT.toString(),
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
                                Text(" *", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: itemsController[index].myFocusNodeSize,
                              controller:  itemsController[index].editSize,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                xSize = double.parse(text);
                                zTotal = xSize * yCount;
                                itemsController[index].editVolume.text = formatter.format(zTotal).toString();
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
                            child: Row(
                              children: <Widget>[
                                Text("หน่วย",
                                  style: textLabelStyle,),
                                Text(" *", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value:  itemsController[index].dropdownValueSizeUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    itemsController[index].dropdownValueSizeUnit = newValue;
                                    itemsController[index].editVolumeUnit.text =  itemsController[index].dropdownValueSizeUnit;
                                  });
                                },
                                items:  itemsController[index].dropdownItemsSizeUnit
                                    .map<DropdownMenuItem<String>>((String value) {
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
                                Text(" *", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode:  itemsController[index].myFocusNodeQuantity,
                              controller:  itemsController[index].editQuantity,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                yCount = int.parse(text);
                                zTotal = xSize * yCount;
                                itemsController[index].editVolume.text = formatter.format(zTotal).toString();
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
                            child: Row(
                              children: <Widget>[
                                Text("หน่วย",
                                  style: textLabelStyle,),
                                Text(" *", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: itemsController[index].dropdownValueQuantityUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    itemsController[index].dropdownValueQuantityUnit = newValue;
                                  });
                                },
                                items: itemsController[index].dropdownItemsQuantityUnit
                                    .map<DropdownMenuItem<String>>((String value) {
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
                              focusNode: itemsController[index].myFocusNodeVolume,
                              controller: itemsController[index].editVolume,
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
                              focusNode: itemsController[index].myFocusNodeVolumeUnit,
                              controller: itemsController[index].editVolumeUnit,
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
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    var size = MediaQuery
        .of(context)
        .size;

    bool isCheck = false;
    _countItem = 0;
    widget.ItemsData.forEach((item) {
      if (item.IsCheck)
        setState(() {
          isCheck = item.IsCheck;
          _countItem++;
        });
    });
    return Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          /*widget.ItemsData.forEach((item) {
            print(item.Counts.toString()+", "+item.Volume.toString());
            if (item.isCheck)
              widget.ItemsData.add(item);
          });*/
          for(int i=0;i<widget.ItemsData.length;i++){
            widget.ItemsData[i].SIZES_UNIT_ID = 1;
            widget.ItemsData[i].QUATITY_UNIT_ID = 1;
            widget.ItemsData[i].VOLUMN_UNIT_ID = 1;
            widget.ItemsData[i].SIZES = double.parse(itemsController[i].editSize.text);
            widget.ItemsData[i].QUANTITY = double.parse(itemsController[i].editQuantity.text);
            widget.ItemsData[i].VOLUMN = double.parse(itemsController[i].editVolume.text);
            widget.ItemsData[i].SIZES_UNIT = itemsController[i].dropdownValueSizeUnit;
            widget.ItemsData[i].QUANTITY_UNIT = itemsController[i].dropdownValueQuantityUnit;
            widget.ItemsData[i].VOLUMN_UNIT = itemsController[i].editVolumeUnit.text;
          }
          Navigator.pop(context,widget.ItemsData);
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
            child: new Text("ค้นหาของกลาง",
              style: styleTextAppbar,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "back");
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
                        child: new Text('ILG60_B_01_00_31_00',
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
                    child: _buildSearchResults(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottom(),
    ),
    );
  }
}