import 'dart:convert';
import 'package:uuid/uuid.dart';

import '../../modal.dart';

class BaseModal {
  var company = CompanyModal();
  var ledger = LedgerModal();

  int update = 0;
  int timestamp = 0;
  String remark = '';
  String document = '';

  List<ProductModal> items = [];

  String get id => 'No. $timestamp';

  String get name => ledger.getName;

  String get date => getDateTimeFormat(timestamp);

  BaseModal() {
    timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();
    document = const Uuid().v1();
    update = timestamp;
  }

  void remove(ProductModal item) {
    items.remove(item);
  }

  Map<String, dynamic> jsonData() {
    final data = <String, dynamic>{};
    data['LEDGER'] = ledger.toJson();

    data['UPDATE'] = update;
    data['REMARK'] = remark;
    data['DOCUMENT'] = document;
    data['TIMESTAMP'] = timestamp;
    data['ITEMS'] = items.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());

  void setItems(List<ItemModal>? result) {
    var _items = result?.map((e) => e.toItem()).toList();
    items.addAll(_items ?? []);
  }

  Map<String, dynamic> toJson() => jsonData();

  void jsonParse(Map<String, dynamic> json) {
    ledger = LedgerModal.fromJson(json['LEDGER']);

    remark = json['REMARK'];
    document = json['DOCUMENT'];
    timestamp = json['TIMESTAMP'];
    items = json['ITEMS']
        .map<ProductModal>((e) => ProductModal.fromJson(e))
        .toList();
  }
}

class ProductModal {
  String hsn = '';
  String gst = '';
  String mrp = '';
  String name = '';

  // for order
  String quantity = '1';

  // for quotation
  String description = '';

  ProductModal({
    required this.hsn,
    required this.gst,
    required this.mrp,
    required this.name,
  });

  double get g => double.tryParse(gst) ?? 0;

  double get q => double.tryParse(quantity) ?? 1;

  double get p => double.tryParse(mrp.split('/').first) ?? 0;

  double get beforeTax => (q * p);

  double get taxAmount => (beforeTax * g / 100);

  double get totalAmount => beforeTax + taxAmount;

  List<String> get order {
    return [name, mrp, quantity];
  }

  List<String> get proforma {
    return [name, hsn, mrp, gst, quantity, totalAmount.toStringAsFixed(2)];
  }

  List<String> get quotation {
    return [name, hsn, mrp, gst, description];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['DESCRIPTION'] = description;
    data['QUANTITY'] = quantity;
    data['NAME'] = name;
    data['GSTIN'] = gst;
    data['MRP'] = mrp;
    data['HSN'] = hsn;
    return data;
  }

  ProductModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    description = json['DESCRIPTION'];
    quantity = json['QUANTITY'];
    name = json['NAME'];
    gst = json['GSTIN'];
    mrp = json['MRP'];
    hsn = json['HSN'];
  }

  @override
  String toString() => jsonEncode(toJson());
}
