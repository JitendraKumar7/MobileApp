import 'dart:convert';

class LedgerModal {
  String? name;
  String? parent;
  String? address;
  String? pinCode;
  String? bankName;
  String? ifscCode;
  String? partyGstin;
  String? countryName;
  String? mailingName;
  String? ledStateName;
  String? accountNumber;
  String? closingBalance;
  String? openingBalance;
  String? priorStateName;
  String? incomeTexNumber;
  String? isEBankingEnabled;
  String? gstRegistrationType;

  LedgerModal();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GSTREGISTRATIONTYPE'] = gstRegistrationType;
    data['ISEBANKINGENABLED'] = isEBankingEnabled;
    data['INCOMETAXNUMBER'] = incomeTexNumber;
    data['PRIORSTATENAME'] = priorStateName;
    data['OPENINGBALANCE'] = openingBalance;
    data['CLOSINGBALANCE'] = closingBalance;
    data['ACCOUNTNUMBER'] = accountNumber;
    data['LEDSTATENAME'] = ledStateName;
    data['COUNTRYNAME'] = countryName;
    data['MAILINGNAME'] = mailingName;
    data['PARTYGSTIN'] = partyGstin;
    data['BANKNAME'] = bankName;
    data['IFSCODE'] = ifscCode;
    data['ADDRESS'] = address;
    data['PINCODE'] = pinCode;
    data['PARENT'] = parent;
    data['NAME'] = name;
    return data;
  }

  LedgerModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    gstRegistrationType = json['GSTREGISTRATIONTYPE'];
    isEBankingEnabled = json['ISEBANKINGENABLED'];
    incomeTexNumber = json['INCOMETAXNUMBER'];
    closingBalance = json['CLOSINGBALANCE'];
    priorStateName = json['PRIORSTATENAME'];
    openingBalance = json['OPENINGBALANCE'];
    accountNumber = json['ACCOUNTNUMBER'];
    ledStateName = json['LEDSTATENAME'];
    countryName = json['COUNTRYNAME'];
    mailingName = json['MAILINGNAME'];
    partyGstin = json['PARTYGSTIN'];
    bankName = json['BANKNAME'];
    ifscCode = json['IFSCODE'];
    address = json['ADDRESS'];
    pinCode = json['PINCODE'];
    parent = json['PARENT'];
    name = json['NAME'];
  }

  @override
  String toString() => jsonEncode(toJson());
}
