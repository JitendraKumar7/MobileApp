import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../modal.dart';

var header = [
  'DATE',
  'PARTICULARS',
  'VOUCHER TYPE',
  'VOUCHER NO',
  'DEBIT',
  'CREDIT',
];

class Transaction extends InvoiceModal {
  Transaction.fromJson(Map<String, dynamic>? json) : super.fromJson(json);

  @override
  String get date => getDateFormat(voucherDate ?? '', '');

  String get amount => balance.abs().toStringAsFixed(2);

  double get balance => double.tryParse('$totalAmount') ?? 0;

  List<String> get value => [
        date,
        balance > 0 ? 'To ' : 'By ',
        vchType ?? '',
        reference ?? '',
        balance > 0 ? '' : amount,
        balance > 0 ? amount : '',
      ];
}

class StatementModal {
  dynamic _name;
  dynamic parent;
  dynamic address;
  dynamic partyGstin;
  dynamic countryName;
  dynamic mailingName;
  dynamic ledStateName;
  dynamic priorStateName;
  dynamic closingBalance;
  dynamic openingBalance;
  dynamic isBankingEnables;
  dynamic gstRegistrationType;

  List<Transaction> transaction = [];

  String get gst => partyGstin ?? '';

  String get name => _name?.toUpperCase() ?? '';

  String id = '';
  String session = '';
  var company = CompanyModal();
  DocumentReference? reference;

  StatementModal();

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['TRANSACTION'] = transaction.map((v) => v.toJson()).toList();
    data['GSTREGISTRATIONTYPE'] = gstRegistrationType;
    data['ISEBANKINGENABLED'] = isBankingEnables;
    data['PRIORSTATENAME'] = priorStateName;
    data['LEDSTATENAME'] = ledStateName;
    data['MAILINGNAME'] = mailingName;
    data['COUNTRYNAME'] = countryName;
    data['PARTYGSTIN'] = partyGstin;
    data['ADDRESS'] = address;
    data['PARENT'] = parent;
    data['NAME'] = _name;
    return data;
  }

  StatementModal.fromJson({
    Map<String, dynamic>? json,
    required this.reference,
    required this.id,
  }) {
    if (json == null) return;

    _name = json['NAME'];
    parent = json['PARENT'];
    address = json['ADDRESS'];
    partyGstin = json['PARTYGSTIN'];
    countryName = json['COUNTRYNAME'];
    mailingName = json['MAILINGNAME'];
    ledStateName = json['LEDSTATENAME'];
    priorStateName = json['PRIORSTATENAME'];
    openingBalance = json['OPENINGBALANCE'];
    closingBalance = json['CLOSINGBALANCE'];
    isBankingEnables = json['ISEBANKINGENABLED'];
    gstRegistrationType = json['GSTREGISTRATIONTYPE'];

    (json['TRANSACTION'] ?? []).forEach((v) {
      transaction.add(Transaction.fromJson(v));
    });
  }

  @override
  String toString() => jsonEncode(toJson());

  int get length => transaction.length + 2;

  String date(int i) {
    if (i == 0) {
      return startDate;
    }

    if (i > length - 2) {
      return '';
    }

    return transaction[i - 1].date;
  }

  String get period {
    return 'PERIOD [$startDate - $endDate]';
  }

  String get endDate {
    if (transaction.isNotEmpty) {
      return transaction.last.date;
    }
    var date = session.split('-').last.trim();
    return getDateParse('31-Mar-$date');
  }

  String get startDate {
    var date = session.split('-').first.trim();
    return getDateParse('1-Apr-$date');
  }

  Widget data(int i, int j) {
    if (i == 0) {
      var opBalWidget = Text(
        opBal.abs().toStringAsFixed(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
      if (opBal < 0 && j == 3) {
        return opBalWidget;
      } else if (opBal > 0 && j > 3) {
        return opBalWidget;
      }

      if (j == 0) {
        return const Text(
          'Opening Bal.',
          style: TextStyle(fontWeight: FontWeight.bold),
        );
      }

      return const Text('');
    }

    if (i > length - 2) {
      var clBalWidget = Text(
        clBal.abs().toStringAsFixed(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
      if (clBal < 0 && j == 3) {
        return clBalWidget;
      } else if (clBal > 0 && j > 3) {
        return clBalWidget;
      }

      if (j == 0) {
        return const Text(
          'Closing Bal.',
          style: TextStyle(fontWeight: FontWeight.bold),
        );
      }

      return const Text('');
    }

    return Text(transaction[i - 1].value[j + 1]);
  }

  List<String> get header => [
        'DATE',
        'PARTICULARS',
        'VCH TYPE',
        'VCH NO',
        'DEBIT',
        'CREDIT',
      ];

  List<List<String>> get value {
    var opBal1 = opBal.abs().toStringAsFixed(2);
    var clBal1 = clBal.abs().toStringAsFixed(2);
    return [
      [
        startDate,
        'Opening Bal.',
        '',
        '',
        opBal > 0 ? '' : opBal1,
        opBal > 0 ? opBal1 : '',
      ],
      ...transaction.map((e) => e.value).toList(),
      [
        '',
        'Closing Bal.',
        '',
        '',
        clBal > 0 ? '' : clBal1,
        clBal > 0 ? clBal1 : '',
      ],
    ];
  }

  double get opBal => double.tryParse('$openingBalance') ?? 0;

  double get clBal => double.tryParse('$closingBalance') ?? 0;

  void setDocument(String id, CompanyModal modal) {
    company = modal;
    session = id;
  }

  void setTransaction(List<Transaction> list) {
    transaction.clear();
    transaction.addAll(list);
  }
}
