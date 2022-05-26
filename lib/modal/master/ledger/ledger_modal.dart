import 'dart:convert';

class LedgerModal {
  dynamic name;
  dynamic email;
  dynamic parent;
  dynamic address;
  dynamic pinCode;
  dynamic bankName;
  dynamic ifscCode;
  dynamic partyGstin;
  dynamic countryName;
  dynamic mailingName;
  dynamic ledgerMobile;
  dynamic ledStateName;
  dynamic accountNumber;
  dynamic closingBalance;
  dynamic openingBalance;
  dynamic priorStateName;
  dynamic incomeTexNumber;
  dynamic isEBankingEnabled;
  dynamic gstRegistrationType;

  String get closingBal => remove(closingBalance);

  String get openingBal => remove(openingBalance);

  String get getName => name?.toUpperCase() ?? '';

  String get getAddress =>
      '${address ?? ''} ${ledStateName ?? ''} ${countryName ?? ''} ${pinCode ?? ''}'
          .toUpperCase()
          .trim();

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
    data['LEDGERMOBILE'] = ledgerMobile;
    data['COUNTRYNAME'] = countryName;
    data['MAILINGNAME'] = mailingName;
    data['PARTYGSTIN'] = partyGstin;
    data['BANKNAME'] = bankName;
    data['IFSCODE'] = ifscCode;
    data['ADDRESS'] = address;
    data['PINCODE'] = pinCode;
    data['PARENT'] = parent;
    data['EMAIL'] = email;
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
    ledgerMobile = json['LEDGERMOBILE'];
    countryName = json['COUNTRYNAME'];
    mailingName = json['MAILINGNAME'];
    partyGstin = json['PARTYGSTIN'];
    bankName = json['BANKNAME'];
    ifscCode = json['IFSCODE'];
    address = json['ADDRESS'];
    pinCode = json['PINCODE'];
    parent = json['PARENT'];
    email = json['EMAIL'];
    name = json['NAME'];
  }

  @override
  String toString() => jsonEncode(toJson());
}

String remove(input) {
  try {
    return input?.replaceFirst('-', '') ?? '0.00';
  } catch (error) {
    return '${input ?? '0.00'}'.replaceFirst('-', '');
  }
}
