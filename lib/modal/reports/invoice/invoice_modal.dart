import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:tally/services/services.dart';

import '../../modal.dart';

class Products {
  dynamic rate;
  dynamic amount;
  dynamic hsnCode;
  dynamic actualQty;
  dynamic billedDay;
  dynamic stockItemName;

  bool get isEmpty {
    return stockItemName == null &&
        billedDay == null &&
        actualQty == null &&
        amount == null &&
        hsnCode == null &&
        rate == null;
  }

  Products.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    stockItemName = json['STOCKITEMNAME'];
    actualQty = json['ACTUALQTY'];
    billedDay = json['BILLEDDAY'];
    hsnCode = json['HSNCODE'];
    amount = json['AMOUNT'];
    rate = json['RATE'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['STOCKITEMNAME'] = stockItemName;
    data['ACTUALQTY'] = actualQty;
    data['BILLEDDAY'] = billedDay;
    data['HSNCODE'] = hsnCode;
    data['AMOUNT'] = amount;
    data['RATE'] = rate;
    return data;
  }

  List<String> get data => [
        stockItemName ?? '',
        hsnCode ?? '',
        rate ?? '',
        actualQty ?? '',
        amount?.replaceFirst('-', '') ?? '',
      ];

  @override
  String toString() => jsonEncode(toJson());
}

class InvoiceModal {
  dynamic name;
  dynamic vchKey;
  dynamic vchType;
  dynamic narration;
  dynamic reference;
  dynamic totalAmount;
  dynamic voucherDate;
  dynamic voucherNumber;
  dynamic partyLedgerName;

  String get id => 'No. : $reference';

  String get partyName => partyLedgerName ?? '';

  String get date => getDateFormat(voucherDate ?? '');

  List<Products> products = [];

  List<LedgerDetails> ledgerDetails = [];

  List<List<String>> slip(bool payment) {
    var ledger = _remove().first;
    return [
      ['', '', ''],
      ['', '', ''],
      ledger.slip(payment),
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
      ledger.amountInWords,
      ['', '', ''],
      ['', '', ''],
    ];
  }

  bool get productsEmpty {
    return products.isEmpty || (products.length == 1 && products.first.isEmpty);
  }

  List<List<String>> get data {
    if (productsEmpty) {
      var items = ledgerDetails.where((e) => e.isProduct).toList();
      return items
          .map((e) => [
                '${e.ledgerName ?? ' '}',
                '',
                '',
                '',
                e.positiveAmount,
              ])
          .toList();
    }
    return products.map((e) => e.data).toList();
  }

  List<LedgerDetails> _remove() {
    List<LedgerDetails> _details = [...ledgerDetails];
    _details.removeWhere((e) => e.isRemove(partyName));
    if (productsEmpty) {
      _details.removeWhere((e) => e.isProduct);
    }
    return _details;
  }

  String get beforeTaxAmount {
    if (productsEmpty) {
      var items = ledgerDetails.where((e) => e.isProduct).toList();
      return items.map((e) => e.taxAmount).toList().sum.toStringAsFixed(2);
    }
    return totalAmount?.replaceFirst('-', '') ?? '';
  }

  List<List<String>> get sundry {
    var details = ledgerDetails.firstWhere((e) => e.isRemove(partyName),
        orElse: () => ledgerDetails.first);

    var _ledgerDetails = _remove();

    return [
      ['', 'Before Tax', beforeTaxAmount],
      ..._ledgerDetails.map((e) => e.data).toList(),
      ['', 'Total Amount', details.positiveAmount],
    ];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['LEDDETAILS'] = ledgerDetails.map((v) => v.toJson()).toList();
    data['PRODUCTS'] = products.map((v) => v.toJson()).toList();

    //data['PRODUCTTOTALAMOUNT'] = productTotalAmount;
    data['PARTYLEDGERNAME'] = partyLedgerName;
    data['VOUCHERNUMBER'] = voucherNumber;
    data['TOTALAMOUNT'] = totalAmount;
    data['VOUCHERDATE'] = voucherDate;
    data['NARRATION'] = narration;
    data['REFERENCE'] = reference;
    data['VCHTYPE'] = vchType;
    data['VCHKEY'] = vchKey;
    data['NAME'] = name;
    return data;
  }

  InvoiceModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    (json['LEDDETAILS'] ?? []).forEach((v) {
      ledgerDetails.add(LedgerDetails.fromJson(v));
    });

    (json['PRODUCTS'] ?? []).forEach((v) {
      products.add(Products.fromJson(v));
    });

    //productTotalAmount = json['PRODUCTTOTALAMOUNT'];
    partyLedgerName = json['PARTYLEDGERNAME'];
    voucherNumber = json['VOUCHERNUMBER'];
    voucherDate = json['VOUCHERDATE'];
    totalAmount = json['TOTALAMOUNT'];
    reference = json['REFERENCE'];
    narration = json['NARRATION'];
    vchType = json['VCHTYPE'];
    vchKey = json['VCHKEY'];
    name = json['NAME'];
  }

  @override
  String toString() => jsonEncode(toJson());

  var company = CompanyModal();
  LedgerModal? ledger;

  Future<InvoiceModal> setLedger(
    QueryDocumentSnapshot<CompanyModal> document,
  ) async {
    try {
      var query = await db.getLedgerQuery(document.reference, partyName);
      ledger = query.data();
    } catch (ex) {
      debugPrint('$ex');
    }
    company = document.data();
    return this;
  }
}

class LedgerDetails {
  dynamic amount;
  dynamic ledgerName;
  dynamic vatExpAmount;

  bool get isProduct {
    var name = ledgerName?.toLowerCase() ?? '';
    return name.contains('sales') || name.contains('purchase');
  }

  LedgerDetails.fromJson(Map<String, dynamic> json) {
    vatExpAmount = json['VATEXPAMOUNT'];
    ledgerName = json['LEDGERNAME'];
    amount = json['AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['VATEXPAMOUNT'] = vatExpAmount;
    data['LEDGERNAME'] = ledgerName;
    data['AMOUNT'] = amount;
    return data;
  }

  List<String> get data => [
        '',
        ledgerName ?? '',
        positiveAmount,
      ];

  double get taxAmount => double.tryParse(positiveAmount) ?? 0;

  String get positiveAmount => amount?.replaceFirst('-', '') ?? '0';

  List<String> slip(bool payment) => [
        '',
        payment ? 'Paid Amount' : 'Received Amount',
        'Rs. $positiveAmount',
      ];

  List<String> get amountInWords {
    var number = double.tryParse(positiveAmount) ?? 0;
    var word = NumberToWord().convert('en-in', number.toInt());
    return [
      '',
      'Amount In Words',
      '$word rupees only',
    ];
  }

  @override
  String toString() => jsonEncode(toJson());

  bool isRemove(String partyName) => ledgerName == partyName;
}
