class SearchGst {
  var result = Result();
  var error = Error();

  String? patronId;
  String? task;
  String? id;

  SearchGst();

  bool get isNotEmpty => patronId != null && task != null && id != null;

  SearchGst.fromJson(Map<String, dynamic>? json) {
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
  var gstnDetailed = GstnDetailed();
  List<GstnRecords> gstnRecords = [];
  String? gstin;

  Result();

  Result.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    gstnDetailed = GstnDetailed.fromJson(json['gstnDetailed']);

    json['gstnRecords']?.forEach((v) {
      gstnRecords.add(GstnRecords.fromJson(v));
    });

    gstin = json['gstin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstnRecords'] = gstnRecords.map((v) => v.toJson()).toList();
    data['gstnDetailed'] = gstnDetailed.toJson();
    data['gstin'] = gstin;
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
  String? principalPlaceAddress;
  String? principalPlaceLatitude;
  String? principalPlaceLongitude;
  String? principalPlaceBuildingNameFromGST;
  String? principalPlaceBuildingNoFromGST;
  String? principalPlaceFlatNo;
  String? principalPlaceStreet;
  String? principalPlaceLocality;
  String? principalPlaceCity;
  String? principalPlaceDistrict;
  String? principalPlaceState;
  String? principalPlacePincode;
  String? additionalPlaceAddress;
  String? additionalPlaceLatitude;
  String? additionalPlaceLongitude;
  String? additionalPlaceBuildingNameFromGST;
  String? additionalPlaceBuildingNoFromGST;
  String? additionalPlaceFlatNo;
  String? additionalPlaceStreet;
  String? additionalPlaceLocality;
  String? additionalPlaceCity;
  String? additionalPlaceDistrict;
  String? additionalPlaceState;
  String? additionalPlacePincode;
  String? lastUpdatedDate;

  List<String> natureOfBusinessActivities = [];
  List<AdditionalAddressArray> additionalAddressArray = [];
  var principalPlaceSplitAddress = PrincipalPlaceSplitAddress();
  var additionalPlaceSplitAddress = PrincipalPlaceSplitAddress();

  GstnDetailed();

  GstnDetailed.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
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
    principalPlaceAddress = json['principalPlaceAddress'];
    principalPlaceLatitude = json['principalPlaceLatitude'];
    principalPlaceLongitude = json['principalPlaceLongitude'];
    principalPlaceBuildingNameFromGST =
        json['principalPlaceBuildingNameFromGST'];
    principalPlaceBuildingNoFromGST = json['principalPlaceBuildingNoFromGST'];
    principalPlaceFlatNo = json['principalPlaceFlatNo'];
    principalPlaceStreet = json['principalPlaceStreet'];
    principalPlaceLocality = json['principalPlaceLocality'];
    principalPlaceCity = json['principalPlaceCity'];
    principalPlaceDistrict = json['principalPlaceDistrict'];
    principalPlaceState = json['principalPlaceState'];
    principalPlacePincode = json['principalPlacePincode'];
    additionalPlaceAddress = json['additionalPlaceAddress'];
    additionalPlaceLatitude = json['additionalPlaceLatitude'];
    additionalPlaceLongitude = json['additionalPlaceLongitude'];
    additionalPlaceBuildingNameFromGST =
        json['additionalPlaceBuildingNameFromGST'];
    additionalPlaceBuildingNoFromGST = json['additionalPlaceBuildingNoFromGST'];
    additionalPlaceFlatNo = json['additionalPlaceFlatNo'];
    additionalPlaceStreet = json['additionalPlaceStreet'];
    additionalPlaceLocality = json['additionalPlaceLocality'];
    additionalPlaceCity = json['additionalPlaceCity'];
    additionalPlaceDistrict = json['additionalPlaceDistrict'];
    additionalPlaceState = json['additionalPlaceState'];
    additionalPlacePincode = json['additionalPlacePincode'];

    json['additionalAddressArray']?.forEach((v) {
      additionalAddressArray.add(AdditionalAddressArray.fromJson(v));
    });

    lastUpdatedDate = json['lastUpdatedDate'];
    principalPlaceSplitAddress =
        PrincipalPlaceSplitAddress.fromJson(json['principalPlaceSplitAddress']);
    additionalPlaceSplitAddress = PrincipalPlaceSplitAddress.fromJson(
        json['additionalPlaceSplitAddress']);
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
    data['principalPlaceAddress'] = principalPlaceAddress;
    data['principalPlaceLatitude'] = principalPlaceLatitude;
    data['principalPlaceLongitude'] = principalPlaceLongitude;
    data['principalPlaceBuildingNameFromGST'] =
        principalPlaceBuildingNameFromGST;
    data['principalPlaceBuildingNoFromGST'] = principalPlaceBuildingNoFromGST;
    data['principalPlaceFlatNo'] = principalPlaceFlatNo;
    data['principalPlaceStreet'] = principalPlaceStreet;
    data['principalPlaceLocality'] = principalPlaceLocality;
    data['principalPlaceCity'] = principalPlaceCity;
    data['principalPlaceDistrict'] = principalPlaceDistrict;
    data['principalPlaceState'] = principalPlaceState;
    data['principalPlacePincode'] = principalPlacePincode;
    data['additionalPlaceAddress'] = additionalPlaceAddress;
    data['additionalPlaceLatitude'] = additionalPlaceLatitude;
    data['additionalPlaceLongitude'] = additionalPlaceLongitude;
    data['additionalPlaceBuildingNameFromGST'] =
        additionalPlaceBuildingNameFromGST;
    data['additionalPlaceBuildingNoFromGST'] = additionalPlaceBuildingNoFromGST;
    data['additionalPlaceFlatNo'] = additionalPlaceFlatNo;
    data['additionalPlaceStreet'] = additionalPlaceStreet;
    data['additionalPlaceLocality'] = additionalPlaceLocality;
    data['additionalPlaceCity'] = additionalPlaceCity;
    data['additionalPlaceDistrict'] = additionalPlaceDistrict;
    data['additionalPlaceState'] = additionalPlaceState;
    data['additionalPlacePincode'] = additionalPlacePincode;
    data['additionalAddressArray'] =
        additionalAddressArray.map((v) => v.toJson()).toList();
    data['lastUpdatedDate'] = lastUpdatedDate;
    data['principalPlaceSplitAddress'] = principalPlaceSplitAddress.toJson();
    data['additionalPlaceSplitAddress'] = additionalPlaceSplitAddress.toJson();
    return data;
  }
}

