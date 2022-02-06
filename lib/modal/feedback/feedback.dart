import 'dart:convert';

import 'package:uuid/uuid.dart';

class FeedbackModal {
  int timestamp = 0;

  String userId = '';
  String message = '';
  String document = '';

  FeedbackModal() {
    timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();
    document = const Uuid().v1();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['TIMESTAMP'] = timestamp;
    data['DOCUMENT'] = document;
    data['MESSAGE'] = message;
    data['USER_ID'] = userId;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());

  FeedbackModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    timestamp = json['TIMESTAMP'];
    document = json['DOCUMENT'];
    message = json['MESSAGE'];
    userId = json['USER_ID'];
  }
}
