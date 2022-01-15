import 'dart:convert';

class GroupModal {
  String? name;
  String? parent;

  GroupModal();

  GroupModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    parent = json['PARENT'];
    name = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PARENT'] = parent;
    data['NAME'] = name;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
