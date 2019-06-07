
import 'package:prototype_app_pang/main_menu/stock/model/balance_detail.dart';

class ItemsStockBalanceType{
  String Name;
  List<ItemsStockBalanceDetail> BalanceDetails;
  int Type;
  ItemsStockBalanceType(
      this.Name,
      this.BalanceDetails,
      this.Type,);
}