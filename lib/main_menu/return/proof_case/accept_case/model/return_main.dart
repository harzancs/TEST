import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/item_lawsuit_deatail.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/item_lawsuit_staff.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/lawsuit_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/lawsuit_indicment_product.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_sentence.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_case_information.dart';

class ItemsReturnMain {
  int LAWSUIT_ID;
  int INDICTMENT_ID;
  int OFFICE_ID;
  String OFFICE_CODE;
  String OFFICE_NAME;
  int IS_LAWSUIT;
  String REMARK_NOT_LAWSUIT;
  int LAWSUIT_NO;
  String LAWSUIT_NO_YEAR;
  String LAWSUIT_DATE;
  String TESTIMONY;
  String DELIVERY_DOC_NO_1;
  String DELIVERY_DOC_NO_2;
  String DELIVERY_DOC_DATE;
  int IS_OUTSIDE;
  int IS_SEIZE;
  int IS_ACTIVE;
  List<ItemsListLawsuitStaff> LawsuitStaff;
  List<ItemsListReturnDetail> LawsuitDetail;

  ItemsReturnMain({
    this.LAWSUIT_ID,
    this.INDICTMENT_ID,
    this.OFFICE_ID,
    this.OFFICE_CODE,
    this.OFFICE_NAME,
    this.IS_LAWSUIT,
    this.REMARK_NOT_LAWSUIT,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.LAWSUIT_DATE,
    this.TESTIMONY,
    this.DELIVERY_DOC_NO_1,
    this.DELIVERY_DOC_NO_2,
    this.DELIVERY_DOC_DATE,
    this.IS_OUTSIDE,
    this.IS_SEIZE,
    this.IS_ACTIVE,
    this.LawsuitStaff,
    this.LawsuitDetail,
  });

  factory ItemsReturnMain.fromJson(Map<String, dynamic> json) {
    return ItemsReturnMain(
      LAWSUIT_ID: json['LAWSUIT_ID'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      OFFICE_ID: json['OFFICE_ID'],
      OFFICE_CODE: json['OFFICE_CODE'],
      OFFICE_NAME: json['OFFICE_NAME'],
      IS_LAWSUIT: json['IS_LAWSUIT'],
      REMARK_NOT_LAWSUIT: json['REMARK_NOT_LAWSUIT'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      LAWSUIT_DATE: json['LAWSUIT_DATE'],
      TESTIMONY: json['TESTIMONY'],
      DELIVERY_DOC_NO_1: json['DELIVERY_DOC_NO_1'],
      DELIVERY_DOC_NO_2: json['DELIVERY_DOC_NO_2'],
      DELIVERY_DOC_DATE: json['DELIVERY_DOC_DATE'],
      IS_OUTSIDE: json['IS_OUTSIDE'],
      IS_SEIZE: json['IS_SEIZE'],
      IS_ACTIVE: json['IS_ACTIVE'],
      LawsuitStaff: List.from(json['LawsuitStaff'].map((m) => ItemsListLawsuitStaff.fromJson(m))),
      LawsuitDetail: List.from(json['LawsuitDetail'].map((m) => ItemsListReturnDetail.fromJson(m))),
    );
  }
}