class FilingReport {
  String? task;
  Essentials essentials = Essentials();
  String? id;
  String? patronId;
  Result result = Result();

  FilingReport({task, essentials, id, patronId, result});

  FilingReport.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    essentials = json['essentials'] != null
        ? Essentials.fromJson(json['essentials'])
        : Essentials();
    id = json['id'];
    patronId = json['patronId'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : Result();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['essentials'] = essentials.toJson();

    data['id'] = id;
    data['patronId'] = patronId;
    data['result'] = result.toJson();

    return data;
  }
}

class Essentials {
  String? gstin;

  Essentials({gstin});

  Essentials.fromJson(Map<String, dynamic> json) {
    gstin = json['gstin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstin'] = gstin;
    return data;
  }
}

class Result {
  GstnDetailed gstnDetailed = GstnDetailed();
  List<GstnRecords> gstnRecords = [];
  String? gstin;
  String? annualAggregateTurnOver;
  AggregateTurnOverRange aggregateTurnOverRange = AggregateTurnOverRange();
  String? grossTotalIncome;
  String? grossTotalIncomeFinancialYear;
  List<FilingStatus> filingStatus = [];

  Result();

  Result.fromJson(Map<String, dynamic> json) {
    gstnDetailed = json['gstnDetailed'] != null
        ? GstnDetailed.fromJson(json['gstnDetailed'])
        : GstnDetailed();
    if (json['gstnRecords'] != null) {
      json['gstnRecords'].forEach((v) {
        gstnRecords.add(GstnRecords.fromJson(v));
      });
    }
    gstin = json['gstin'];
    annualAggregateTurnOver = json['annualAggregateTurnOver'];
    aggregateTurnOverRange = json['aggregateTurnOverRange'] != null
        ? AggregateTurnOverRange.fromJson(json['aggregateTurnOverRange'])
        : AggregateTurnOverRange();
    grossTotalIncome = json['grossTotalIncome'];
    grossTotalIncomeFinancialYear = json['grossTotalIncomeFinancialYear'];
    if (json['filingStatus'] != null) {
      json['filingStatus'].forEach((v) {
        filingStatus.add(FilingStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstnDetailed'] = gstnDetailed.toJson();

    data['gstnRecords'] = gstnRecords.map((v) => v.toJson()).toList();

    data['gstin'] = gstin;
    data['annualAggregateTurnOver'] = annualAggregateTurnOver;
    data['aggregateTurnOverRange'] = aggregateTurnOverRange.toJson();

    data['grossTotalIncome'] = grossTotalIncome;
    data['grossTotalIncomeFinancialYear'] = grossTotalIncomeFinancialYear;
    data['filingStatus'] = filingStatus.map((v) => v.toJson()).toList();

    return data;
  }
}

class GstnDetailed {
  String? constitutionOfBusiness;
  String? legalNameOfBusiness;
  String? tradeNameOfBusiness;
  String? centreJurisdiction;
  String? stateJurisdiction;
  String? registrationDate;
  String? taxPayerDate;
  String? taxPayerType;
  String? gstinStatus;
  String? cancellationDate;
  List<String> natureOfBusinessActivities = [];
  String? principalPlaceLatitude;
  String? principalPlaceLongitude;
  String? principalPlaceStreet;
  String? principalPlaceLocality;
  String? principalPlaceCity;
  String? principalPlaceDistrict;
  String? principalPlaceState;
  String? principalPlacePincode;
  String? additionalPlaceLatitude;
  String? additionalPlaceLongitude;
  String? additionalPlaceStreet;
  String? additionalPlaceLocality;
  String? additionalPlaceCity;
  String? additionalPlaceDistrict;
  String? additionalPlaceState;
  String? additionalPlacePincode;
  String? complianceRating;
  List<AdditionalPlaceAddress> additionalPlaceAddress = [];
  List<String> directorNames = [];
  AdditionalPlaceAddress principalPlaceAddress = AdditionalPlaceAddress();

  GstnDetailed();

  GstnDetailed.fromJson(Map<String, dynamic> json) {
    constitutionOfBusiness = json['constitutionOfBusiness'];
    legalNameOfBusiness = json['legalNameOfBusiness'];
    tradeNameOfBusiness = json['tradeNameOfBusiness'];
    centreJurisdiction = json['centreJurisdiction'];
    stateJurisdiction = json['stateJurisdiction'];
    registrationDate = json['registrationDate'];
    taxPayerDate = json['taxPayerDate'];
    taxPayerType = json['taxPayerType'];
    gstinStatus = json['gstinStatus'];
    cancellationDate = json['cancellationDate'];
    natureOfBusinessActivities =
        json['natureOfBusinessActivities'].cast<String>();
    principalPlaceLatitude = json['principalPlaceLatitude'];
    principalPlaceLongitude = json['principalPlaceLongitude'];
    principalPlaceStreet = json['principalPlaceStreet'];
    principalPlaceLocality = json['principalPlaceLocality'];
    principalPlaceCity = json['principalPlaceCity'];
    principalPlaceDistrict = json['principalPlaceDistrict'];
    principalPlaceState = json['principalPlaceState'];
    principalPlacePincode = json['principalPlacePincode'];
    additionalPlaceLatitude = json['additionalPlaceLatitude'];
    additionalPlaceLongitude = json['additionalPlaceLongitude'];
    additionalPlaceStreet = json['additionalPlaceStreet'];
    additionalPlaceLocality = json['additionalPlaceLocality'];
    additionalPlaceCity = json['additionalPlaceCity'];
    additionalPlaceDistrict = json['additionalPlaceDistrict'];
    additionalPlaceState = json['additionalPlaceState'];
    additionalPlacePincode = json['additionalPlacePincode'];
    complianceRating = json['complianceRating'];
    if (json['additionalPlaceAddress'] != null) {
      json['additionalPlaceAddress'].forEach((v) {
        additionalPlaceAddress.add(AdditionalPlaceAddress.fromJson(v));
      });
    }
    directorNames = json['directorNames'].cast<String>();
    principalPlaceAddress = json['principalPlaceAddress'] != null
        ? AdditionalPlaceAddress.fromJson(json['principalPlaceAddress'])
        : AdditionalPlaceAddress();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['constitutionOfBusiness'] = constitutionOfBusiness;
    data['legalNameOfBusiness'] = legalNameOfBusiness;
    data['tradeNameOfBusiness'] = tradeNameOfBusiness;
    data['centreJurisdiction'] = centreJurisdiction;
    data['stateJurisdiction'] = stateJurisdiction;
    data['registrationDate'] = registrationDate;
    data['taxPayerDate'] = taxPayerDate;
    data['taxPayerType'] = taxPayerType;
    data['gstinStatus'] = gstinStatus;
    data['cancellationDate'] = cancellationDate;
    data['natureOfBusinessActivities'] = natureOfBusinessActivities;
    data['principalPlaceLatitude'] = principalPlaceLatitude;
    data['principalPlaceLongitude'] = principalPlaceLongitude;
    data['principalPlaceStreet'] = principalPlaceStreet;
    data['principalPlaceLocality'] = principalPlaceLocality;
    data['principalPlaceCity'] = principalPlaceCity;
    data['principalPlaceDistrict'] = principalPlaceDistrict;
    data['principalPlaceState'] = principalPlaceState;
    data['principalPlacePincode'] = principalPlacePincode;
    data['additionalPlaceLatitude'] = additionalPlaceLatitude;
    data['additionalPlaceLongitude'] = additionalPlaceLongitude;
    data['additionalPlaceStreet'] = additionalPlaceStreet;
    data['additionalPlaceLocality'] = additionalPlaceLocality;
    data['additionalPlaceCity'] = additionalPlaceCity;
    data['additionalPlaceDistrict'] = additionalPlaceDistrict;
    data['additionalPlaceState'] = additionalPlaceState;
    data['additionalPlacePincode'] = additionalPlacePincode;
    data['complianceRating'] = complianceRating;
    data['additionalPlaceAddress'] =
        additionalPlaceAddress.map((v) => v.toJson()).toList();

    data['directorNames'] = directorNames;
    data['principalPlaceAddress'] = principalPlaceAddress.toJson();

    return data;
  }
}

class AdditionalPlaceAddress {
  String? emailId;
  String? address;
  String? natureOfBusiness;
  String? mobile;
  String? lastUpdatedDate;
  SplitAddress splitAddress = SplitAddress();

  AdditionalPlaceAddress();

  AdditionalPlaceAddress.fromJson(Map<String, dynamic> json) {
    emailId = json['emailId'];
    address = json['address'];
    natureOfBusiness = json['natureOfBusiness'];
    mobile = json['mobile'];
    lastUpdatedDate = json['lastUpdatedDate'];
    splitAddress = json['splitAddress'] != null
        ? SplitAddress.fromJson(json['splitAddress'])
        : SplitAddress();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailId'] = emailId;
    data['address'] = address;
    data['natureOfBusiness'] = natureOfBusiness;
    data['mobile'] = mobile;
    data['lastUpdatedDate'] = lastUpdatedDate;
    data['splitAddress'] = splitAddress.toJson();
    return data;
  }
}

class SplitAddress {
  List<String> district = [];
  List<List> state = [];
  List<String> city = [];
  String? pincode;
  List<String> country = [];
  String? addressLine;

  SplitAddress();

  SplitAddress.fromJson(Map<String, dynamic> json) {
    district = json['district'].cast<String>();
    if (json['state'] != null) {
      json['state'].forEach((v) {
        // state!.add( List.fromJson(v));
      });
    }
    city = json['city'].cast<String>();
    pincode = json['pincode'];
    country = json['country'].cast<String>();
    addressLine = json['addressLine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district'] = district;
    if (state != null) {
      //data['state'] = state!.map((v) => v.toJson()).toList();
    }
    data['city'] = city;
    data['pincode'] = pincode;
    data['country'] = country;
    data['addressLine'] = addressLine;
    return data;
  }
}

class GstnRecords {
  String? applicationStatus;
  String? registrationName;
  String? mobNum;
  String? regType;
  String? emailId;
  String? tinNumber;
  String? gstinRefId;
  String? gstin;

  GstnRecords(
      {applicationStatus,
      registrationName,
      mobNum,
      regType,
      emailId,
      tinNumber,
      gstinRefId,
      gstin});

  GstnRecords.fromJson(Map<String, dynamic> json) {
    applicationStatus = json['applicationStatus'];
    registrationName = json['registrationName'];
    mobNum = json['mobNum'];
    regType = json['regType'];
    emailId = json['emailId'];
    tinNumber = json['tinNumber'];
    gstinRefId = json['gstinRefId'];
    gstin = json['gstin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicationStatus'] = applicationStatus;
    data['registrationName'] = registrationName;
    data['mobNum'] = mobNum;
    data['regType'] = regType;
    data['emailId'] = emailId;
    data['tinNumber'] = tinNumber;
    data['gstinRefId'] = gstinRefId;
    data['gstin'] = gstin;
    return data;
  }
}

class AggregateTurnOverRange {
  int? minimum;
  int? maximum;

  AggregateTurnOverRange({minimum, maximum});

  AggregateTurnOverRange.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minimum'] = minimum;
    data['maximum'] = maximum;
    return data;
  }
}

class FilingStatus {
  String? filingYear;
  String? monthOfFiling;
  String? methodOfFilling;
  String? dateOfFiling;
  String? gstType;
  String? gstStatus;

  FilingStatus(
      {filingYear,
      monthOfFiling,
      methodOfFilling,
      dateOfFiling,
      gstType,
      gstStatus});

  FilingStatus.fromJson(Map<String, dynamic> json) {
    filingYear = json['filingYear'];
    monthOfFiling = json['monthOfFiling'];
    methodOfFilling = json['methodOfFilling'];
    dateOfFiling = json['dateOfFiling'];
    gstType = json['gstType'];
    gstStatus = json['gstStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filingYear'] = filingYear;
    data['monthOfFiling'] = monthOfFiling;
    data['methodOfFilling'] = methodOfFilling;
    data['dateOfFiling'] = dateOfFiling;
    data['gstType'] = gstType;
    data['gstStatus'] = gstStatus;
    return data;
  }
}
