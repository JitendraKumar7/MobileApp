class SearchCompany {
  var essentials = Essentials();
  var result = Result();

  String? patronId;
  String? task;
  String? id;

  SearchCompany();

  bool get isNotEmpty => patronId != null && task != null && id != null;

  SearchCompany.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;

    essentials = Essentials.fromJson(json['essentials']);
    result = Result.fromJson(json['result']);
    patronId = json['patronId'];
    task = json['task'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['essentials'] = essentials.toJson();
    data['result'] = result.toJson();
    data['patronId'] = patronId;
    data['task'] = task;
    data['id'] = id;
    return data;
  }
}

class Essentials {
  String? companyName;

  Essentials();

  Essentials.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyName'] = companyName;
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
