import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_sentence.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_case_information.dart';

class ItemsLawsuitNotice {
  /*String LawsuitNumber;
  String LawsuitYear;
  String LawsuitDate;
  String LawsuitTime;
  String LawsuitPersonName;
  ItemsLawsuitCaseInformation Informations;
  String LawsuitPlace;
  String LawsuitTestimony;
  String LawsuitCompare;
  bool IsCompare;
  //กรณี
  //bool IsProof;

  ItemsLawsuitMainAcceptCase(
      this.LawsuitNumber,
      this.LawsuitYear,
      this.LawsuitDate,
      this.LawsuitTime,
      this.LawsuitPersonName,
      this.Informations,
      this.LawsuitPlace,
      this.LawsuitTestimony,
      this.LawsuitCompare,
      this.IsCompare,
      //this.IsProof,
      );*/
  int LAWSUIT_ID;
  int INDICTMENT_ID;
  String ARREST_CODE;
  String SUBSECTION_NAME;
  bool IsCompare;

  ItemsLawsuitNotice({
    this.LAWSUIT_ID,
    this.INDICTMENT_ID,
    this.ARREST_CODE,
    this.SUBSECTION_NAME,
    this.IsCompare,
  });

  factory ItemsLawsuitNotice.fromJson(Map<String, dynamic> json) {
    return ItemsLawsuitNotice(
        LAWSUIT_ID: json['LAWSUIT_ID'],
        INDICTMENT_ID: json['INDICTMENT_ID'],
        ARREST_CODE: json['ARREST_CODE'],
        SUBSECTION_NAME: json['SUBSECTION_NAME'],
        IsCompare: false
    );
  }
}