import 'dart:async';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_infor_delivered.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_main.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence_controller.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_offense.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/model/test/compare_%20suspect.dart';
import 'package:prototype_app_pang/model/test/compare_case_information.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

class CheckEvidenceSearchScreenFragment extends StatefulWidget {
  ItemsCheckEvidenceMain itemsCheckEvidenceMain;
  String title;
  bool IsCreate;
  bool IsActive;
  CheckEvidenceSearchScreenFragment({
    Key key,
    @required this.itemsCheckEvidenceMain,
    @required this.IsCreate,
    @required this.title,
    @required this.IsActive,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CheckEvidenceSearchScreenFragment>  with TickerProviderStateMixin {
  TextEditingController controller = new TextEditingController();
  List<ItemsCheckEvidenceMain> _searchResult = [];
  List<ItemsCheckEvidenceMain> _itemsInit = [
    new ItemsCheckEvidenceMain(
      "กค 0809.1",
      "2561",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายธนากร สุตโต",
      new ItemsCompareCaseInformation(
          "TN90403056100047",
          "นายมิตรชัย เอกชัย",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
          "203",
          "มีไวในครอบครองซึ่งสินค้าที่มิได้เสียภาษี",
          "ระวางโทษปรับตั้งแต่สองเท่าถึงสิบเท่าของค่าภาษีที่จะต้องเสียหรือที่เสียไม่ครบถ้วน แต่ต้องไม่ต่ำกว่าสี่ร้อยบาท",
          "",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          [
            new ItemsCompareSuspect(
                "นายเสนาะ อุตโม",
                "บุคคลธรรมดา",
                "คนไทย",
                "155600009661",
                "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                [
                  new ItemsLawsuitOffense(
                    "105/2561",
                    "203",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                  new ItemsLawsuitOffense(
                    "1/2562",
                    "209",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                ],
                null,
                1200000,
                null,
                false
            ),
            new ItemsCompareSuspect(
                "นายวสันต์ ศรีอ้วน",
                "บุคคลธรรมดา",
                "คนไทย",
                "155600009662",
                "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                [
                  new ItemsLawsuitOffense(
                    "1/2562",
                    "209",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                  new ItemsLawsuitOffense(
                    "102/2561",
                    "203",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  )
                ],
                null,
                5000,
                null,
                false
            ),
          ],
          [
            new ItemsCompareEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.4",
                "ดีกรี",
                "hoegaarden",
                "",
                "SADLER S PEAKY BLINDER",
                22,
                "ขวด",
                500,
                "ลิตร",
                1100,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            ),
            new ItemsCompareEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "Leo",
                "",
                "SADLER S PEAKY BLINDER",
                23,
                "ขวด",
                750,
                "ลิตร",
                1500,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            )
          ],
          null,
          false,
          false,
          null,
          null,
          false
      ),
      null,
      new ItemsCheckEvidenceInformationChecked(
          "Auto Generate",
          "09 กันยายน 2561",
          "11.30",
          "นายนิรมิตร  เนตรนัย",
          "ส่วนกลาง",
          [
            new ItemsEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "Leo",
                "",
                "SADLER S PEAKY BLINDER",
                23,
                "ขวด",
                750,
                "ลิตร",
                1500,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร'])),
            new ItemsEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "hoegaarden",
                "",
                "SADLER S PEAKY BLINDER",
                23,
                "ขวด",
                750,
                "ลิตร",
                1500,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร']))
          ]
      ),
      1,
      false,
    ),
    new ItemsCheckEvidenceMain(
      "ตช 0809.1",
      "2561",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "สน.พญาไท",
      new ItemsCompareCaseInformation(
          "TN90403056100047",
          "นายมิตรชัย เอกชัย",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
          "203",
          "มีไวในครอบครองซึ่งสินค้าที่มิได้เสียภาษี",
          "ระวางโทษปรับตั้งแต่สองเท่าถึงสิบเท่าของค่าภาษีที่จะต้องเสียหรือที่เสียไม่ครบถ้วน แต่ต้องไม่ต่ำกว่าสี่ร้อยบาท",
          "",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          [
            new ItemsCompareSuspect(
                "นายเสนาะ อุตโม",
                "บุคคลธรรมดา",
                "คนไทย",
                "155600009661",
                "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                [
                  new ItemsLawsuitOffense(
                    "105/2561",
                    "203",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                  new ItemsLawsuitOffense(
                    "1/2562",
                    "209",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                ],
                null,
                1200000,
                null,
                false
            ),
            new ItemsCompareSuspect(
                "นายวสันต์ ศรีอ้วน",
                "บุคคลธรรมดา",
                "คนไทย",
                "155600009662",
                "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                [
                  new ItemsLawsuitOffense(
                    "1/2562",
                    "209",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                  new ItemsLawsuitOffense(
                    "102/2561",
                    "203",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  )
                ],
                null,
                5000,
                null,
                false
            ),
          ],
          [
            new ItemsCompareEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.4",
                "ดีกรี",
                "hoegaarden",
                "",
                "SADLER S PEAKY BLINDER",
                22,
                "ขวด",
                500,
                "ลิตร",
                1100,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            ),
            new ItemsCompareEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "Leo",
                "",
                "SADLER S PEAKY BLINDER",
                23,
                "ขวด",
                750,
                "ลิตร",
                1500,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            )
          ],
          null
          ,
          false,
          false,
          null,
          null,
          false
      ),
      new ItemsCheckEvidenceInformationDevivered(
          "กค. 1/2561",
          "09 กันยายน 2561",
          "13.00",
          "09 กันยายน 2561 เวลา 13.00 น.",
          "นายรณชัย โกมลไสย",
          "รองสารวัตร",
          "สน.หัวหมาก",
          "ฝากพิสูจน์",
          null,
          true),
      new ItemsCheckEvidenceInformationChecked(
          "Auto Generate",
          "09 กันยายน 2561",
          "11.30",
          "นายนิรมิตร  เนตรนัย",
          "ส่วนกลาง",
          [
            new ItemsEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "Leo",
                "",
                "SADLER S PEAKY BLINDER",
                23,
                "ขวด",
                750,
                "ลิตร",
                1500,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร'])),
            new ItemsEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "hoegaarden",
                "",
                "SADLER S PEAKY BLINDER",
                23,
                "ขวด",
                750,
                "ลิตร",
                1500,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCheckEvidenceDetailController(
                    new ExpandableController(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new FocusNode(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    new TextEditingController(),
                    "ขวด",
                    "ลิตร",
                    ['ขวด','ลัง'],
                    ['ลิตร']))
          ]
      ),
      2,
      false,
    ),
    new ItemsCheckEvidenceMain(
      "กค 0809.2",
      "2561",
      "10 ตุลาคม 2561",
      "เวลา 11.00 น.",
      "นายพงพัทธิ์  ฤทธิวงศ์",
      new ItemsCompareCaseInformation(
          "TN90403056100047",
          "นายมิตรชัย เอกชัย",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
          "203",
          "มีไวในครอบครองซึ่งสินค้าที่มิได้เสียภาษี",
          "ระวางโทษปรับตั้งแต่สองเท่าถึงสิบเท่าของค่าภาษีที่จะต้องเสียหรือที่เสียไม่ครบถ้วน แต่ต้องไม่ต่ำกว่าสี่ร้อยบาท",
          "",
          "09 ตุลาคม 2561",
          "เวลา 13.00 น.",
          [
            new ItemsCompareSuspect(
                "นายเสนาะ อุตโม",
                "บุคคลธรรมดา",
                "คนไทย",
                "155600009661",
                "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                [
                  new ItemsLawsuitOffense(
                    "105/2561",
                    "203",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                  new ItemsLawsuitOffense(
                    "1/2562",
                    "209",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                ],
                null,
                500,
                null,
                false
            ),
            new ItemsCompareSuspect(
                "นายวสันต์ ศรีอ้วน",
                "บุคคลธรรมดา",
                "คนไทย",
                "155600009662",
                "เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                [
                  new ItemsLawsuitOffense(
                    "1/2562",
                    "209",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  ),
                  new ItemsLawsuitOffense(
                    "102/2561",
                    "203",
                    "มีไว้ครอบครองโดยมิได้เสียภาษี",
                    "09 กันยายน 2561",
                    "สุรา",
                    "ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น",
                    "1/2561",
                    "10000",
                    "กรมสรรพสามิต",
                  )
                ],
                null,
                1000,
                null,
                false
            ),
          ],
          [
            new ItemsCompareEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.4",
                "ดีกรี",
                "hoegaarden",
                "",
                "SADLER S PEAKY BLINDER",
                22,
                "ขวด",
                500,
                "ลิตร",
                1100,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            ),
            new ItemsCompareEvidence(
                "เบียร์",
                "สราแช่",
                "ชนิดเบียร์",
                "4.5",
                "ดีกรี",
                "Leo",
                "",
                "SADLER S PEAKY BLINDER",
                23,
                "ขวด",
                750,
                "ลิตร",
                1500,
                "มิลลิกรัม",
                false,
                null,
                false,
                new ItemsCompareEvidenceTaxValue(
                  40000,
                  0,
                  0,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                )
            )
          ],
          null
          ,
          false,
          false,
          null,
          null,
          false
      ),
      null,
      null,
      3,
      false,
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  onSearchTextChanged(String text) async {
    print(text);
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    /*for(int i=0;i<_items.length;i++){
      if (_items[i].contains(text) ||
          _searchDetails[i].contains(text)) {
        _searchResult.add(_searchDetails[i]);
        _searchResult1.add(_searchDetails1[i]);
      }
    }*/
    _itemsInit.forEach((userDetail) {
      if (userDetail.Number.contains(text))
        _searchResult.add(userDetail);
    });
    setState(() {});
  }

  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit = Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(
        fontSize: 16.0, color: labelColorPreview,fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit,fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle textStyleDataSub = TextStyle(
        fontSize: 16, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String person, textButton;
        if (_searchResult[index].CheckEvidenceType == 1) {
          person = "ชื่อผู้ต้องหา";
          textButton = "ตรวจรับหน่วยงานภายใน";
        } else if (_searchResult[index].CheckEvidenceType == 2) {
          person = "หน่วยงาน";
          textButton = "ตรวจรับหน่วยงานภายนอก";
        } else {
          person = "ชื่อผู้นำออก";
          textButton = "ตรวจรับจากการนำออก";
        }

        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(_searchResult[index].CheckEvidenceType == 3
                        ? "เลขที่หนังสือ"
                        : "เลขที่หนังสือนำส่ง", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].Number,
                      style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(person, style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].PersonName,
                      style: textInputStyle,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: new Card(
                            color: labelColor,
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: labelColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigate(
                                          context,textButton, _searchResult[index], false,
                                          true, false);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        "เรียกดู", style: textPreviewStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: new Card(
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: labelColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigate(
                                          context,"test", _searchResult[index], true,
                                          false, false);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        "แก้ไข", style: textEditStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
            ),
          ),
        );
      },
    );
  }

  _navigate(BuildContext context,title, ItemsCheckEvidenceMain itemMain, IsEdit,
      IsPreview, IsCreate) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          CheckEvidenceMainScreenFragment(
            title: title,
            itemsCheckEvidenceMain: itemMain,
            IsUpdate: IsEdit,
            IsPreview: IsPreview,
            IsCreate: IsCreate,
          )),
    );
    if (result.toString() != "Back") {
      _searchResult = result;
      print("resut : " + result.toString());
    }
  }

  List<Constants> constants = const <Constants>[
    const Constants(text: 'หน่วยงานภายใน', icon: Icons.mode_edit),
    const Constants(text: 'หน่วยงานภายนอก', icon: Icons.delete_outline),
    const Constants(text: 'นำไปใช้ในกิจกรรม', icon: Icons.delete_outline),
  ];
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    setState(() {
      if (constants.text.endsWith("หน่วยงานภายใน")) {
        List<ItemsCheckEvidenceMain> items=[];
        _searchResult.forEach((item){
          if(item.CheckEvidenceType==1){
            items.add(item);
          }
        });
        setState(() {
          _searchResult=items;
        });
      } else if(constants.text.endsWith("หน่วยงานภายนอก")){
        List<ItemsCheckEvidenceMain> items=[];
        _searchResult.forEach((item){
          if(item.CheckEvidenceType==2){
            items.add(item);
          }
        });
        setState(() {
          _searchResult=items;
        });
      }else{
        List<ItemsCheckEvidenceMain> items=[];
        _searchResult.forEach((item){
          if(item.CheckEvidenceType==3){
            items.add(item);
          }
        });
        setState(() {
          _searchResult=items;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
    var size = MediaQuery
        .of(context)
        .size;

    return new Theme(
      data: new ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.grey[400]
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new TextField(
                style: styleTextSearch,
                controller: controller,
                decoration: new InputDecoration(
                  hintText: "ค้นหา",
                  hintStyle: styleTextSearch,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
                onChanged: onSearchTextChanged,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,), onPressed: () {
              Navigator.pop(context, "Back");
            }),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                            child: new Text('ILG60_B_05_00_02_00',
                              style: TextStyle(color: Colors.grey[400],
                                  fontFamily: FontStyles().FontFamily,
                                  fontSize: 12.0),),
                          ),
                        ]
                    ),
                    _searchResult.length>0?Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            child: PopupMenuButton<Constants>(
                              onSelected: choiceAction,
                              icon: Icon(FontAwesomeIcons.alignRight,),
                              itemBuilder: (BuildContext context) {
                                return constants.map((Constants contants) {
                                  return PopupMenuItem<Constants>(
                                    value: contants,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(left: 4.0),
                                          child: Text(contants.text,style: TextStyle(fontFamily: FontStyles().FontFamily),),)
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            )
                        )
                      ],
                    ):Container(),
                  ],
                )
              ),
              Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults() : new Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

