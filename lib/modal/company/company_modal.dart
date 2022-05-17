import 'dart:convert';

class CompanyModal {
  String? key;
  String? logo;
  String? name;
  String? email;
  String? gstin;
  String? mobile;
  String? address;
  String? pinCode;
  String? stateName;
  String? signature;
  String? booksFrom;
  String? countryName;
  String? startingFrom;
  String? openingBalance;
  String? closingBalance;
  String? selectedCompany;

  CompanyModal();

  String get getName => (selectedCompany ?? name)?.toUpperCase() ?? '';

  String get getAddress =>
      '${address ?? ''} ${stateName ?? ''} ${countryName ?? ''} ${pinCode ?? ''}'
          .toUpperCase()
          .trim();

  CompanyModal.fromJson(Map<String, dynamic>? json, [String? id]) {
    if (json == null) return;
    selectedCompany = json['SELECTEDCOMPANY'];
    openingBalance = json['OPENINGBALANCE'];
    closingBalance = json['CLOSINGBALANCE'];
    startingFrom = json['STARTINGFROM'];
    countryName = json['COUNTRYNAME'];
    booksFrom = json['BOOKSFROM'];
    stateName = json['STATENAME'];
    signature = json['SIGNATURE'];
    address = json['ADDRESS'];
    pinCode = json['PINCODE'];
    mobile = json['MOBILE'];
    gstin = json['GSTIN'];
    email = json['EMAIL'];
    name = json['NAME'];
    logo = json['LOGO'];
    key = id;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['SELECTEDCOMPANY'] = selectedCompany;
    data['OPENINGBALANCE'] = openingBalance;
    data['CLOSINGBALANCE'] = closingBalance;
    data['STARTINGFROM'] = startingFrom;
    data['COUNTRYNAME'] = countryName;
    data['BOOKSFROM'] = booksFrom;
    data['STATENAME'] = stateName;
    data['SIGNATURE'] = signature;
    data['ADDRESS'] = address;
    data['PINCODE'] = pinCode;
    data['MOBILE'] = mobile;
    data['GSTIN'] = gstin;
    data['EMAIL'] = email;
    data['NAME'] = name;
    data['LOGO'] = logo;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
