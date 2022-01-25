import 'dart:convert';

class CompanyModal {
  String? name;
  String? email;
  String? gstin;
  String? mobile;
  String? address;
  String? pinCode;
  String? stateName;
  String? booksFrom;
  String? countryName;
  String? startingFrom;
  String? openingBalance;
  String? closingBalance;
  List<int> companyLogo = [];

  CompanyModal();

  String get getName => name?.toUpperCase() ?? '';

  String get getAddress =>
      '$address $stateName $countryName, $pinCode.'.toUpperCase();

  CompanyModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    companyLogo = json['COMPANY_LOGO']?.cast<int>() ?? [];
    openingBalance = json['OPENINGBALANCE'];
    closingBalance = json['CLOSINGBALANCE'];
    startingFrom = json['STARTINGFROM'];
    countryName = json['COUNTRYNAME'];
    booksFrom = json['BOOKSFROM'];
    stateName = json['STATENAME'];
    address = json['ADDRESS'];
    pinCode = json['PINCODE'];
    mobile = json['MOBILE'];
    gstin = json['GSTIN'];
    email = json['EMAIL'];
    name = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['OPENINGBALANCE'] = openingBalance;
    data['CLOSINGBALANCE'] = closingBalance;
    data['STARTINGFROM'] = startingFrom;
    data['COMPANY_LOGO'] = companyLogo;
    data['COUNTRYNAME'] = countryName;
    data['BOOKSFROM'] = booksFrom;
    data['STATENAME'] = stateName;
    data['ADDRESS'] = address;
    data['PINCODE'] = pinCode;
    data['MOBILE'] = mobile;
    data['GSTIN'] = gstin;
    data['EMAIL'] = email;
    data['NAME'] = name;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
