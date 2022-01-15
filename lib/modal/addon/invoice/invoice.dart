import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:tally/modal/modal.dart';

class ProformaModal {
  var company = CompanyModal();
  var ledger = LedgerModal();

  int timestamp = 0;
  bool integratedTax = true;

  late String date;

  List<ProductModal> products = [];

  ProformaModal() {
    timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();

    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    date = DateFormat('dd MMM yyyy').format(dateTime);
  }

  List<List<String>> get data {
    return products.map((e) => e.data).toList();
  }

  List<List<String>> get sundry {
    var taxAmount = products.map((e) => e.taxAmount).sum;
    var beforeTax = products.map((e) => e.beforeTax).sum;
    var totalAmount = products.map((e) => e.totalAmount).sum;

    var taxLocal = (taxAmount / 2).toStringAsFixed(2);
    var taxCentral = taxAmount.toStringAsFixed(2);

    var totalRoundAmount = totalAmount.round();
    var roundOff = totalRoundAmount - totalAmount;

    return [
      ['', 'BEFORE TAX', beforeTax.toStringAsFixed(2)],
      if (!integratedTax) ...[
        ['', 'CGST', taxLocal],
        ['', 'CGST', taxLocal],
      ],
      if (integratedTax) ['', 'IGST', taxCentral],
      [
        '',
        'ROUND OFF (${roundOff > 0 ? '+' : '-'})',
        roundOff.toStringAsFixed(2),
      ],
      ['', 'TOTAL AMOUNT', totalRoundAmount.toStringAsFixed(2)],
    ];
  }

  void addAll(results) => products.addAll(results);

  void remove(ProductModal item) => products.remove(item);

  ProformaModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    integratedTax = json['integratedTax'];
    timestamp = json['timestamp'];
    date = json['date'];

    products = ProductModal.formJsonResults(json['products']);
    company = CompanyModal.fromJson(json['company']);
    ledger = LedgerModal.fromJson(json['ledger']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['integratedTax'] = integratedTax;
    data['timestamp'] = timestamp;
    data['date'] = date;

    data['products'] = products.map((e) => e.toJson()).toList();
    data['company'] = company.toJson();
    data['ledger'] = ledger.toJson();

    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
