import 'package:intl/intl.dart';

class FormatDate{
  static int getDateDay(String day1, String day2) {
    DateFormat inputFormat1 = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input1 = inputFormat1.parse(day1);
    String date1 = DateFormat('yyyy-MM-dd hh:mm').format(input1);
    DateTime discountedFrom = DateTime.parse(date1);
    DateTime dateNow = DateTime.now();
    if(dateNow.difference(discountedFrom) <= Duration(days: 0)){
      return 0;
    }else{
      discountedFrom = dateNow;
    }
    DateFormat inputFormat2 = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input2 = inputFormat2.parse(day2);
    String date2 = DateFormat('yyyy-MM-dd hh:mm').format(input2);
    DateTime discountedTo = DateTime.parse(date2);

    final difference = discountedTo.difference(discountedFrom);
    if (difference <= Duration(days: 0)) {
      return 0;
    } else {
      return difference.inDays;
    }
  }
  static bool boolCheckEndAt(String day1) {
    DateFormat inputFormat1 = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input1 = inputFormat1.parse(day1);
    String date1 = DateFormat('yyyy-MM-dd hh:mm').format(input1);
    DateTime discountedFrom = DateTime.parse(date1);
    DateTime dateNow = DateTime.now();

    final difference = discountedFrom.difference(dateNow);
    if (difference <= Duration(days: 0)) {
      return true;
    } else {
      return false;
    }
  }
  static String getDateMonthDay(String day1, String day2){
    DateFormat inputFormat1 = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input1 = inputFormat1.parse(day1);
    String date1 = DateFormat('yyyy-MM-dd').format(input1);
    DateTime discountedFrom = DateTime.parse(date1);

    DateFormat inputFormat2 = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input2 = inputFormat2.parse(day2);
    String date2 = DateFormat('yyyy-MM-dd').format(input2);
    DateTime discountedTo = DateTime.parse(date2);
    //final difference = discountedTo.difference(discountedFrom);
    if (discountedTo.year - discountedFrom.year <1) {
      return DateFormat('dd/MM').format(input1)+'-'+ DateFormat('dd/MM').format(input2);
    } else {
      return DateFormat('MM/yyyy').format(input1)+'-'+ DateFormat('MM/yyyy').format(input2);
    }
  }
  static String getDateHour(String day){
    DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input = inputFormat.parse(day, true);
    String hhmma = DateFormat('hh:mm a').format(input);
    return hhmma;
  }
  static String getDateDMY(String day){
    DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input = inputFormat.parse(day, true);
    String dmy = DateFormat('dd/MM/yyyy').format(input);
    return dmy;
  }
  static String getDateDMYHHMMA(String day){
    DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input = inputFormat.parse(day, true);
    String dmy = DateFormat('dd/MM/yyyy hh:mm a').format(input);
    return dmy;
  }
  static String getDateUTC(String day1, String day2){
    // DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm');
    // DateTime input1 = inputFormat.parse(day1, true);
    // String dd1 = DateFormat('dd').format(input1);
    // String MM1 = DateFormat('MM').format(input1);
    // String hhmm1 = DateFormat('hh:mm a').format(input1);
    // DateTime input2 = inputFormat.parse(day2, true);
    // String dd2 = DateFormat('dd').format(input2);
    // String MM2 = DateFormat('MM').format(input2);
    // String hhmm2 = DateFormat('hh:mm a').format(input2);
    // String yyyy2 = DateFormat('yyyy').format(input2);

    //return dd1 + ' tháng '+ MM1 +'. ' + hhmm1 + ' UTC+07 - '+ dd2 +' tháng '+ MM2 + ' năm '+ yyyy2 +' lúc ' + hhmm2 + ' UTC+07';
    return day1 + ' - ' + day2;
  }
}