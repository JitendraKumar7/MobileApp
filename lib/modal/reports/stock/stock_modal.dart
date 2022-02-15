import 'dart:convert';

import '../../modal.dart';

class StockModal {
  dynamic parent;

  List<ItemModal> items = [];

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
      items.add(ItemModal.fromJson(e));
    });
  }

  @override
  String toString() => jsonEncode(toJson());
}
