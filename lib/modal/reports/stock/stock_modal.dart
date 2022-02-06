import 'dart:convert';

import '../../modal.dart';

class StockModal {
  String? parent;

  String get name => parent?.toUpperCase() ?? '';

  List<ItemModal> inventory = [];

  StockModal();

  StockModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    parent = json['PARENT'];
    (json['DATA'] ?? []).forEach((e) {
      inventory.add(ItemModal.fromJson(e));
    });
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['PARENT'] = parent;
    data['DATA'] = inventory.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
