class SearchCompany {
  var result = Result();
  var error = Error();

  String? patronId;
  String? task;
  String? id;

  SearchCompany();

  bool get isNotEmpty => patronId != null && task != null && id != null;

  SearchCompany.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;

    result = Result.fromJson(json['result']);
    error = Error.fromJson(json['error']);
    patronId = json['patronId'];
    task = json['task'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result.toJson();
    data['patronId'] = patronId;
    data['task'] = task;
    data['id'] = id;
    return data;
  }
}

class Error {
  int? statusCode, status;
  String? message, name;

  Error();

  bool get isNotEmpty => message != null && name != null;

  Error.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    statusCode = json['statusCode'];
    message = json['message'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['status'] = status;
    data['name'] = name;
    return data;
  }
}

class Result {
  List<GstDetails> gstDetails = [];

  Result();

  Result.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    json['gstDetails']?.forEach((v) {
      gstDetails.add(GstDetails.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstDetails'] = gstDetails.map((v) => v.toJson()).toList();
    return data;
  }
}

class GstDetails {
  String? gstin;
  String? state;
  String? name;

  GstDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    gstin = json['gstin'];
    state = json['state'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstin'] = gstin;
    data['state'] = state;
    data['name'] = name;
    return data;
  }
}
