import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_staff.dart';
//import 'package:prototype_app_pang/main_menu/menu/arrest/model/item_arrest_person.dart';

class ItemsArrestResponseLawsuitinsAll {
  final String IsSuccess;
  final String Msg;
  final int LAWSUIT_ID;
  final List<ItemsArrestResponseLawsuitLawsuitStaff> LawsuitStaff;
  final List<ItemsArrestResponseLawsuitLawsuitDetail> LawsuitDetail;

  ItemsArrestResponseLawsuitinsAll({
    this.IsSuccess,
    this.Msg,
    this.LAWSUIT_ID,
    this.LawsuitStaff,
    this.LawsuitDetail,
  });

  factory ItemsArrestResponseLawsuitinsAll.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawsuitinsAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      LawsuitStaff: List.from(json['LawsuitStaff'].map((m) => ItemsArrestResponseLawsuitLawsuitStaff.fromJson(m))),
      LawsuitDetail: List.from(json['LawsuitDetail'].map((m) => ItemsArrestResponseLawsuitLawsuitDetail.fromJson(m))),
    );
  }
}

class ItemsArrestResponseLawsuitLawsuitStaff {
  final int STAFF_ID;

  ItemsArrestResponseLawsuitLawsuitStaff({
    this.STAFF_ID,
  });

  factory ItemsArrestResponseLawsuitLawsuitStaff.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawsuitLawsuitStaff(
      STAFF_ID: json['STAFF_ID'],
    );
  }
}

class ItemsArrestResponseLawsuitLawsuitDetail {
  final int LAWSUIT_DETAIL_ID;

  ItemsArrestResponseLawsuitLawsuitDetail({
    this.LAWSUIT_DETAIL_ID,
  });

  factory ItemsArrestResponseLawsuitLawsuitDetail.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawsuitLawsuitDetail(
      LAWSUIT_DETAIL_ID: json['LAWSUIT_DETAIL_ID'],
    );
  }
}