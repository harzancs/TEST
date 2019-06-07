
import 'package:flutter/cupertino.dart';

class ItemsListArrest5Controller {
  TextEditingController editSize;
  TextEditingController editQuantity;
  TextEditingController editVolume;
  TextEditingController editVolumeUnit;
  FocusNode myFocusNodeSize;
  FocusNode myFocusNodeQuantity;
  FocusNode myFocusNodeVolume;
  FocusNode myFocusNodeVolumeUnit;

  List<String> dropdownItemsSizeUnit;
  List<String> dropdownItemsQuantityUnit;
  String dropdownValueSizeUnit;
  String dropdownValueQuantityUnit;
  ItemsListArrest5Controller(
      this.editSize,
      this.editQuantity,
      this.editVolume,
      this.editVolumeUnit,

      this.myFocusNodeSize,
      this.myFocusNodeQuantity,
      this.myFocusNodeVolume,
      this.myFocusNodeVolumeUnit,

      this.dropdownItemsSizeUnit,
      this.dropdownItemsQuantityUnit,
      this.dropdownValueSizeUnit,
      this.dropdownValueQuantityUnit,
      );
}