
import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_country.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_title.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/model/test/Background.dart';


class TabScreenArrest4Create extends StatefulWidget {
  bool IsUpdate;
  ItemsMasterTitleResponse ItemTitle;
  var ItemsPerson;
  ItemsMasterCountryResponse ItemCountry;
  String Title;
  TabScreenArrest4Create({
    Key key,
    @required this.IsUpdate,
    @required this.ItemTitle,
    @required this.ItemsPerson,
    @required this.ItemCountry,
    @required this.Title,
  }) : super(key: key);
  @override
  _TabScreenArrest4CreateState createState() => new _TabScreenArrest4CreateState();
}
class _TabScreenArrest4CreateState extends State<TabScreenArrest4Create> {
  //node type1
  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  final FocusNode myFocusNodePassportNo = FocusNode();
  final FocusNode myFocusNodePassportCountry = FocusNode();

  final FocusNode myFocusNodeFirstNameSus = FocusNode();
  final FocusNode myFocusNodeLastNameSus = FocusNode();

  final FocusNode myFocusNodeFirstNameFather_1 = FocusNode();
  final FocusNode myFocusNodeLastNameFather_1 = FocusNode();
  final FocusNode myFocusNodeFirstNameMother_1 = FocusNode();
  final FocusNode myFocusNodeLastNameMother_1 = FocusNode();
  final FocusNode myFocusNodePlace = FocusNode();

  //node type1
  TextEditingController editIdentifyNumber = new TextEditingController();
  TextEditingController editPassportNo = new TextEditingController();
  TextEditingController editPassportCountry = new TextEditingController();

  TextEditingController editFirstNameSus = new TextEditingController();
  TextEditingController editLastNameSus = new TextEditingController();

  TextEditingController editFirstNameFather = new TextEditingController();
  TextEditingController editLastNameFather = new TextEditingController();
  TextEditingController editFirstNameMother = new TextEditingController();
  TextEditingController editLastNameMother = new TextEditingController();
  TextEditingController editPlace = new TextEditingController();

  ItemsMasterGetPersonResponse _getPersonResponse;

  //dropbox type1
  ItemsListTitle sTitle;
  ItemsListTitle sTitleMother;
  ItemsListTitle sTitleFather;
  ItemsListTitle sTitleHeadCompany;
  ItemsListTitle sTitleMotherHeadCompany;
  ItemsListTitle sTitleFatherHeadCompany;

  ItemsMasterProvinceResponse ItemProvince;
  ItemsMasterDistictResponse ItemDistrict;
  ItemsMasterSubDistictResponse ItemSubDistrict;

  ItemsListSubDistict sSubDistrict;
  ItemsListDistict sDistrict;
  ItemsListProvince sProvince;
  ItemsListCountry sCountry;

  ItemsListCountry sCountry2;
  ItemsListSubDistict sSubDistrict2;
  ItemsListDistict sDistrict2;
  ItemsListProvince sProvince2;

  //node type2
  final FocusNode myFocusNodeEntityNumber = FocusNode();
  final FocusNode myFocusNodeCompanyName = FocusNode();
  final FocusNode myFocusNodeExciseRegistrationNumber = FocusNode();
  final FocusNode myFocusNodeCompanyNameTitle = FocusNode();

  final FocusNode myFocusNodeCompanyHeadFirstName = FocusNode();
  final FocusNode myFocusNodeCompanyHeadLastName = FocusNode();

  final FocusNode myFocusNodeFirstNameFather_2 = FocusNode();
  final FocusNode myFocusNodeLastNameFather_2 = FocusNode();
  final FocusNode myFocusNodeFirstNameMother_2 = FocusNode();
  final FocusNode myFocusNodeLastNameMother_2 = FocusNode();

  //node type2
  TextEditingController editEntityNumber = new TextEditingController();
  TextEditingController editCompanyName = new TextEditingController();
  TextEditingController editExciseRegistrationNumber = new TextEditingController();
  TextEditingController editCompanyNameTitle = new TextEditingController();

  TextEditingController editCompanyHeadFirstName = new TextEditingController();
  TextEditingController editCompanyHeadLastName = new TextEditingController();

  TextEditingController editFirstNameFather_2 = new TextEditingController();
  TextEditingController editLastNameFather_2 = new TextEditingController();
  TextEditingController editFirstNameMother_2 = new TextEditingController();
  TextEditingController editLastNameMother_2 = new TextEditingController();

  //dropbox type2
  String dropdownValue_2 = 'นาย';
  List<String> dropdownItems_2 = ['นาย', 'นาง', 'นางสาว', "รต.ต.ต."];

  bool _suspectType1 = false;
  bool _suspectType2 = false;
  bool _nationalityType1 = false;
  bool _nationalityType2 = false;

