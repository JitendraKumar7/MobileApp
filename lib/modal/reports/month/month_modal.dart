import 'dart:convert';

class MonthModal {
  String? month;

  MonthModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    month = json['MONTH'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['MONTH'] = month;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
