import 'package:intl/intl.dart';

class FormatMoney{
  static String coverPrice(int price){
    return NumberFormat.simpleCurrency(locale: 'vi', decimalDigits: 0).format(price).toString();
  }
}