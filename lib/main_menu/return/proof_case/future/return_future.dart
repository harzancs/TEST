import 'dart:convert';

import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_message.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/item_prove_id.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/response/item_lawsuit_response_insall.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/response/item_lawsuit_response_payment.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_lawbreaker.dart';
/*import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/response/item_arrest_response_get_person.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/response/item_arrest_response_get_staff.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/response/item_arrest_response_message.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/response/item_arrest_response_save.dart';
import 'package:prototype_app_pang/main_menu/menu/arrest/model/response/item_arrest_response_ins_staff.dart';
*/import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_list.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_main.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class ReturnFuture{
  ReturnFuture() : super();

  Future<List<ItemsReturnList>> apiRequestReturnListgetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltListgetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsReturnList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<List<ItemsReturnList>> apiRequestLawsuiltListgetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltListgetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsReturnList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsReturnArrestMain> apiRequestLawsuiltArrestIndictmentgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltArrestIndictmentgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsReturnArrestMain.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseLawsuitinsAll> apiRequestLawsuitinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuitinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseLawsuitinsAll.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsReturnMain> apiRequestLawsuitgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuitgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsReturnMain.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuitupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuitupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuitupdAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuitupdAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuitStaffupdAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuitStaffupdAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsListProveID> apiRequestLawsuiltProvegetByLawsuitID(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltProvegetByLawsuitID",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsListProveID.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestLawsuiltArrestIndictmentupdIndictmentComplete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltArrestIndictmentupdIndictmentComplete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuiltArrestIndictmentupdArrestComplete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltArrestIndictmentupdArrestComplete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuiltArrestIndictmentupdDeleteIndictmentComplete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltArrestIndictmentupdDeleteIndictmentComplete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuiltArrestIndictmentupdDeleteArrestComplete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltArrestIndictmentupdDeleteArrestComplete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuiltArrestIndictmentCheckNotComplete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuiltArrestIndictmentCheckNotComplete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponsePaymentMessage> apiRequestLawsuitPaymentinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuitPaymentinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponsePaymentMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestLawsuitPaymentupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterLawsuit + "/LawsuitPaymentupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}