import 'dart:convert';

class StatementModal {
  String? name;

  Map<String, dynamic>? json;

  StatementModal();

  StatementModal.fromJson(Map<String, dynamic>? json) {
    name = json?['NAME'] ?? '';
    json = json;
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    return json ?? data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
