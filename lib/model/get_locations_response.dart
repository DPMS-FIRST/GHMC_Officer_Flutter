class getLocationsResponse {
  String? statusMessage;
  String? statusCode;
  List<LocationMaster>? locationMaster;

  getLocationsResponse(
      {this.statusMessage, this.statusCode, this.locationMaster});

  getLocationsResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['statusMessage'];
    statusCode = json['statusCode'];
    if (json['LocationMaster'] != null) {
      locationMaster = <LocationMaster>[];
      json['LocationMaster'].forEach((v) {
        locationMaster!.add(new LocationMaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusMessage'] = this.statusMessage;
    data['statusCode'] = this.statusCode;
    if (this.locationMaster != null) {
      data['LocationMaster'] =
          this.locationMaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationMaster {
  String? lOCATIONNAME;
  String? lATITUDES;
  String? lONGITUDES;
  String? rADIUS;
  String? status;
  String? cATEGORYID;
  String? cATEGORYNAME;
  String? lOCATIONMAPID;

  LocationMaster(
      {this.lOCATIONNAME,
      this.lATITUDES,
      this.lONGITUDES,
      this.rADIUS,
      this.status,
      this.cATEGORYID,
      this.cATEGORYNAME,
      this.lOCATIONMAPID});

  LocationMaster.fromJson(Map<String, dynamic> json) {
    lOCATIONNAME = json['LOCATION_NAME'];
    lATITUDES = json['LATITUDES'];
    lONGITUDES = json['LONGITUDES'];
    rADIUS = json['RADIUS'];
    status = json['status'];
    cATEGORYID = json['CATEGORY_ID'];
    cATEGORYNAME = json['CATEGORY_NAME'];
    lOCATIONMAPID = json['LOCATION_MAP_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LOCATION_NAME'] = this.lOCATIONNAME;
    data['LATITUDES'] = this.lATITUDES;
    data['LONGITUDES'] = this.lONGITUDES;
    data['RADIUS'] = this.rADIUS;
    data['status'] = this.status;
    data['CATEGORY_ID'] = this.cATEGORYID;
    data['CATEGORY_NAME'] = this.cATEGORYNAME;
    data['LOCATION_MAP_ID'] = this.lOCATIONMAPID;
    return data;
  }
}
