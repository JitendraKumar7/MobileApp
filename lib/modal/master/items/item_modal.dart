import 'dart:convert';

class ItemModal {
  String? guid;
  String? name;
  String? parent;

  bool isSelected = false;

  String price = '';
  String description = '';

  var stockDetails = StockDetails();
  List<TaxDetails> taxDetails = [];

  ItemModal();

  ItemModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;

    stockDetails = StockDetails.fromJson(json['STOCKDETAILS']);

    (json['TAXDETAILS'] ?? []).forEach((v) {
      taxDetails.add(TaxDetails.fromJson(v));
    });
    parent = json['PARENT'];
    name = json['NAME'];
    guid = json['GUID'];

    description = json['description'] ?? '';
    price = json['price'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['TAXDETAILS'] = taxDetails.map((v) => v.toJson()).toList();
    data['STOCKDETAILS'] = stockDetails.toJson();
    data['PARENT'] = parent;
    data['NAME'] = name;
    data['GUID'] = guid;
    data['description'] = description;
    data['price'] = price;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());

  static List<ItemModal> formJsonResults(json) {
    return json.map<ItemModal>((e) => ItemModal.fromJson(e)).toList();
  }
}

class TaxDetails {
  String? gstRate;
  String? gstRateDutyHead;
  String? gstRateValuationType;

  TaxDetails();

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
