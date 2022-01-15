import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:tally/modal/modal.dart';

class OrderModal {
  var company = CompanyModal();
  var ledger = LedgerModal();

  String? remark;
  late String date;

  int timestamp = 0;

  List<ProductModal> products = [];

  OrderModal() {
    timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();

    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    date = DateFormat('dd MMM yyyy').format(dateTime);
  }



  List<List<String>> get data {
    return products.map((e) => e.data).toList();
  }

  void addAll(result) => products.addAll(result);

  void remove(ProductModal item) => products.remove(item);

  OrderModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    timestamp = json['timestamp'];
    remark = json['remark'];
    date = json['date'];

    products = ProductModal.formJsonResults(json['products']);

    company = CompanyModal.fromJson(json['company']);
    ledger = LedgerModal.fromJson(json['ledger']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['remark'] = remark;
    data['date'] = date;

    data['products'] = products.map((e) => e.toJson()).toList();
    data['company'] = company.toJson();
    data['ledger'] = ledger.toJson();

    return data;
  }

  @override
  String toString() => jsonEncode(toJson());

}
