import 'package:intl/intl.dart';

final _dateFormat = DateFormat('dd-MM-yyyy');

String getDateFormat(String date) {
  try {
    var parseDate = DateTime.parse(date);
    return 'Date : ${_dateFormat.format(parseDate)}';
  } catch (e) {
    return 'Date : $date';
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
