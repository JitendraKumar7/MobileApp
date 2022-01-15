import 'dart:convert';

class Products {
  String? rate;
  String? amount;
  String? actualQty;
  String? billedDay;
  String? stockItemName;

  Products.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    stockItemName = json['STOCKITEMNAME'];
    actualQty = json['ACTUALQTY'];
    billedDay = json['BILLEDDAY'];
    amount = json['AMOUNT'];
    rate = json['RATE'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['STOCKITEMNAME'] = stockItemName;
    data['ACTUALQTY'] = actualQty;
    data['BILLEDDAY'] = billedDay;
    data['AMOUNT'] = amount;
    data['RATE'] = rate;
    return data;
  }

  List<String> get data =>
      [stockItemName ?? '', rate ?? '', actualQty ?? '', amount ?? ''];

  @override
  String toString() => jsonEncode(toJson());
}

class InvoiceModal {
  String? name;
  String? vchKey;
  String? vchType;
  String? narration;
  String? reference;
  String? totalAmount;
  String? voucherDate;
  String? voucherNumber;
  String? partyLedgerName;

  var productTotalAmount;

  List<Products> products = [];
  List<LedgerDetails> ledgerDetails = [];

  List<List<String>> get data {
    return products.map((e) => e.data).toList();
  }

  List<List<String>> get sundry {
    return ledgerDetails.reversed.map((e) => e.data).toList();
  }

  InvoiceModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    (json['LEDDETAILS'] ?? []).forEach((v) {
      ledgerDetails.add(LedgerDetails.fromJson(v));
    });

    (json['PRODUCTS'] ?? []).forEach((v) {
      products.add(Products.fromJson(v));
    });

    productTotalAmount = json['PRODUCTTOTALAMOUNT'];
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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['LEDDETAILS'] = ledgerDetails.map((v) => v.toJson()).toList();
    data['PRODUCTS'] = products.map((v) => v.toJson()).toList();

    data['PRODUCTTOTALAMOUNT'] = productTotalAmount;
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

  @override
  String toString() => jsonEncode(toJson());
}

class LedgerDetails {
  String? amount;
  String? ledgerName;
  String? vatExpAmount;

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

  List<String> get data => ['', ledgerName ?? '', amount ?? ''];

  @override
  String toString() => jsonEncode(toJson());
}
