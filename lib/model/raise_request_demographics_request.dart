class RaiseRequestDemographicsRequest {
  String? uSERID;
  String? pASSWORD;
  String? lATITUDE;
  String? lONGITUDE;

  RaiseRequestDemographicsRequest(
      {this.uSERID, this.pASSWORD, this.lATITUDE, this.lONGITUDE});

  RaiseRequestDemographicsRequest.fromJson(Map<String, dynamic> json) {
    uSERID = json['USER_ID'];
    pASSWORD = json['PASSWORD'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_ID'] = this.uSERID;
    data['PASSWORD'] = this.pASSWORD;
    data['LATITUDE'] = this.lATITUDE;
    data['LONGITUDE'] = this.lONGITUDE;
    return data;
  }
}
