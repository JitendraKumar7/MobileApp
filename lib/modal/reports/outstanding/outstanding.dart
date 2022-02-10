import 'dart:convert';

class Outstanding {
  dynamic ref;
  dynamic dueDate;
  dynamic billDate;
  dynamic partyName;
  dynamic overDueDate;
  dynamic pendingAmount;

  String get name => partyName?.toUpperCase() ?? '';

  Outstanding();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PENDINGAMOUNT'] = pendingAmount;
    data['OVERDUEBYDATE'] = overDueDate;
    data['PARTYNAME'] = partyName;
    data['BILLDATE'] = billDate;
    data['DUEDATE'] = dueDate;
    data['REF'] = ref;
    return data;
  }

  Outstanding.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    pendingAmount = json['PENDINGAMOUNT'];
    overDueDate = json['OVERDUEBYDATE'];
    partyName = json['PARTYNAME'];
    billDate = json['BILLDATE'];
    dueDate = json['DUEDATE'];
    ref = json['REF'];
  }

  @override
  String toString() => jsonEncode(toJson());
}