  List<ItemsListArrestLawbreaker> _itemData = [];

  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  Color labelColor = Color(0xff087de1);
  TextStyle textSearchByImgStyle = TextStyle(
      fontSize: 16.0, color: Colors.blue.shade400,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  TextStyle textStyleStar = TextStyle(
      color: Colors.red, fontFamily: FontStyles().FontFamily);


  ItemsMasterCountryResponse _itemsMasterCountryResponse;
  ItemsMasterProvinceResponse _itemsMasterProviceResponse;
  ItemsMasterDistictResponse _itemsMasterDistictResponse;

  void _onImageButtonPressed(ImageSource source, mContext) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
      _imageFile.then((f) {

        setState(() {
          List splits = f.path.split("/");
          isImage = true;
          _arrItemsImageFile.add(f.absolute);
          _arrItemsImageName.add(splits[splits.length - 1]);
        });
        //_navigateSearchFace(context, _imageFile);
      });
      //Navigator.pop(mContext);
    });
  }
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      _arrItemsImageName.add(splits[splits.length - 1]);
      _arrItemsImageFile.add(image);
    });
  }

  @override
  void initState() {
    super.initState();

    setAutoCompleteCountry();
    setAutoCompleteCountry2();

    setAutoCompleteTitle();
    setAutoCompleteTitleFatherHeadCompany();
    setAutoCompleteTitleMotherCompany();
    setAutoCompleteTitleHeadCompany();
    setAutoCompleteTitleFather();
    setAutoCompleteTitleMother();

    if(widget.IsUpdate){

      widget.ItemsPerson.PERSON_TYPE==0?_nationalityType1=true:_nationalityType2=true;
      widget.ItemsPerson.ENTITY_TYPE==0?_suspectType1=true:_suspectType2=true;

      if(widget.ItemsPerson.ENTITY_TYPE==0){
        if(widget.ItemsPerson.MAS_PERSON_ADDRESS!=null){
          int SUB_DISTRICT_ID;
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item){
            SUB_DISTRICT_ID = item.SUB_DISTRICT_ID;
          });
          if(SUB_DISTRICT_ID!=null){
            this.onLoadActionSubDistinctMaster(null,SUB_DISTRICT_ID,true);
          }
        }

        if(widget.ItemsPerson.TITLE_ID!=null){
          Map map_title = {
            "TITLE_ID": widget.ItemsPerson.TITLE_ID,
            "TITLE_NAME_TH": widget.ItemsPerson.TITLE_NAME_TH,
            "TITLE_NAME_EN": widget.ItemsPerson.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": widget.ItemsPerson.TITLE_SHORT_NAME_EN,
            "IS_ACTIVE": 1,
          };
          var body_title = json.encode(map_title);
          sTitle = ItemsListTitle.fromJson(json.decode(body_title));
          editTitleName.text = sTitle.TITLE_SHORT_NAME_TH.toString();
        }

        widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item){
          if(item.RELATIONSHIP_ID==1){
            editFirstNameFather.text=item.FIRST_NAME.toString();
            editLastNameFather.text=item.LAST_NAME.toString();
            Map map_title = {
              "TITLE_NAME_TH": item.TITLE_NAME_TH,
              "TITLE_NAME_EN": item.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
              "IS_ACTIVE": 1,
            };
            var body_title = json.encode(map_title);
            sTitleFather = ItemsListTitle.fromJson(json.decode(body_title));
            if(sTitleFather!=null){
              editTitleNameFather.text = sTitleFather.TITLE_SHORT_NAME_TH.toString();
            }

          }else if(item.RELATIONSHIP_ID==2){
            editFirstNameMother.text=item.FIRST_NAME.toString();
            editLastNameMother.text=item.LAST_NAME.toString();

            Map map_title = {
              "TITLE_NAME_TH": item.TITLE_NAME_TH,
              "TITLE_NAME_EN": item.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
              "IS_ACTIVE": 1,
            };
            var body_title = json.encode(map_title);
            sTitleMother = ItemsListTitle.fromJson(json.decode(body_title));
            if(sTitleMother!=null){
              editTitleNameMother.text = sTitleMother.TITLE_SHORT_NAME_TH.toString();
            }
          }
        });
        editIdentifyNumber.text=widget.ItemsPerson.ID_CARD;
        editFirstNameSus.text = widget.ItemsPerson.FIRST_NAME;
        editLastNameSus.text = widget.ItemsPerson.LAST_NAME;
        editPassportNo.text= widget.ItemsPerson.PASSPORT_NO!=null?widget.ItemsPerson.PASSPORT_NO:"";

      }else{
        if(widget.ItemsPerson.MAS_PERSON_ADDRESS!=null){
          int SUB_DISTRICT_ID;
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item){
            SUB_DISTRICT_ID = item.SUB_DISTRICT_ID;
          });
          if(SUB_DISTRICT_ID!=null){
            this.onLoadActionSubDistinctMaster(null,SUB_DISTRICT_ID,true);
          }
        }

        editEntityNumber.text = widget.ItemsPerson.COMPANY_REGISTRATION_NO.toString();
        editCompanyHeadFirstName.text = widget.ItemsPerson.FIRST_NAME.toString();
        editCompanyHeadLastName.text = widget.ItemsPerson.LAST_NAME.toString();

        print("TITLE_ID : "+widget.ItemsPerson.TITLE_ID.toString());

        if(widget.ItemsPerson.TITLE_ID!=null){
          Map map_title = {
            "TITLE_ID": widget.ItemsPerson.TITLE_ID,
            "TITLE_NAME_TH": widget.ItemsPerson.TITLE_NAME_TH,
            "TITLE_NAME_EN": widget.ItemsPerson.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": widget.ItemsPerson.TITLE_SHORT_NAME_EN,
            "IS_ACTIVE": 1,
          };
          var body_title = json.encode(map_title);
          sTitleHeadCompany = ItemsListTitle.fromJson(json.decode(body_title));
          editTitleNameHeadCompany.text = sTitleHeadCompany.TITLE_SHORT_NAME_TH.toString();
        }

        widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item){
          if(item.RELATIONSHIP_ID==1){
            editFirstNameFather_2.text=item.FIRST_NAME.toString();
            editLastNameFather_2.text=item.LAST_NAME.toString();
            Map map_title = {
              "TITLE_NAME_TH": item.TITLE_NAME_TH,
              "TITLE_NAME_EN": item.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
              "IS_ACTIVE": 1,
            };
            var body_title = json.encode(map_title);
            sTitleFatherHeadCompany = ItemsListTitle.fromJson(json.decode(body_title));
            if(sTitleFatherHeadCompany!=null){
              editTitleNameFatherHeadCompany.text = sTitleFatherHeadCompany.TITLE_SHORT_NAME_TH.toString();
            }

          }else if(item.RELATIONSHIP_ID==2){
            editFirstNameMother_2.text=item.FIRST_NAME.toString();
            editLastNameMother_2.text=item.LAST_NAME.toString();

            Map map_title = {
              "TITLE_NAME_TH": item.TITLE_NAME_TH,
              "TITLE_NAME_EN": item.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
              "IS_ACTIVE": 1,
            };
            var body_title = json.encode(map_title);
            sTitleMotherHeadCompany = ItemsListTitle.fromJson(json.decode(body_title));
            if(sTitleMotherHeadCompany!=null){
              editTitleNameMotherHeadCompany.text = sTitleMotherHeadCompany.TITLE_SHORT_NAME_TH.toString();
            }
          }
        });
      }
      /*String title = widget.ItemsPerson.TITLE_SHORT_NAME_TH==null?widget.ItemsPerson.TITLE_NAME_TH:widget.ItemsPerson.TITLE_SHORT_NAME_TH;
      for(int i=0;i<widget.ItemTitle.RESPONSE_DATA.length;i++){
        String stitle = widget.ItemTitle.RESPONSE_DATA[i].TITLE_SHORT_NAME_TH==null?widget.ItemTitle.RESPONSE_DATA[i].TITLE_NAME_TH
            :widget.ItemTitle.RESPONSE_DATA[i].TITLE_SHORT_NAME_TH;
        if(stitle.endsWith(title)){
          sTitle = widget.ItemTitle.RESPONSE_DATA[i];
        }
      }*/
    }else{
      _suspectType1 = true;
      _nationalityType1 = true;
      _onSelectCountry(1);
    }
  }

  @override
  void dispose() {
    super.dispose();
    //node type1
    myFocusNodeIdentifyNumber.dispose();
    myFocusNodePassportNo.dispose();
    myFocusNodePassportCountry.dispose();

    myFocusNodeFirstNameSus.dispose();
    myFocusNodeLastNameSus.dispose();

    myFocusNodeFirstNameFather_1.dispose();
    myFocusNodeLastNameFather_1.dispose();
    myFocusNodeFirstNameMother_1.dispose();
    myFocusNodeLastNameMother_1.dispose();

    myFocusNodePlace.dispose();
    //node type2
    myFocusNodeEntityNumber.dispose();
    myFocusNodeCompanyName.dispose();
    myFocusNodeExciseRegistrationNumber.dispose();
    myFocusNodeCompanyNameTitle.dispose();

    myFocusNodeCompanyHeadFirstName.dispose();
    myFocusNodeCompanyHeadLastName.dispose();

    myFocusNodeFirstNameFather_2.dispose();
    myFocusNodeLastNameFather_2.dispose();
    myFocusNodeFirstNameMother_2.dispose();
    myFocusNodeLastNameMother_2.dispose();
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      //color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    //top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              width: size.width,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("ประเภทบุคคล", style: textLabelStyle,),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width / 2.5,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _suspectType1 = true;
                                      _suspectType2 = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _suspectType1
                                          ? Colors.blue
                                          : Colors
                                          .white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: _suspectType1
                                            ? Icon(
                                          Icons.check,
                                          size: 30.0,
                                          color: Colors.white,
                                        )
                                            : Container(
                                          height: 30.0,
                                          width: 30.0,
                                          color: Colors.transparent,
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text('บุคคลธรรมดา',
                                    style: textStyleSelect,),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: size.width / 2.5,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _suspectType2 = true;
                                        _suspectType1 = false;
                                        if(_suspectType2){
                                          //_onSelectCountry(1);
                                          onLoadActionProvinceMaster(1,null,false);
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _suspectType2
                                            ? Colors.blue
                                            : Colors
                                            .white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: _suspectType2
                                              ? Icon(
                                            Icons.check,
                                            size: 30.0,
                                            color: Colors.white,
                                          )
                                              : Container(
                                            height: 30.0,
                                            width: 30.0,
                                            color: Colors.transparent,
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('นิติบุคคล',
                                      style: textStyleSelect,),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ประเภทผู้ต้องหา", style: textLabelStyle,),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width / 2.5,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _nationalityType1 = true;
                                      _nationalityType2 = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _nationalityType1
                                          ? Colors.blue
                                          : Colors
                                          .white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: _nationalityType1
                                            ? Icon(
                                          Icons.check,
                                          size: 30.0,
                                          color: Colors.white,
                                        )
                                            : Container(
                                          height: 30.0,
                                          width: 30.0,
                                          color: Colors.transparent,
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text('คนไทย',
                                    style: textStyleSelect,),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: size.width / 2.5,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _nationalityType2 = true;
                                        _nationalityType1 = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _nationalityType2
                                            ? Colors.blue
                                            : Colors.white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: _nationalityType2
                                              ? Icon(
                                            Icons.check,
                                            size: 30.0,
                                            color: Colors.white,
                                          )
                                              : Container(
                                            height: 30.0,
                                            width: 30.0,
                                            color: Colors.transparent,
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('คนต่างชาติ',
                                      style: textStyleSelect,),
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                      _suspectType1 ? _buildInputType1() : _buildInputType2(),
                      Container(height: (size.height * 10) / 100,)
                    ],
                  ),
                ),
              )
          ),
          Container(
            width: size.width,
            child: _buildButtonImgPicker(),
          ),
          _buildDataImage(context),
        ],
      ),
    );
  }

  AutoCompleteTextField _textListTitleName;
  AutoCompleteTextField _textListTitleNameHeadCompany;
  AutoCompleteTextField _textListTitleNameFatherHeadCompany;
  AutoCompleteTextField _textListTitleNameMotherHeadCompany;
  AutoCompleteTextField _textListTitleNameFather;
  AutoCompleteTextField _textListTitleNameMother;

  TextEditingController editTitleName = new TextEditingController();
  TextEditingController editTitleNameHeadCompany = new TextEditingController();
  TextEditingController editTitleNameFatherHeadCompany = new TextEditingController();
  TextEditingController editTitleNameMotherHeadCompany = new TextEditingController();
  TextEditingController editTitleNameFather = new TextEditingController();
  TextEditingController editTitleNameMother = new TextEditingController();

  GlobalKey key_title = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();

  void setAutoCompleteTitle(){
    _textListTitleName = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleName,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item){
        setState(() {
          _textListTitleName.textField.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          sTitle = item;
        });
      },
      key: key_title,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sTitle==null
          ?new Padding(
          child: new ListTile(
            title: new Text(
              suggestion.TITLE_SHORT_NAME_TH.toString(),style: textInputStyle,)),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sTitle=null;
        return (suggestion.TITLE_SHORT_NAME_TH!=null
            ?suggestion.TITLE_SHORT_NAME_TH
            :suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteTitleHeadCompany(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameHeadCompany = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameHeadCompany,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item){
        setState(() {
          _textListTitleNameHeadCompany.textField.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          sTitleHeadCompany = item;
        });
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sTitleHeadCompany==null
          ?new Padding(
          child: new ListTile(
              title: new Text(
                suggestion.TITLE_SHORT_NAME_TH.toString(),style: textInputStyle,)),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sTitleHeadCompany=null;
        return (suggestion.TITLE_SHORT_NAME_TH!=null
            ?suggestion.TITLE_SHORT_NAME_TH
            :suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }
  void setAutoCompleteTitleFatherHeadCompany(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameFatherHeadCompany = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameFatherHeadCompany,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item){
        setState(() {
          _textListTitleNameFatherHeadCompany.textField.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          sTitleFatherHeadCompany = item;
        });
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sTitleFatherHeadCompany==null
          ?new Padding(
          child: new ListTile(
              title: new Text(
                suggestion.TITLE_SHORT_NAME_TH.toString(),style: textInputStyle,)),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sTitleFatherHeadCompany=null;
        return (suggestion.TITLE_SHORT_NAME_TH!=null
            ?suggestion.TITLE_SHORT_NAME_TH
            :suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }
  void setAutoCompleteTitleMotherCompany(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameMotherHeadCompany = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameMotherHeadCompany,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item){
        setState(() {
          _textListTitleNameMotherHeadCompany.textField.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          sTitleMotherHeadCompany = item;
        });
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sTitleMotherHeadCompany==null
          ?new Padding(
          child: new ListTile(
              title: new Text(
                suggestion.TITLE_SHORT_NAME_TH.toString(),style: textInputStyle,)),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sTitleMotherHeadCompany=null;
        return (suggestion.TITLE_SHORT_NAME_TH!=null
            ?suggestion.TITLE_SHORT_NAME_TH
            :suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }
  void setAutoCompleteTitleFather(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameFather = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameFather,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item){
        setState(() {
          _textListTitleNameFather.textField.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          sTitleFather = item;
        });
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sTitleFather==null
          ?new Padding(
          child: new ListTile(
              title: new Text(
                suggestion.TITLE_SHORT_NAME_TH.toString(),style: textInputStyle,)),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sTitleFather=null;
        return (suggestion.TITLE_SHORT_NAME_TH!=null
            ?suggestion.TITLE_SHORT_NAME_TH
            :suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }
  void setAutoCompleteTitleMother(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameMother = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameMother,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item){
        setState(() {
          _textListTitleNameMother.textField.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          sTitleMother = item;
        });
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sTitleMother==null
          ?new Padding(
          child: new ListTile(
              title: new Text(
                suggestion.TITLE_SHORT_NAME_TH.toString(),style: textInputStyle,)),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sTitleMother=null;
        return (suggestion.TITLE_SHORT_NAME_TH!=null
            ?suggestion.TITLE_SHORT_NAME_TH
            :suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }


  //ข้อมูลที่อยู่
  AutoCompleteTextField _textListCountry;
  AutoCompleteTextField _textListProvince;
  AutoCompleteTextField _textListDistrict;
  AutoCompleteTextField _textListSubDistrict;
  TextEditingController editCountry = new TextEditingController();
  TextEditingController editProvince = new TextEditingController();
  TextEditingController editDistrict = new TextEditingController();
  TextEditingController editSubDistrict = new TextEditingController();

  //
  AutoCompleteTextField _textListCountry2;
  AutoCompleteTextField _textListProvince2;
  AutoCompleteTextField _textListDistrict2;
  AutoCompleteTextField _textListSubDistrict2;
  TextEditingController editCountry2= new TextEditingController();
  TextEditingController editProvince2 = new TextEditingController();
  TextEditingController editDistrict2 = new TextEditingController();
  TextEditingController editSubDistrict2 = new TextEditingController();

  //Address Type 1
  void setAutoCompleteCountry(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListCountry>>();
    _textListCountry =
    new AutoCompleteTextField<ItemsListCountry>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editCountry,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListCountry.textField.controller.text =
              item.COUNTRY_NAME_TH.toString();

          sCountry = item;
          sProvince =null;
          sDistrict=null;
          sSubDistrict=null;
          _onSelectCountry(sCountry.COUNTRY_ID);
          /*if(widget.ItemCountry!=null){
            widget.ItemCountry.RESPONSE_DATA.forEach((f) {
              if (f.COUNTRY_NAME_TH.endsWith(sCountry.COUNTRY_NAME_TH)) {
                _onSelectCountry(f.COUNTRY_ID);
              }
            });
          }*/
        });
      },
      key: key,
      suggestions: widget.ItemCountry.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sCountry==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.COUNTRY_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.COUNTRY_ID == b.COUNTRY_ID ? 0 : a.COUNTRY_ID > b.COUNTRY_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sCountry=null;
        return suggestion.COUNTRY_NAME_TH.trim().startsWith(input.trim());
      },
    );
  }
  void setAutoCompleteProvince(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListProvince>>();
    _textListProvince =
    new AutoCompleteTextField<ItemsListProvince>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editProvince,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProvince.textField.controller.text =
              item.PROVINCE_NAME_TH.toString();

          sProvince = item;

          editDistrict.text="";
          editSubDistrict.text="";
          sDistrict = null;
          sSubDistrict = null;

          _onSelectProvince(sProvince
              .PROVINCE_ID);
        });
      },
      key: key,
      suggestions: ItemProvince.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sProvince==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.PROVINCE_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.PROVINCE_ID == b.PROVINCE_ID ? 0 : a.PROVINCE_ID > b.PROVINCE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sProvince=null;
        return suggestion.PROVINCE_NAME_TH.trim().startsWith(input.trim());
      },
    );
  }
  void setAutoCompleteDistrict(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListDistict>>();
    _textListDistrict =
    new AutoCompleteTextField<ItemsListDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListDistrict.textField.controller.text =
              item.DISTRICT_NAME_TH.toString();

          sDistrict = item;
          ItemDistrict.RESPONSE_DATA.forEach((f) {
            if (f.DISTRICT_NAME_TH.endsWith(
                sDistrict.DISTRICT_NAME_TH)) {

              editSubDistrict.text="";
              sSubDistrict = null;
              _onSelectDistrict(f.DISTRICT_ID);
            }
          });
        });
      },
      key: key,
      suggestions: ItemDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sDistrict==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.DISTRICT_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.DISTRICT_ID == b.DISTRICT_ID ? 0 : a.DISTRICT_ID > b.DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sDistrict = null;
        return suggestion.DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }
  void setAutoCompleteSubDistrict(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListSubDistict>>();
    _textListSubDistrict =
    new AutoCompleteTextField<ItemsListSubDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editSubDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListSubDistrict.textField.controller.text =
              item.SUB_DISTRICT_NAME_TH.toString();

          sSubDistrict = item;
        });
      },
      key: key,
      suggestions: ItemSubDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sSubDistrict==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.SUB_DISTRICT_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.SUB_DISTRICT_ID == b.SUB_DISTRICT_ID ? 0 : a.SUB_DISTRICT_ID > b.SUB_DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sSubDistrict = null;
        return suggestion.SUB_DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }

  //Address Type 2
  void setAutoCompleteCountry2(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListCountry>>();
    _textListCountry2 =
    new AutoCompleteTextField<ItemsListCountry>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editCountry2,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListCountry2.textField.controller.text =
              item.COUNTRY_NAME_TH.toString();

          sCountry2 = item;
          sProvince2 =null;
          sDistrict2=null;
          sSubDistrict2=null;
          _onSelectCountry(sCountry2.COUNTRY_ID);
          /*if(widget.ItemCountry!=null){
            widget.ItemCountry.RESPONSE_DATA.forEach((f) {
              if (f.COUNTRY_NAME_TH.endsWith(sCountry.COUNTRY_NAME_TH)) {
                _onSelectCountry(f.COUNTRY_ID);
              }
            });
          }*/
        });
      },
      key: key,
      suggestions: widget.ItemCountry.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sCountry2==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.COUNTRY_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.COUNTRY_ID == b.COUNTRY_ID ? 0 : a.COUNTRY_ID > b.COUNTRY_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sCountry2=null;
        return suggestion.COUNTRY_NAME_TH.trim().startsWith(input.trim());
      },
    );
  }
  void setAutoCompleteProvince2(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListProvince>>();
    _textListProvince2 =
    new AutoCompleteTextField<ItemsListProvince>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editProvince2,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProvince2.textField.controller.text =
              item.PROVINCE_NAME_TH.toString();

          sProvince2 = item;

          editDistrict2.text="";
          editSubDistrict2.text="";
          sDistrict2 = null;
          sSubDistrict2 = null;

          print(sProvince2.PROVINCE_NAME_TH);
          _onSelectProvince(sProvince2
              .PROVINCE_ID);
        });
      },
      key: key,
      suggestions: ItemProvince.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sProvince2==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.PROVINCE_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.PROVINCE_ID == b.PROVINCE_ID ? 0 : a.PROVINCE_ID > b.PROVINCE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sProvince2=null;
        return suggestion.PROVINCE_NAME_TH.trim().startsWith(input.trim());
      },
    );
  }
  void setAutoCompleteDistrict2(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListDistict>>();
    _textListDistrict2 =
    new AutoCompleteTextField<ItemsListDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editDistrict2,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListDistrict2.textField.controller.text =
              item.DISTRICT_NAME_TH.toString();

          sDistrict2 = item;
          ItemDistrict.RESPONSE_DATA.forEach((f) {
            if (f.DISTRICT_NAME_TH.endsWith(
                sDistrict2.DISTRICT_NAME_TH)) {

              editSubDistrict2.text="";
              sSubDistrict2 = null;
              _onSelectDistrict(f.DISTRICT_ID);
            }
          });
        });
      },
      key: key,
      suggestions: ItemDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sDistrict2==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.DISTRICT_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.DISTRICT_ID == b.DISTRICT_ID ? 0 : a.DISTRICT_ID > b.DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sDistrict2 = null;
        return suggestion.DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }
  void setAutoCompleteSubDistrict2(){
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListSubDistict>>();
    _textListSubDistrict2 =
    new AutoCompleteTextField<ItemsListSubDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editSubDistrict2,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListSubDistrict2.textField.controller.text =
              item.SUB_DISTRICT_NAME_TH.toString();

          sSubDistrict2 = item;
        });
      },
      key: key,
      suggestions: ItemSubDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sSubDistrict2==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.SUB_DISTRICT_NAME_TH,style: textInputStyle),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.SUB_DISTRICT_ID == b.SUB_DISTRICT_ID ? 0 : a.SUB_DISTRICT_ID > b.SUB_DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sSubDistrict2 = null;
        return suggestion.SUB_DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }


  Widget _buildInputType1() {
    var size = MediaQuery
        .of(context)
        .size;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _nationalityType1 ? Column(
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text("หมายเลขบัตรประชาชน",
                    style: textLabelStyle,),
                ],
              ),
            ),
            Padding(
              padding: paddingInputBox,
              child: TextField(
                //maxLength: 14,
                focusNode: myFocusNodeIdentifyNumber,
                controller: editIdentifyNumber,
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
        ) : Container(),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("เลขที่หนังสือเดินทาง",
                style: textLabelStyle,),
              _nationalityType2
                  ? Text(" *", style: textStyleStar,)
                  : Container(),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodePassportNo,
            controller: editPassportNo,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),

          ),
        ),
        _buildLine,
        _nationalityType2 ? Column(
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text("ประเทศหนังสือเดินทาง",
                    style: textLabelStyle,),
                ],
              ),
            ),
            Padding(
              padding: paddingInputBox,
              child: TextField(
                //maxLength: 14,
                focusNode: myFocusNodePassportCountry,
                controller: editPassportCountry,
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
        ) : Container(),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("คำนำหน้าชื่อ",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: /*DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListTitle>(
              isExpanded: true,
              value: sTitle,
              onChanged: (ItemsListTitle newValue) {
                setState(() {
                  sTitle = newValue;
                });
              },
              items: widget.ItemTitle.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListTitle>>((
                  ItemsListTitle value) {
                return DropdownMenuItem<ItemsListTitle>(
                  value: value,
                  child: Text(value.TITLE_SHORT_NAME_TH == null
                      ? value.TITLE_NAME_TH
                      : value.TITLE_SHORT_NAME_TH
                    , style: textInputStyle,),
                );
              })
                  .toList(),
            ),
          ),*/
            _textListTitleName
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("ชื่อผู้ต้องหา",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameSus,
            controller: editFirstNameSus,
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
          child: Row(
            children: <Widget>[
              Text("นามสกุลผู้ต้องหา",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameSus,
            controller: editLastNameSus,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        _nationalityType2 ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text("ประเทศ",
                    style: textLabelStyle,),
                  //Text(" *", style: textStyleStar,),
                ],
              ),
            ),
            Container(
              width: size.width,
              //padding: paddingInputBox,
              child: /*DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListCountry>(
              isExpanded: true, //
              value: sCountry,
              onChanged: (ItemsListCountry newValue) {
                setState(() {
                  sCountry = newValue;
                  if(widget.ItemCountry!=null){
                    widget.ItemCountry.RESPONSE_DATA.forEach((f) {
                      if (f.COUNTRY_NAME_TH.endsWith(sCountry.COUNTRY_NAME_TH)) {
                        _onSelectCountry(f.COUNTRY_ID);
                      }
                    });
                  }

                });
              },
              items: widget.ItemCountry!=null
                  ?widget.ItemCountry.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListCountry>>((
                  ItemsListCountry value) {
                return DropdownMenuItem<ItemsListCountry>(
                  value: value,
                  child: Text(value.COUNTRY_NAME_TH, style: textInputStyle,),
                );
              })
                  .toList():[],
            ),
          ),*/
              _textListCountry,
            ),
            _buildLine,
          ],
        ) : Container(),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("จังหวัด",
                style: textLabelStyle,),
              /*_nationalityType1
                  ? Text(" *", style: textStyleStar,)
                  : Container(),*/
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: ItemProvince != null ? DropdownButton<ItemsListProvince>(
              isExpanded: true, //
              value: sProvince,
              onChanged: (ItemsListProvince newValue) {
                setState(() {
                  sProvince = newValue;
                  ItemProvince.RESPONSE_DATA.forEach((f) {
                    if (f.PROVINCE_NAME_TH.endsWith(
                        sProvince.PROVINCE_NAME_TH)) {
                      sDistrict=null;
                      sSubDistrict=null;
                      _onSelectProvince(f.PROVINCE_ID);
                    }
                  });
                });
              },
              items: ItemProvince.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListProvince>>((
                  ItemsListProvince value) {
                return DropdownMenuItem<ItemsListProvince>(
                  value: value,
                  child: Text(value.PROVINCE_NAME_TH, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel,
              child: Container(),),
          ),*/_textListProvince,
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("อำเภอ/เขต",
                style: textLabelStyle,),
              /*_nationalityType1
                  ? Text(" *", style: textStyleStar,)
                  : Container(),*/
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: ItemDistrict != null ? DropdownButton<ItemsListDistict>(
              isExpanded: true, //
              value: sDistrict,
              onChanged: (ItemsListDistict newValue) {
                setState(() {
                  sDistrict = newValue;
                  ItemDistrict.RESPONSE_DATA.forEach((f) {
                    if (f.DISTRICT_NAME_TH.endsWith(
                        sDistrict.DISTRICT_NAME_TH)) {
                      sSubDistrict=null;
                      _onSelectDistrict(f.DISTRICT_ID);
                    }
                  });
                });
              },
              items: ItemDistrict.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListDistict>>((
                  ItemsListDistict value) {
                return DropdownMenuItem<ItemsListDistict>(
                  value: value,
                  child: Text(value.DISTRICT_NAME_TH, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel,
              child: Container(),),
          ),*/
          _textListDistrict,
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("ตำบล/แขวง",
                style: textLabelStyle,),
              /*_nationalityType1
                  ? Text(" *", style: textStyleStar,)
                  : Container(),*/
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: ItemSubDistrict != null ? DropdownButton<
                ItemsListSubDistict>(
              isExpanded: true, //
              value: sSubDistrict,
              onChanged: (ItemsListSubDistict newValue) {
                setState(() {
                  sSubDistrict = newValue;
                });
              },
              items: ItemSubDistrict.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListSubDistict>>((
                  ItemsListSubDistict value) {
                return DropdownMenuItem<ItemsListSubDistict>(
                  value: value,
                  child: Text(
                    value.SUB_DISTRICT_NAME_TH, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel,
              child: Container(),),
          ),*/
          _textListSubDistrict,
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("คำนำหน้าชื่อ",
            style: textLabelStyle,),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: /*DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListTitle>(
              value: sTitleFather,
              onChanged: (ItemsListTitle newValue) {
                setState(() {
                  sTitleFather = newValue;
                });
              },
              items: widget.ItemTitle.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListTitle>>((
                  ItemsListTitle value) {
                return DropdownMenuItem<ItemsListTitle>(
                  value: value,
                  child: Text(value.TITLE_SHORT_NAME_TH == null
                      ? value.TITLE_NAME_TH
                      : value.TITLE_SHORT_NAME_TH
                    , style: textInputStyle,),
                );
              })
                  .toList(),
            ),
          ),*/
            _textListTitleNameFather
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("ชื่อบิดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameFather_1,
            controller: editFirstNameFather,
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
          child: Text("นามสกุลบิดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameFather_1,
            controller: editLastNameFather,
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
          child: Text("คำนำหน้าชื่อ",
            style: textLabelStyle,),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: /*DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListTitle>(
              value: sTitleMother,
              onChanged: (ItemsListTitle newValue) {
                setState(() {
                  sTitleMother = newValue;
                });
              },
              items: widget.ItemTitle.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListTitle>>((
                  ItemsListTitle value) {
                return DropdownMenuItem<ItemsListTitle>(
                  value: value,
                  child: Text(value.TITLE_SHORT_NAME_TH == null
                      ? value.TITLE_NAME_TH
                      : value.TITLE_SHORT_NAME_TH
                    , style: textInputStyle,),
                );
              })
                  .toList(),
            ),
          ),*/
            _textListTitleNameMother
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("ชื่อมารดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameMother_1,
            controller: editFirstNameMother,
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
          child: Text("นามสกุลมารดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameMother_1,
            controller: editLastNameMother,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /*Container(
          padding: paddingLabel,
          child: Text("ที่อยู่สถานที่ประกอบ (ตำบล/อำเภอ/จังหวัด)",
            style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodePlace,
            controller: editPlace,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,*/
      ],
    );
  }

  Widget _buildInputType2() {
    var size = MediaQuery
        .of(context)
        .size;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("เลขนิติบุคคล",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodeEntityNumber,
            controller: editEntityNumber,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        _nationalityType2 ? Column(
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text("เลขที่หนังสือเดินทาง",
                    style: textLabelStyle,),
                  _nationalityType2
                      ? Text(" *", style: textStyleStar,)
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: paddingInputBox,
              child: TextField(
                //maxLength: 14,
                focusNode: myFocusNodePassportNo,
                controller: editPassportNo,
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
        ) : Container(),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("ชื่อสถานประกอบการ",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,)
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyName,
            controller: editCompanyName,
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
          child: Text("เลขทะเบียนสรรพสามิต", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeExciseRegistrationNumber,
            controller: editExciseRegistrationNumber,
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
          child: Row(
            children: <Widget>[
              Text("คำนำหน้าชื่อตัวแทนสถานประกอบการ",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListTitle>(
              value: sTitleHeadCompany,
              onChanged: (ItemsListTitle newValue) {
                setState(() {
                  sTitleHeadCompany = newValue;
                });
              },
              items: widget.ItemTitle.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListTitle>>((
                  ItemsListTitle value) {
                return DropdownMenuItem<ItemsListTitle>(
                  value: value,
                  child: Text(value.TITLE_SHORT_NAME_TH == null
                      ? value.TITLE_NAME_TH
                      : value.TITLE_SHORT_NAME_TH
                    , style: textInputStyle,),
                );
              })
                  .toList(),
            ),
          ),*/
          _textListTitleNameHeadCompany
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("ชื่อตัวแทนสถานประกอบการ",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyHeadFirstName,
            controller: editCompanyHeadFirstName,
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
          child: Row(
            children: <Widget>[
              Text("นามสกุลตัวแทนสถานประกอบการ",
                style: textLabelStyle,),
              Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyHeadLastName,
            controller: editCompanyHeadLastName,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        _nationalityType2 ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text("ประเทศ",
                    style: textLabelStyle,),
                  Text(" *", style: textStyleStar,),
                ],
              ),
            ),
            Container(
              width: size.width,
              //padding: paddingInputBox,
              child: /*DropdownButtonHideUnderline(
                child: DropdownButton<ItemsListCountry>(
                  isExpanded: true, //
                  value: sCountry2,
                  onChanged: (ItemsListCountry newValue) {
                    setState(() {
                      sCountry2 = newValue;
                      widget.ItemCountry.RESPONSE_DATA.forEach((f) {
                        if (f.COUNTRY_NAME_TH.endsWith(
                            sCountry.COUNTRY_NAME_TH)) {
                          _onSelectCountry(f.COUNTRY_ID);
                        }
                      });
                    });
                  },
                  items: widget.ItemCountry.RESPONSE_DATA
                      .map<DropdownMenuItem<ItemsListCountry>>((
                      ItemsListCountry value) {
                    return DropdownMenuItem<ItemsListCountry>(
                      value: value,
                      child: Text(
                        value.COUNTRY_NAME_TH, style: textInputStyle,),
                    );
                  })
                      .toList(),
                ),
              ),*/
              _textListCountry2,
            ),
            _buildLine,
          ],
        ) : Container(),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("จังหวัด",
                style: textLabelStyle,),
              /*_nationalityType1
                  ? Text(" *", style: textStyleStar,)
                  : Container(),*/
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: ItemProvince != null ? DropdownButton<ItemsListProvince>(
              isExpanded: true, //
              value: sProvince2,
              onChanged: (ItemsListProvince newValue) {
                setState(() {
                  sProvince2 = newValue;
                  ItemProvince.RESPONSE_DATA.forEach((f) {
                    if (f.PROVINCE_NAME_TH.endsWith(
                        sProvince2.PROVINCE_NAME_TH)) {
                      sDistrict2 = null;
                      sSubDistrict2 = null;
                      _onSelectProvince(f.PROVINCE_ID);
                    }
                  });
                });
              },
              items: ItemProvince.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListProvince>>((
                  ItemsListProvince value) {
                return DropdownMenuItem<ItemsListProvince>(
                  value: value,
                  child: Text(value.PROVINCE_NAME_TH, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel, child: Container(),),
          ),*/
          _textListProvince2
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("อำเภอ/เขต",
                style: textLabelStyle,),
              /*_nationalityType1
                  ? Text(" *", style: textStyleStar,)
                  : Container(),*/
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: ItemDistrict != null ? DropdownButton<ItemsListDistict>(
              isExpanded: true, //
              value: sDistrict2,
              onChanged: (ItemsListDistict newValue) {
                setState(() {
                  sDistrict2 = newValue;
                  ItemDistrict.RESPONSE_DATA.forEach((f) {
                    if (f.DISTRICT_NAME_TH.endsWith(
                        sDistrict2.DISTRICT_NAME_TH)) {
                      sSubDistrict2 = null;
                      _onSelectDistrict(f.DISTRICT_ID);
                    }
                  });
                });
              },
              items: ItemDistrict.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListDistict>>((
                  ItemsListDistict value) {
                return DropdownMenuItem<ItemsListDistict>(
                  value: value,
                  child: Text(value.DISTRICT_NAME_TH, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel, child: Container(),),
          ),*/
          _textListDistrict2
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text("ตำบล/แขวง",
                style: textLabelStyle,),
              /*_nationalityType1
                  ? Text(" *", style: textStyleStar,)
                  : Container(),*/
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: ItemSubDistrict != null ? DropdownButton<
                ItemsListSubDistict>(
              isExpanded: true, //
              value: sSubDistrict2,
              onChanged: (ItemsListSubDistict newValue) {
                setState(() {
                  sSubDistrict2 = newValue;
                });
              },
              items: ItemSubDistrict.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListSubDistict>>((
                  ItemsListSubDistict value) {
                return DropdownMenuItem<ItemsListSubDistict>(
                  value: value,
                  child: Text(
                    value.SUB_DISTRICT_NAME_TH, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel, child: Container(),),
          ),*/
          _textListSubDistrict2
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("คำนำหน้าชื่อ",
            style: textLabelStyle,),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListTitle>(
              value: sTitleFatherHeadCompany,
              onChanged: (ItemsListTitle newValue) {
                setState(() {
                  sTitleFatherHeadCompany = newValue;
                });
              },
              items: widget.ItemTitle.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListTitle>>((
                  ItemsListTitle value) {
                return DropdownMenuItem<ItemsListTitle>(
                  value: value,
                  child: Text(value.TITLE_SHORT_NAME_TH == null
                      ? value.TITLE_NAME_TH
                      : value.TITLE_SHORT_NAME_TH
                    , style: textInputStyle,),
                );
              })
                  .toList(),
            ),
          ),*/
          _textListTitleNameFatherHeadCompany
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("ชื่อบิดาตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameFather_2,
            controller: editFirstNameFather_2,
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
          child: Text("นามสกุลบิดาตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameFather_2,
            controller: editLastNameFather_2,
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
          child: Text("คำนำหน้าชื่อ",
            style: textLabelStyle,),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: /*DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListTitle>(
              value: sTitleMotherHeadCompany,
              onChanged: (ItemsListTitle newValue) {
                setState(() {
                  sTitleMotherHeadCompany = newValue;
                });
              },
              items: widget.ItemTitle.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListTitle>>((
                  ItemsListTitle value) {
                return DropdownMenuItem<ItemsListTitle>(
                  value: value,
                  child: Text(value.TITLE_SHORT_NAME_TH == null
                      ? value.TITLE_NAME_TH
                      : value.TITLE_SHORT_NAME_TH
                    , style: textInputStyle,),
                );
              })
                  .toList(),
            ),
          ),*/
          _textListTitleNameMotherHeadCompany,
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("ชื่อมารดาตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameMother_2,
            controller: editFirstNameMother_2,
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
          child: Text("นามสกุลมารดาตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameMother_2,
            controller: editLastNameMother_2,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
      ],
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery
        .of(context)
        .size;
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor,fontFamily: FontStyles().FontFamily);
    return Container(
      padding: EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: boxColor, width: 1.5),
                  borderRadius: BorderRadius.circular(42.0)
              ),
              elevation: 0.0,
              child: Container(
                width: size.width / 2,
                child: MaterialButton(
                  onPressed: () {
                    //_onImageButtonPressed(ImageSource.gallery, context);
                    getImage();
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.file_upload, size: 32, color: uploadColor,),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "แนบรูปผู้ต้องหา", style: textLabelStyle,),
                          ),

                        ],
                      )
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
  Widget _buildDataImage(BuildContext context) {
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      child: ListView.builder(
          itemCount: _arrItemsImageFile.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.3, bottom: 0.3),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: ListTile(
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white30),
                      ),
                      //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Image.file(_arrItemsImageFile[index],fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageName[index],
                      style: textInputStyleTitle,),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: Icon(Icons.delete_outline,size: 32.0,),
                        onPressed: (){
                          setState(() {
                            //print(index.toString());
                            _arrItemsImageFile.removeAt(index);
                            _arrItemsImageName.removeAt(index);
                            if(_arrItemsImageFile.length==0){
                              isImage=false;
                            }
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      //
                    }
                ),
              ),
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
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
                  Navigator.pop(context, "back");
                }),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  /*String SuspectType;
                  String IdentifyNumber;
                  String NationalityType;
                  String NameTitle;
                  String NameSus;
                  String NameFather;
                  String NameMother;
                  String Place;
                  int OffenseCount = 0;
                  bool isCheck = false;

                  String EntityNumber;
                  String CompanyName;
                  String ExciseRegistrationNumber;

                  if (_nationalityType1) {
                    NationalityType = "คนไทย";
                  } else {
                    NationalityType = "คนต่างชาติ";
                  }
                  if (_suspectType1) {
                    SuspectType = "บุคคลธรรมดา";
                    IdentifyNumber = editIdentifyNumber.text;
                    NameTitle = *//*dropdownValue_1*//*"";
                    NameSus = editNameSus.text;
                    NameFather = editFather.text;
                    NameMother = editMother.text;
                    Place = editPlace.text;
                    EntityNumber = null;
                    CompanyName = null;
                    ExciseRegistrationNumber = null;
                  } else {
                    SuspectType = "นิติบุคคล";
                    IdentifyNumber = null;
                    NameTitle = dropdownValue_2;
                    NameSus = editCompanyHeadName.text;
                    NameFather = editNameFather_2.text;
                    NameMother = editNameMother_2.text;
                    Place = null;
                    EntityNumber = editEntityNumber.text;
                    CompanyName = editCompanyName.text;
                    ExciseRegistrationNumber =
                        editExciseRegistrationNumber.text;
                  }*/
                  //สร้างผู้ต้องหา
                  /*_itemData.add(new ItemsListArrest4(
                      SuspectType,
                      NationalityType,
                      IdentifyNumber,
                      NameTitle,
                      NameSus,
                      NameFather,
                      NameMother,
                      Place,
                      OffenseCount,
                      isCheck,
                      EntityNumber,
                      CompanyName,
                      ExciseRegistrationNumber,
                      "",
                      0));*/

                  _onSaved(context);

                 // Navigator.pop(context, _itemData);
                },
                child: Text("บันทึก",
                  style: styleTextAppbar,
                ),
              ),
            ],
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
                          child: new Text('ILG60_B_01_00_14_00',
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
                          child: Column(
                            children: <Widget>[
                              _buildContent(context),
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  void _onSaved(mContext)async {
    bool IsSuccess = false;
    if (_suspectType1) {
      if (_nationalityType1) {if (sTitle == null) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณาเลือกคำนำหน้าชื่อผู้ต้องหา');
        } else if (editFirstNameSus.text.isEmpty||editLastNameSus.text.isEmpty) {
          _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกชื่อผู้ต้องหา');
        }else {
          IsSuccess = true;
        }
      } else {
        if (editPassportNo.text.isEmpty) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณากรอกเลขที่หนังสือเดินทาง');
        } else if (sTitle == null) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณาเลือกคำนำหน้าชื่อผู้ต้องหา');
        } else if (editFirstNameSus.text.isEmpty||editLastNameSus.text.isEmpty) {
          _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกชื่อผู้ต้องหา');
        } else {
          IsSuccess = true;
        }
      }
    } else {
      if (_nationalityType1) {
        if (editEntityNumber.text.isEmpty) {
          _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกเลขนิติบุคคล');
        } else if (editCompanyName.text.isEmpty) {
          _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกชื่อสถานประกอบการ');
        } else if (sTitleHeadCompany == null) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณาเลือกคำนำหน้าชื่อตัวแทนสถานประกอบการ');
        } else if (editCompanyHeadFirstName.text.isEmpty||editCompanyHeadLastName.text.isEmpty) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณาเลือกคำนำหน้าชื่อตัวแทนสถานประกอบการ');
        } else {
          IsSuccess = true;
        }
      } else {
        if (editEntityNumber.text.isEmpty) {
          _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกเลขนิติบุคคล');
        } else if (editPassportNo.text.isEmpty) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณากรอกเลขที่หนังสือเดินทาง');
        } else if (editCompanyName.text.isEmpty) {
          _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกชื่อสถานประกอบการ');
        } else if (sTitleHeadCompany == null) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณาเลือกคำนำหน้าชื่อตัวแทนสถานประกอบการ');
        } else if (editCompanyHeadFirstName.text.isEmpty||editCompanyHeadLastName.text.isEmpty) {
          _showSearchEmptyAlertDialog(
              mContext, 'กรุณาเลือกคำนำหน้าชื่อตัวแทนสถานประกอบการ');
        }else {
          IsSuccess = true;
        }
      }
    }

    if (IsSuccess) {
      String firstname, lastname;
      String fa_firstname = "",
          fa_lastname = "";
      String mo_firstname = "",
          mo_lastname = "";
      int entity_type, person_type;
      var ItemTitle;
      var ItemFatherTitle;
      var ItemMotherTitle;
      var ItemCountry;
      var ItemProvince;
      var ItemDistrict;
      var ItemSubDistrict;
      if (_suspectType1) {
        ItemTitle = sTitle;
        ItemFatherTitle = sTitleFather;
        ItemMotherTitle = sTitleMother;
        ItemCountry = sCountry;
        ItemProvince = sProvince;
        ItemDistrict = sDistrict;
        ItemSubDistrict = sSubDistrict;

        entity_type = 0;
        /*List splitsName = editNameSus.text.split(" ");
        if (splitsName.length > 1) {
          firstname = splitsName[0];
          lastname = splitsName[1];
        } else {
          firstname = splitsName[0];
          lastname = "";
        }*/
        firstname = editFirstNameSus.text;
        lastname = editLastNameSus.text;

        fa_firstname = editFirstNameFather.text;
        fa_lastname = editLastNameFather.text;

        mo_firstname = editFirstNameMother.text;
        mo_lastname = editLastNameMother.text;
        /*List splitsFaName = editFather.text.split(" ");
        if (splitsFaName.length > 1) {
          fa_firstname = splitsFaName[0];
          fa_lastname = splitsFaName[1];
        } else {
          fa_firstname = splitsFaName[0];
          fa_lastname = "";
        }
        List splitsMoName = editMother.text.split(" ");
        if (splitsMoName.length > 1) {
          mo_firstname = splitsMoName[0];
          mo_lastname = splitsMoName[1];
        } else {
          mo_firstname = splitsMoName[0];
          mo_lastname = "";
        }*/
      } else {
        ItemTitle = sTitleHeadCompany;
        ItemFatherTitle = sTitleFatherHeadCompany;
        ItemMotherTitle = sTitleMotherHeadCompany;
        ItemCountry = sCountry2;
        ItemProvince = sProvince2;
        ItemDistrict = sDistrict2;
        ItemSubDistrict = sSubDistrict2;

        entity_type = 1;

        firstname = editCompanyHeadFirstName.text;
        lastname = editCompanyHeadLastName.text;
        /*List splitsName = editCompanyHeadName.text.split(" ");
        if (splitsName.length > 1) {
          firstname = splitsName[0];
          lastname = splitsName[1];
        } else {
          firstname = splitsName[0];
          lastname = "";
        }*/

        fa_firstname = editFirstNameFather_2.text;
        fa_lastname = editLastNameFather_2.text;

        /*List splitsFaName = editNameFather_2.text.split(" ");
        if (splitsFaName.length > 1) {
          fa_firstname = splitsFaName[0];
          fa_lastname = splitsFaName[1];
        } else {
          fa_firstname = splitsFaName[0];
          fa_lastname = "";
        }*/

        mo_firstname = editFirstNameMother_2.text;
        mo_lastname = editLastNameMother_2.text;

        /*List splitsMoName = editNameMother_2.text.split(" ");
        if (splitsMoName.length > 1) {
          mo_firstname = splitsMoName[0];
          mo_lastname = splitsMoName[1];
        } else {
          mo_firstname = splitsMoName[0];
          mo_lastname = "";
        }*/
      }

      if (_nationalityType1) {
        person_type = 0;
      } else {
        person_type = 1;
      }

      String id_card = "";
      if (_suspectType1 && _nationalityType1) {
        id_card = editIdentifyNumber.text;
      }
      String COMPANY_NAME = "";
      String COMPANY_REGISTRATION_NO = "";
      String EXCISE_REGISTRATION_NO = "";
      if (_suspectType2 && _nationalityType1) {
        COMPANY_NAME = editCompanyName.text;
        COMPANY_REGISTRATION_NO = editEntityNumber.text;
        EXCISE_REGISTRATION_NO = editExciseRegistrationNumber.text;
      }

      if (!widget.IsUpdate) {
        List<Map> map_relationship = [];
        if(ItemFatherTitle!=null){
          map_relationship.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 1,
            "PERSON_ID": "",
            "TITLE_ID": ItemFatherTitle.TITLE_ID ,
            "TITLE_NAME_TH": ItemFatherTitle.TITLE_NAME_TH,
            "TITLE_NAME_EN": ItemFatherTitle.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": ItemFatherTitle.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": ItemFatherTitle.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": fa_firstname,
            "MIDDLE_NAME": "",
            "LAST_NAME": fa_lastname,
            "OTHER_NAME": "",
            "GENDER_TYPE": 1,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }
        if(ItemMotherTitle!=null){
          map_relationship.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 2,
            "PERSON_ID": "",
            "TITLE_ID": ItemMotherTitle.TITLE_ID,
            "TITLE_NAME_TH": ItemMotherTitle.TITLE_NAME_TH,
            "TITLE_NAME_EN": ItemMotherTitle.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": ItemMotherTitle.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": ItemMotherTitle.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": mo_firstname,
            "MIDDLE_NAME": "",
            "LAST_NAME": mo_lastname,
            "OTHER_NAME": "",
            "GENDER_TYPE": 0,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }

        List<Map> map_photo = [];
        _arrItemsImageFile.forEach((file) {
          List<int> imageBytes = file.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          map_photo.add({
            "PHOTO_ID": "",
            "PERSON_ID": "",
            "PERSON_RELATIONSHIP_ID": "",
            "PHOTO": base64Image,
            "TYPE": "",
            "IS_ACTIVE": 1
          });
        });

        Map map = {
          "PERSON_ID": "",
          "COUNTRY_ID": ItemCountry!=null?ItemCountry.COUNTRY_ID:"",
          "NATIONALITY_ID": 1,
          "RACE_ID": 1,
          "RELIGION_ID": 1,
          "TITLE_ID": ItemTitle.TITLE_ID,
          "PERSON_TYPE": person_type,
          "ENTITY_TYPE": entity_type,
          "TITLE_NAME_TH": ItemTitle.TITLE_NAME_TH,
          "TITLE_NAME_EN": ItemTitle.TITLE_NAME_EN,
          "TITLE_SHORT_NAME_TH": ItemTitle.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": ItemTitle.TITLE_SHORT_NAME_EN,
          "FIRST_NAME": firstname,
          "MIDDLE_NAME": "",
          "LAST_NAME": lastname,
          "OTHER_NAME": "",
          "COMPANY_NAME" : COMPANY_NAME,
          "COMPANY_REGISTRATION_NO": COMPANY_REGISTRATION_NO,
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": EXCISE_REGISTRATION_NO,
          "GENDER_TYPE": 0,
          "ID_CARD": id_card,
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": editPassportNo.text,
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": "",
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
          "MasPersonAddress":ItemSubDistrict!=null?
          [
            {
              "PERSON_ADDRESS_ID": "",
              "PERSON_ID": "",
              "SUB_DISTRICT_ID": ItemSubDistrict.SUB_DISTRICT_ID,
              "GPS": "",
              "ADDRESS_NO": "",
              "VILLAGE_NO": "",
              "BUILDING_NAME": "",
              "ROOM_NO": "",
              "FLOOR": "22",
              "VILLAGE_NAME": "",
              "ALLEY": "",
              "LANE": "",
              "ROAD": "",
              "ADDRESS_TYPE": 0,
              "ADDRESS_DESC": "",
              "ADDRESS_STATUS": 0,
              "IS_ACTIVE": 1
            }
          ]:[],
          "MasPersonRelationship": map_relationship,
          "MasPersonPhoto": map_photo,
        };

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(
                ),
              );
            });
        await onLoadActionInsPersonAllMaster(map);
        Navigator.pop(context, _getPersonResponse.RESPONSE_DATA);
      } else {
        Map map_person = {
          "PERSON_ID": widget.ItemsPerson.PERSON_ID,
          "COUNTRY_ID": ItemCountry!=null?ItemCountry.COUNTRY_ID:"",
          "NATIONALITY_ID": 1,
          "RACE_ID": 1,
          "RELIGION_ID": 1,
          "TITLE_ID": ItemTitle.TITLE_ID,
          "PERSON_TYPE": person_type,
          "ENTITY_TYPE": entity_type,
          "TITLE_NAME_TH": ItemTitle.TITLE_NAME_TH,
          "TITLE_NAME_EN": ItemTitle.TITLE_NAME_EN,
          "TITLE_SHORT_NAME_TH": ItemTitle.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": ItemTitle.TITLE_SHORT_NAME_EN,
          "FIRST_NAME": firstname,
          "MIDDLE_NAME": "",
          "LAST_NAME": lastname,
          "OTHER_NAME": "",
          "COMPANY_NAME" : COMPANY_NAME,
          "COMPANY_REGISTRATION_NO": COMPANY_REGISTRATION_NO,
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": EXCISE_REGISTRATION_NO,
          "GENDER_TYPE": 0,
          "ID_CARD": id_card,
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": editPassportNo.text,
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": "",
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
        };

        List<Map> map_address =[];
        widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item){
          map_address.add({
            "PERSON_ADDRESS_ID": item.PERSON_ADDRESS_ID,
            "PERSON_ID": item.PERSON_ID,
            "SUB_DISTRICT_ID": ItemSubDistrict.SUB_DISTRICT_ID,
            "GPS": "",
            "ADDRESS_NO": "",
            "VILLAGE_NO": "",
            "BUILDING_NAME": "",
            "ROOM_NO": "",
            "FLOOR": "22",
            "VILLAGE_NAME": "",
            "ALLEY": "",
            "LANE": "",
            "ROAD": "",
            "ADDRESS_TYPE": 0,
            "ADDRESS_DESC": "",
            "ADDRESS_STATUS": 0,
            "IS_ACTIVE": 1
          });
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(
                ),
              );
            });
        await onLoadActionUpdPersonAllMaster(map_person);
        Navigator.pop(context, _getPersonResponse.RESPONSE_DATA);
      }
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

  void _onSelectCountry(int COUNTRY_ID)async{
    await onLoadActionProvinceMaster(COUNTRY_ID,null,false);
  }
  void _onSelectProvince(int PROVINCE_ID)async{
    await onLoadActionDistinctMaster(PROVINCE_ID,null,false);
  }
  void _onSelectDistrict(int DISTRICT_ID)async{
    print("DISTRICT_ID : "+DISTRICT_ID.toString());
    await onLoadActionSubDistinctMaster(DISTRICT_ID,null,false);
  }

  Future<bool> onLoadActionCountryMaster(int COUNTRY_ID) async {
    Map map = {
      "TEXT_SEARCH" : "",
      "COUNTRY_ID" : COUNTRY_ID
    };
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map).then((onValue) {
      setAutoCompleteCountry();
      widget.ItemCountry.RESPONSE_DATA.forEach((item){
        if(item.COUNTRY_ID==onValue.RESPONSE_DATA[0].COUNTRY_ID){
          sCountry = item;
          editCountry.text = sCountry.COUNTRY_NAME_TH.toString();
        }
      });
    });
    setState(() {});
    return true;
  }
  Future<bool> onLoadActionProvinceMaster(int COUNTRY_ID,ItemsListSubDistict sub_district,bool IsUpdate) async {
    Map map = {
      "TEXT_SEARCH" : "",
      "PROVINCE_ID" : "",
      "COUNTRY_ID" : COUNTRY_ID
    };
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      ItemProvince = onValue;
      if (ItemProvince.SUCCESS&&ItemProvince.RESPONSE_DATA.length>0) {
        if(_suspectType2){
          setAutoCompleteProvince2();
        }else{
          setAutoCompleteProvince();
        }
      }
      if(IsUpdate){
        ItemProvince.RESPONSE_DATA.forEach((item){
          if(item.PROVINCE_ID==sub_district.PROVINCE_ID){
            if(_suspectType2){
              sProvince2 = item;
              editProvince2.text = sProvince2.PROVINCE_NAME_TH.toString();
            }else{
              sProvince = item;
              editProvince.text = sProvince.PROVINCE_NAME_TH.toString();
            }
            onLoadActionCountryMaster(
                _suspectType2
                    ?sProvince2.COUNTRY_ID
                    :sProvince.COUNTRY_ID
            );
          }
        });
      }else{
        sDistrict=null;
        this.onLoadActionDistinctMaster(onValue.RESPONSE_DATA[0].PROVINCE_ID,null,IsUpdate);
      }

    });
    setState(() {});
    return true;
  }
  Future<bool> onLoadActionDistinctMaster(int PROVINCE_ID,ItemsListSubDistict sub_district,bool IsUpdate) async {
    Map map = {
      "TEXT_SEARCH" : "",
      "DISTRICT_ID" : "",
      "PROVINCE_ID" : PROVINCE_ID
    };
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      if (ItemDistrict.SUCCESS&&ItemDistrict.RESPONSE_DATA.length>0) {
        if(_suspectType2){
          setAutoCompleteDistrict2();
        }else{
          setAutoCompleteDistrict();
        }
      }
      if(IsUpdate){
        ItemDistrict.RESPONSE_DATA.forEach((item){
          if(item.DISTRICT_ID==sub_district.DISTRICT_ID){
            if(_suspectType2){
              sDistrict2 = item;
              editDistrict2.text = sDistrict2.DISTRICT_NAME_TH.toString();
            }else{
              sDistrict = item;
              editDistrict.text = sDistrict.DISTRICT_NAME_TH.toString();
            }
            onLoadActionProvinceMaster(
                _suspectType2
                    ?sDistrict2.PROVINCE_ID
                    :sDistrict.PROVINCE_ID,
                sub_district,IsUpdate);
          }
        });
      }else{
        sSubDistrict = null;
        this.onLoadActionSubDistinctMaster(onValue.RESPONSE_DATA[0].DISTRICT_ID,null,false);
      }
    });
    setState(() {
    });
    return true;
  }
  Future<bool> onLoadActionSubDistinctMaster(int DISTRICT_ID,int SUB_DISTRICT_ID,bool IsUpdate) async {
    Map map = {
      "TEXT_SEARCH" : "",
      "SUB_DISTRICT_ID" : SUB_DISTRICT_ID,
      "DISTRICT_ID" : DISTRICT_ID
    };
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      if(IsUpdate){
        onValue.RESPONSE_DATA.forEach((item){
          if(_suspectType2){
            sSubDistrict2 = item;
            editSubDistrict2.text = sSubDistrict2.SUB_DISTRICT_NAME_TH.toString();
          }else{
            sSubDistrict = item;
            editSubDistrict.text = sSubDistrict.SUB_DISTRICT_NAME_TH.toString();
          }
        });
      }else{
        ItemSubDistrict = onValue;
        if (ItemSubDistrict.SUCCESS&&ItemSubDistrict.RESPONSE_DATA.length>0) {
          if(_suspectType2){
            setAutoCompleteSubDistrict2();
          }else{
            setAutoCompleteSubDistrict();
          }
        }
      }
    });
    if(IsUpdate){
      Map map_con = {
        "TEXT_SEARCH" : "",
        "SUB_DISTRICT_ID" : "",
        "DISTRICT_ID" : _suspectType2?sSubDistrict2.DISTRICT_ID:sSubDistrict.DISTRICT_ID
      };
      await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map_con).then((onValue) {
        ItemSubDistrict = onValue;
        ItemSubDistrict.RESPONSE_DATA.forEach((item){
          if(item.SUB_DISTRICT_ID==(_suspectType2?sSubDistrict2.DISTRICT_ID:sSubDistrict.DISTRICT_ID)){
            if(_suspectType2){
              sSubDistrict2 = item;
            }else{
              sSubDistrict = item;
            }
          }
        });
        if(ItemSubDistrict.SUCCESS&&ItemSubDistrict.RESPONSE_DATA.length>0){
          if(_suspectType2){
            setAutoCompleteSubDistrict2();
          }else{
            setAutoCompleteSubDistrict();
          }
        }
        onLoadActionDistinctMaster(
            _suspectType2
                ?sSubDistrict2.PROVINCE_ID
                :sSubDistrict.PROVINCE_ID,
            _suspectType2
                ?sSubDistrict2
                :sSubDistrict,
            IsUpdate);
      });
    }

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionInsPersonAllMaster(Map map_person) async {
    int PERSON_ID;
    await new ArrestFutureMaster().apiRequestMasPersoninsAll(map_person).then((onValue) {
      PERSON_ID = onValue.RESPONSE_DATA;
    });
    //test
    String fa_firstname="",fa_lastname="";
    String mo_firstname="",mo_lastname="";
    var ItemFatherTitle;
    var ItemMotherTitle;
    var ItemSubDistrict;
    if(_suspectType1){
      ItemFatherTitle = sTitleFather;
      ItemMotherTitle = sTitleMother;
      ItemSubDistrict = sSubDistrict;

      /*List splitsFaName = editFather.text.split(" ");
      if(splitsFaName.length>1){
        fa_firstname=splitsFaName[0];
        fa_lastname=splitsFaName[1];
      }else{
        fa_firstname=splitsFaName[0];
        fa_lastname="";
      }
      List splitsMoName = editMother.text.split(" ");
      if(splitsMoName.length>1){
        mo_firstname=splitsMoName[0];
        mo_lastname=splitsMoName[1];
      }else{
        mo_firstname=splitsMoName[0];
        mo_lastname="";
      }*/
      fa_firstname = editFirstNameFather.text;
      fa_lastname = editLastNameFather.text;

      mo_firstname = editFirstNameMother.text;
      mo_lastname = editLastNameMother.text;

    }else{
      ItemFatherTitle = sTitleFatherHeadCompany;
      ItemMotherTitle = sTitleMotherHeadCompany;
      ItemSubDistrict = sSubDistrict2;

      /*List splitsFaName = editNameFather_2.text.split(" ");
      if(splitsFaName.length>1){
        fa_firstname=splitsFaName[0];
        fa_lastname=splitsFaName[1];
      }else{
        fa_firstname=splitsFaName[0];
        fa_lastname="";
      }
      List splitsMoName = editNameMother_2.text.split(" ");
      if(splitsMoName.length>1){
        mo_firstname=splitsMoName[0];
        mo_lastname=splitsMoName[1];
      }else{
        mo_firstname=splitsMoName[0];
        mo_lastname="";
      }*/
      fa_firstname = editFirstNameFather_2.text;
      fa_lastname = editLastNameFather_2.text;

      mo_firstname = editFirstNameMother_2.text;
      mo_lastname = editLastNameMother_2.text;

    }

    int PERSON_RELATIONSHIP_ID;
    Map map_relation;
    if(ItemFatherTitle!=null){
      map_relation={
        "PERSON_RELATIONSHIP_ID": "",
        "RELATIONSHIP_ID": 1,
        "PERSON_ID": PERSON_ID,
        "TITLE_ID": ItemFatherTitle.TITLE_ID,
        "TITLE_NAME_TH": ItemFatherTitle.TITLE_NAME_TH,
        "TITLE_NAME_EN": ItemFatherTitle.TITLE_NAME_EN,
        "TITLE_SHORT_NAME_TH": ItemFatherTitle.TITLE_SHORT_NAME_TH,
        "TITLE_SHORT_NAME_EN": ItemFatherTitle.TITLE_SHORT_NAME_EN,
        "FIRST_NAME": fa_firstname,
        "MIDDLE_NAME": "",
        "LAST_NAME": fa_lastname,
        "OTHER_NAME": "",
        "GENDER_TYPE": 1,
        "ID_CARD": "",
        "BIRTH_DATE": "",
        "BLOOD_TYPE": "",
        "CAREER": "",
        "PERSON_DESC": "",
        "EMAIL": "",
        "TEL_NO": "",
        "IS_ACTIVE": 1
      };
      await new ArrestFutureMaster().apiRequestMasPersonRelationshipinsAll(map_relation).then((onValue) {
        PERSON_RELATIONSHIP_ID = onValue.RESPONSE_DATA;
        print("Relationship : "+onValue.SUCCESS.toString());
      });
    }

    if(ItemSubDistrict!=null){
      Map map_address={
        "PERSON_ADDRESS_ID": "",
        "PERSON_ID": PERSON_ID,
        "SUB_DISTRICT_ID": ItemSubDistrict.SUB_DISTRICT_ID,
        "GPS": "",
        "ADDRESS_NO": "",
        "VILLAGE_NO": "",
        "BUILDING_NAME": "",
        "ROOM_NO": "",
        "FLOOR": "22",
        "VILLAGE_NAME": "",
        "ALLEY": "",
        "LANE": "",
        "ROAD": "",
        "ADDRESS_TYPE": 0,
        "ADDRESS_DESC": "",
        "ADDRESS_STATUS": 0,
        "IS_ACTIVE": 1
      };
      await new ArrestFutureMaster().apiRequestMasPersonAddressinsAll(map_address).then((onValue) {
        //PERSON_ID = onValue.RESPONSE_DATA;
        print("Address : "+onValue.SUCCESS.toString());
      });
    }

    /*Map map_photo;
    _arrItemsImageFile.forEach((file){
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      map_photo={
        "PHOTO_ID": "",
        "PERSON_ID": PERSON_ID,
        "PERSON_RELATIONSHIP_ID": PERSON_RELATIONSHIP_ID,
        "PHOTO": base64Image,
        "TYPE": 0,
        "IS_ACTIVE": 1
      };
    });

     await new ArrestFutureMaster().apiRequestMasPersonPhotoinsAll(map_photo).then((onValue) {
      //PERSON_ID = onValue.RESPONSE_DATA;
      print("Photo : "+onValue.SUCCESS.toString());
    });*/

    if(PERSON_ID!=null){
      Map map_person={
        "TEXT_SEARCH" : "",
        "PERSON_ID" : PERSON_ID
      };
      print(map_person.toString());
      await new ArrestFutureMaster().apiRequestMasPersongetByCon(map_person).then((onValue) {
        onValue.RESPONSE_DATA.forEach((f){
          f.IsCreate=true;
        });
        _getPersonResponse = onValue;
        Navigator.pop(context);
      });
    }

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionUpdPersonAllMaster(Map map_person) async {
    await new ArrestFutureMaster().apiRequestMasPersongetByCon(map_person).then((onValue) {
      _getPersonResponse = onValue;
      Navigator.pop(context);
    });
    setState(() {});
    return true;
  }

}