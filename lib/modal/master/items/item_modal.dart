import 'dart:convert';

import '../../modal.dart';

class PriceListModal {
  final List<List<String>> items;
  final String title;

  PriceListModal(this.items, this.title);
}

class ItemModal {
  String? mrp;
  String? guid;
  String? name;
  String? parent;
  String? description;
  String? standardCost;
  String? standardPrice;

  String get getName => name?.toUpperCase() ?? '';

  bool isShow = true;
  bool isSelected = false;

  var stockDetails = StockDetails();
  List<TaxDetails> taxDetails = [];

  ItemModal();

  String? get gstRate => taxDetails
      .firstWhere((e) => e.isIntegratedTax, orElse: () => TaxDetails())
      .gstRate;

  bool changeSelection() => isSelected = !isSelected;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['TAXDETAILS'] = taxDetails.map((v) => v.toJson()).toList();
    data['STOCKDETAILS'] = stockDetails.toJson();
    data['STANDARDPRICE'] = standardPrice;
    data['STANDARDCOST'] = standardCost;
    data['DESCRIPTION'] = description;
    data['PARENT'] = parent;
    data['SHOW'] = isShow;
    data['NAME'] = name;
    data['GUID'] = guid;
    data['MRP'] = mrp;
    return data;
  }

  ItemModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;

    stockDetails = StockDetails.fromJson(json['STOCKDETAILS']);

    (json['TAXDETAILS'] ?? []).forEach((v) {
      taxDetails.add(TaxDetails.fromJson(v));
    });
    isShow = json['SHOW'] == true;
    standardPrice = json['STANDARDPRICE'];
    standardCost = json['STANDARDCOST'];
    description = json['DESCRIPTION'];
    parent = json['PARENT'];
    name = json['NAME'];
    guid = json['GUID'];
    mrp = json['MRP'];
  }

  @override
  String toString() => jsonEncode(toJson());

  ProductModal toItem() {
    return ProductModal(
      hsn: stockDetails.hsnCode ?? '',
      gst: gstRate ?? '',
      name: name ?? '',
      mrp: mrp ?? '',
    );
  }

  List<String> get value => <String>[
        name ?? '',
        stockDetails.hsnCode ?? '',
        description ?? '',
        standardPrice?.split('/').first ?? '',
        mrp?.split('/').first ?? ''
      ];
}

class TaxDetails {
  String? gstRate;
  String? gstRateDutyHead;
  String? gstRateValuationType;

  TaxDetails();

  bool get isIntegratedTax => gstRateDutyHead == 'Integrated Tax';

  String get title => '${gstRateDutyHead?.substring(0, 1)}GST Rate';

  TaxDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    gstRateValuationType = json['GSTRATEVALUATIONTYPE'];
    gstRateDutyHead = json['GSTRATEDUTYHEAD'];
    gstRate = json['GSTRATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GSTRATEVALUATIONTYPE'] = gstRateValuationType;
    data['GSTRATEDUTYHEAD'] = gstRateDutyHead;
    data['GSTRATE'] = gstRate;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}

class StockDetails {
  String? hsnCode;
  String? taxAbility;
  String? applicableFrom;

  StockDetails();

  StockDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    applicableFrom = json['APPLICABLEFROM'];
    taxAbility = json['TAXABILITY'];
    hsnCode = json['HSNCODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['APPLICABLEFROM'] = applicableFrom;
    data['TAXABILITY'] = taxAbility;
    data['HSNCODE'] = hsnCode;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