class AdditionalAddressArray {
  String? address;
  String? flatNo;
  String? street;
  String? locality;
  String? buildingNo;
  String? buildingName;
  String? district;
  String? city;
  String? state;
  String? pincode;
  String? latitude;
  String? longitude;

  AdditionalAddressArray();

  AdditionalAddressArray.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    address = json['address'];
    flatNo = json['flatNo'];
    street = json['street'];
    locality = json['locality'];
    buildingNo = json['buildingNo'];
    buildingName = json['buildingName'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['flatNo'] = flatNo;
    data['street'] = street;
    data['locality'] = locality;
    data['buildingNo'] = buildingNo;
    data['buildingName'] = buildingName;
    data['district'] = district;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class PrincipalPlaceSplitAddress {
  String? pinCode;
  String? addressLine;
  List<String> city = [];
  List<String> country = [];
  List<String> district = [];
  List<List<String>> state = [];

  PrincipalPlaceSplitAddress();

  PrincipalPlaceSplitAddress.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    district = json['district'].cast<String>();
    country = json['country'].cast<String>();
    city = json['city'].cast<String>();
    if (json['state'] != null) {
      json['state'].forEach((v) {
        //state.add(List.fromJson(v));
      });
    }
    pinCode = json['pincode'];
    addressLine = json['addressLine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district'] = district;
    //if (state != null) {
    //data['state'] = state.map((v) => v.toJson()).toList();
    //}
    data['city'] = city;
    data['pincode'] = pinCode;
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

  GstnRecords();

  GstnRecords.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
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
