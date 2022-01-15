import 'dart:convert';

class CompanyModal {
  String? name;
  String? email;
  String? gstin;
  String? address;
  String? pinCode;
  String? stateName;
  String? booksFrom;
  String? countryName;
  String? startingFrom;
  String? openingBalance;
  String? closingBalance;

  bool? exportToCloud;

  CompanyModal();

  String get getAddress => '$address $stateName $countryName, $pinCode.';

  CompanyModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    openingBalance = json['OPENINGBALANCE'];
    closingBalance = json['CLOSINGBALANCE'];
    exportToCloud = json['EXPORTTOCLOUD'];
    startingFrom = json['STARTINGFROM'];
    countryName = json['COUNTRYNAME'];
    booksFrom = json['BOOKSFROM'];
    stateName = json['STATENAME'];
    address = json['ADDRESS'];
    pinCode = json['PINCODE'];
    gstin = json['GSTIN'];
    email = json['EMAIL'];
    name = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['OPENINGBALANCE'] = openingBalance;
    data['CLOSINGBALANCE'] = closingBalance;
    data['EXPORTTOCLOUD'] = exportToCloud;
    data['STARTINGFROM'] = startingFrom;
    data['COUNTRYNAME'] = countryName;
    data['BOOKSFROM'] = booksFrom;
    data['STATENAME'] = stateName;
    data['ADDRESS'] = address;
    data['PINCODE'] = pinCode;
    data['GSTIN'] = gstin;
    data['EMAIL'] = email;
    data['NAME'] = name;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
