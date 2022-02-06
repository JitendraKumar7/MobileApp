import 'package:flutter/material.dart';

import '../../modal.dart';

const String hold = 'HOLD';
const String cancel = 'CANCEL';
const String received = 'RECEIVED';
const String confirmed = 'CONFIRMED';
const String dispatched = 'DISPATCHED';

class OrderModal extends BaseModal {
  String status = 'RECEIVED';
  String? message;

  bool get isHold => status == 'HOLD';

  bool get isCancel => status == 'CANCEL';

  bool get isReceived => status == 'RECEIVED';

  bool get isConfirmed => status == 'CONFIRMED';

  bool get isDispatched => status == 'DISPATCHED';

  Color get color {
    return isCancel
        ? Colors.red
        : isReceived
            ? Colors.blue
            : isConfirmed
                ? Colors.green
                : isDispatched
                    ? Colors.brown
                    : Colors.yellow;
  }

  OrderModal();

  List<List<String>> get data {
    return items.map((e) => e.order).toList();
  }

  Map<String, dynamic> get doc {
    var data = <String, dynamic>{};
    data['MESSAGE'] = message;
    data['UPDATE'] = update;
    data['STATUS'] = status;
    return data;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = jsonData();
    data['MESSAGE'] = message;
    data['STATUS'] = status;
    data['REMARK'] = remark;
    return data;
  }

  OrderModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    message = json['MESSAGE'];
    remark = json['REMARK'];
    status = json['STATUS'];
    jsonParse(json);
  }
}
