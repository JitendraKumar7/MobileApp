import 'dart:convert';

class ProfileModal {
  dynamic uid;
  dynamic email;
  dynamic mobile;
  dynamic profile;
  dynamic userType;
  dynamic password;
  dynamic lastName;
  dynamic firstName;
  dynamic whatsAppUserId;

  String get name => '$firstName $lastName'.toUpperCase();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['whatsAppUserId'] = whatsAppUserId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['password'] = password;
    data['userType'] = userType;
    data['profile'] = profile;
    data['mobile'] = mobile;
    data['email'] = email;
    data['uid'] = uid;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());

  ProfileModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    whatsAppUserId = json['whatsAppUserId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    userType = json['userType'];
    profile = json['profile'];
    mobile = json['mobile'];
    email = json['email'];
    uid = json['uid'];
  }

  ProfileModal setProfile(String url) {
    profile = url;
    return this;
  }
}
