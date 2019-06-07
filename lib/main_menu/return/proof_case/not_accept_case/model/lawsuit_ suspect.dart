import 'package:prototype_app_pang/main_menu/return/proof_case/accept_case/model/return_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';
import 'package:prototype_app_pang/main_menu/return/proof_case/not_accept_case/model/lawsuit_offense.dart';

class ItemsLawsuitSuspect {
  String SuspectName;
  String SuspectArrestType;
  String SuspectPersonType;
  String IdentifyNumber;
  String Address;
  List<ItemsReturnOffense> Offenses;
  ItemsLawsuitSentence Sentences;

  ItemsLawsuitSuspect(this.SuspectName,
      this.SuspectArrestType,
      this.SuspectPersonType,
      this.IdentifyNumber,
      this.Address,
      this.Offenses,
      this.Sentences);
}