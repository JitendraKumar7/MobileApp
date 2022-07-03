import 'package:intl/intl.dart';

final _dateFormat = DateFormat('dd-MM-yyyy');

String getDateFormat(String date, [String tag = 'Date :']) {
  try {
    var parseDate = DateTime.parse(date);
    return '$tag ${_dateFormat.format(parseDate)}';
  } catch (e) {
    return '$tag $date';
  }
}

String getDateParse(String date) {
  var today = DateTime.now();
  var format = DateFormat('dd-MMM-yy');
  try {
    var parseDate = format.parse(date);
    var isBigger = parseDate.compareTo(today) > 0;
    return _dateFormat.format(isBigger ? today : parseDate);
  } catch (e) {
    return date;
  }
}

String getDateTimeFormat(int timestamp) {
  try {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return 'Date : ${_dateFormat.format(dateTime)}';
  } catch (e) {
    return 'Date : $timestamp';
  }
}
