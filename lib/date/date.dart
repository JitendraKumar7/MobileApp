import 'package:intl/intl.dart';


String get date {
  var formatter =  DateFormat('dd-MM-yyyy');
  return formatter.format(DateTime.now());
}