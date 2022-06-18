import 'dart:convert';

class StockItem {
  dynamic name;
  dynamic rate;
  dynamic parent;
  dynamic amount;
  dynamic quantity;
  dynamic category;
  dynamic openingBalance;

  dynamic isExpanded = false;

  String get getName => name?.toUpperCase() ?? '';

  StockItem();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OPENINGBALANCE'] = openingBalance;
    data['CATEGORY'] = category;
    data['QUANTITY'] = quantity;
    data['AMOUNT'] = amount;
    data['PARENT'] = parent;
    data['RATE'] = rate;
    data['NAME'] = name;
    return data;
  }

  StockItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    openingBalance = json['OPENINGBALANCE'];
    category = json['CATEGORY'];
    quantity = json['QUANTITY'];
    amount = json['AMOUNT'];
    parent = json['PARENT'];
    rate = json['RATE'];
    name = json['NAME'];
  }

  @override
  String toString() => jsonEncode(toJson());

  bool any(String value) => name.contains(value);
}

class StockModal {
  dynamic parent;

  List<StockItem> items = [];

  StockModal();

  String get name => parent?.toUpperCase() ?? '';

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['PARENT'] = parent;
    data['ITEMS'] = items.map((e) => e.toJson()).toList();
    return data;
  }

  StockModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    parent = json['PARENT'];
    (json['ITEMS'] ?? []).forEach((e) {
      items.add(StockItem.fromJson(e));
    });
  }

  @override
  String toString() => jsonEncode(toJson());
}
