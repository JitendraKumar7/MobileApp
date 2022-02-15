import 'dart:convert';

import '../../modal.dart';

class Summery {
  dynamic ref;
  dynamic dueDate;
  dynamic billDate;
  dynamic partyName;
  dynamic overDueDate;
  dynamic pendingAmount;

  String get name => partyName?.toUpperCase() ?? '';

  String get date => getDateParse(billDate ?? '');

  String get amount => balance.abs().toStringAsFixed(2);

  double get balance => double.tryParse('$pendingAmount') ?? 0;

  Summery();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PENDINGAMOUNT'] = pendingAmount;
    data['OVERDUEBYDATE'] = overDueDate;
    data['PARTYNAME'] = partyName;
    data['BILLDATE'] = billDate;
    data['DUEDATE'] = dueDate;
    data['REF'] = ref;
    return data;
  }

  Summery.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    pendingAmount = json['PENDINGAMOUNT'];
    overDueDate = json['OVERDUEBYDATE'];
    partyName = json['PARTYNAME'];
    billDate = json['BILLDATE'];
    dueDate = json['DUEDATE'];
    ref = json['REF'];
  }

  List<String> get data => [
        getDateParse('$billDate'),
        '$ref',
        getDateParse('$dueDate'),
        '$overDueDate',
        amount,
      ];

  @override
  String toString() => jsonEncode(toJson());
}

class Outstanding {
  dynamic partyName;
  dynamic partyGstin;

  List<Summery> transaction = [];

  String get gst => partyGstin ?? '';

  String get name => partyName?.toUpperCase() ?? '';

  String session = '';
  var company = CompanyModal();

  Outstanding();

  String get period {
    return 'PERIOD [$startDate - $endDate]';
  }

  String get endDate {
    /*if (transaction.isNotEmpty) {
      return transaction.last.date;
    }*/
    var date = session.split('-').last.trim();
    return getDateParse('31-Mar-$date');
  }

  String get startDate {
    if (transaction.isNotEmpty) {
      return transaction.first.date;
    }
    var date = session.split('-').first.trim();
    return getDateParse('1-Apr-$date');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TRANSACTION'] = transaction.map((v) => v.toJson()).toList();
    data['NAME'] = partyName;
    return data;
  }

  Outstanding.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    partyName = json['NAME'];
    (json['TRANSACTION'] ?? []).forEach((v) {
      transaction.add(Summery.fromJson(v));
    });
  }

  List<List<String>> get data {
    transaction.sort((a, b) => b.overDueDate.compareTo(a.overDueDate));
    return transaction.map((e) => e.data).toList();
  }

  void setDocument(String id, CompanyModal modal) {
    company = modal;
    session = id;
  }

  @override
  String toString() => jsonEncode(toJson());
}
