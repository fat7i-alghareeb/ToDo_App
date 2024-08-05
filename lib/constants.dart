import 'package:intl/intl.dart';

const String pageControlRoute = "/";
const String homePageRoute = "/homePage";
final now = DateTime.now();
final stringDateNow = DateFormat('yy-MM-dd').format(now);
String dateToString(DateTime time) {
  String stringDate = DateFormat('yy-MM-dd').format(time);
  return stringDate;
}

DateTime stringToDate(String time) {
  DateTime dateTime = DateFormat('yy-MM-dd').parseStrict(time);

  return dateTime;
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }

  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
