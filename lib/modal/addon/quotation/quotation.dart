import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:tally/modal/modal.dart';

class Product {
  String hsn = '';
  String gst = '';
  String unit = '';
  String name = '';
  String price = '';
  String description = '';

  List<String> get data => <String>[
        name,
        hsn,
        unit,
        gst,
        price,
        description,
      ];

  String? unitError;
  String? priceError;
  String? quantityError;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['price'] = price;
    data['name'] = name;
    data['unit'] = unit;
    data['gst'] = gst;
    data['hsn'] = hsn;
    return data;
  }

  Product.formItem(ItemModal modal) {
    name = modal.name ?? '';
    gst = modal.taxDetails
            .firstWhere((e) => e.gstRateDutyHead == 'Integrated Tax')
            .gstRate ??
        '0';
    hsn = modal.stockDetails.hsnCode ?? '';
  }

  Product.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    description = json['description'];
    price = json['price'];
    name = json['name'];
    unit = json['unit'];
    gst = json['gst'];
    hsn = json['hsn'];
  }

  @override
  String toString() => jsonEncode(toJson());

  static List<Product> formResults(result) {
    return result.map<Product>(Product.formItem).toList();
  }

  static List<Product> formJsonResults(json) {
    return json.map<Product>((e) => Product.fromJson(e)).toList();
  }
}

class QuotationModal {
  var company = CompanyModal();
  var ledger = LedgerModal();

  String? remark;
  late String date;

  int timestamp = 0;

  List<Product> items = [];

  QuotationModal() {
    timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();

    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    date = DateFormat('dd MMM yyyy').format(dateTime);
  }

  List<List<String>> get data {
    return items.map((e) => e.data).toList();
  }

  void addAll(result) => items.addAll(result);

  void remove(Product item) => items.remove(item);

  QuotationModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    timestamp = json['timestamp'];
    remark = json['remark'];
    date = json['date'];

    items = Product.formJsonResults(json['products']);

    company = CompanyModal.fromJson(json['company']);
    ledger = LedgerModal.fromJson(json['ledger']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['remark'] = remark;
    data['date'] = date;

    data['products'] = items.map((e) => e.toJson()).toList();
    data['company'] = company.toJson();
    data['ledger'] = ledger.toJson();

    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
