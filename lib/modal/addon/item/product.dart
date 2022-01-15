import 'dart:convert';
import 'package:tally/modal/modal.dart';

class ProductModal {
  String hsn = '';
  String gst = '';
  String unit = '';
  String name = '';
  String price = '';
  String quantity = '';

  double get g => double.tryParse(gst) ?? 0;

  double get p => double.tryParse(price) ?? 0;

  double get q => double.tryParse(quantity) ?? 0;

  double get beforeTax => (q * p);

  double get taxAmount => (beforeTax * g / 100);

  double get totalAmount => beforeTax + taxAmount;

  List<String> get data => <String>[
    name,
    hsn,
    unit,
    price,
    quantity,
    gst,
    totalAmount.toStringAsFixed(2),
  ];

  String? unitError;
  String? priceError;
  String? quantityError;

  bool isValid() {
    unitError = null;
    priceError = null;
    quantityError = null;
    if (quantity.isEmpty) {
      quantityError = 'Required';
    }
    if (price.isEmpty) {
      priceError = 'Required';
    }
    if (unit.isEmpty) {
      unitError = 'Required';
    }

    return quantityError == null && priceError == null && unitError == null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['price'] = price;
    data['name'] = name;
    data['unit'] = unit;
    data['gst'] = gst;
    data['hsn'] = hsn;
    return data;
  }

  ProductModal.formItem(ItemModal modal) {
    name = modal.name ?? '';
    gst = modal.taxDetails
        .firstWhere((e) => e.gstRateDutyHead == 'Integrated Tax')
        .gstRate ??
        '0';
    hsn = modal.stockDetails.hsnCode ?? '';
  }

  ProductModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    unit = json['unit'];
    gst = json['gst'];
    hsn = json['hsn'];
  }

  @override
  String toString() => jsonEncode(toJson());

  static List<ProductModal> formResults(result) {
    return result.map<ProductModal>(ProductModal.formItem).toList();
  }

  static List<ProductModal> formJsonResults(json) {
    return json.map<ProductModal>((e) => ProductModal.fromJson(e)).toList();
  }
}
