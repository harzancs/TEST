import 'dart:convert';

import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_staff.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_indicment.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_message.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_save.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_ins_staff.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class ArrestFuture{
  ArrestFuture() : super();
  Future<ItemsListArrestMain> apiRequestGet(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      /*var responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrestMain.fromJson(m))
          .toList();*/
      return ItemsListArrestMain.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponse> apiRequestInsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    //print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemsArrestResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseIndicment> apiRequestInsIndictment(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseIndicment.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseIndicment> apiRequestArrestIndictmentProductinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentProductinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseIndicment.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  //Create Staff
  Future<ItemsArrestResponseStaffMessage> apiRequestMasStaffinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMaster + "/MasStaffinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseStaffMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  //Update Staff
  Future<ItemsArrestResponseStaffMessage> apiRequestMasStaffupdAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMaster + "/MasStaffupdAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseStaffMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  //Get Staff by Con
  Future<ItemsArrestResponseGetStaff> apiRequestMasStaffgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMaster + "/MasStaffgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseGetStaff.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  //Get Staff by ConAdv
  Future<ItemsArrestResponseGetStaff> apiRequestMasStaffgetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMaster + "/MasStaffgetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseGetStaff.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Get Person By ConAdv
  Future<List<ItemsListArrestLawbreaker>> apiRequestMasPersongetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestMasPersongetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrestLawbreaker.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  //Get Person By Con
  Future<ItemsArrestResponseGetPerson> apiRequestMasPersongetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMaster + "/MasPersongetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseGetPerson.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentDetailinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentDetailinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  //****************************UpDelete*****************************
  Future<ItemsArrestResponseMessage> apiRequestArrestLawbreakerupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestLawbreakerupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentDetailupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentDetailupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestStaffupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestStaffupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestProductupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestProductupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentProductupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentProductupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //****************************Update*****************************
  Future<ItemsArrestResponseMessage> apiRequestArrestupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestArrestStaffupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestStaffupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentProductupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestIndictmentProductupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestStaffinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestStaffinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestArrestLawbreakerinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestLawbreakerinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestArrestProductinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestProductinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestProductupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestProductupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsListArrest6Section>> apiRequestArrestMasGuiltbasegetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestMasGuiltbasegetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrest6Section.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}