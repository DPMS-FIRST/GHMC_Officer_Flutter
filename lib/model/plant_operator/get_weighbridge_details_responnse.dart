class WeighBridgeDetailsResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  String? tRNo;
  String? vehicleNo;
  String? date;
  String? gROSSWeight;
  String? tareWeight;
  String? netWeight;
  String? typeofMaterial;
  String? dateIn;
  String? timeIn;
  String? dateOut;
  String? timeOut;

  WeighBridgeDetailsResponse(
      {this.sTATUSCODE,
      this.sTATUSMESSAGE,
      this.tRNo,
      this.vehicleNo,
      this.date,
      this.gROSSWeight,
      this.tareWeight,
      this.netWeight,
      this.typeofMaterial,
      this.dateIn,
      this.timeIn,
      this.dateOut,
      this.timeOut});

  WeighBridgeDetailsResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    tRNo = json['TRNo'];
    vehicleNo = json['VehicleNo'];
    date = json['Date'];
    gROSSWeight = json['GROSSWeight'];
    tareWeight = json['TareWeight'];
    netWeight = json['NetWeight'];
    typeofMaterial = json['TypeofMaterial'];
    dateIn = json['DateIn'];
    timeIn = json['TimeIn'];
    dateOut = json['DateOut'];
    timeOut = json['TimeOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    data['TRNo'] = this.tRNo;
    data['VehicleNo'] = this.vehicleNo;
    data['Date'] = this.date;
    data['GROSSWeight'] = this.gROSSWeight;
    data['TareWeight'] = this.tareWeight;
    data['NetWeight'] = this.netWeight;
    data['TypeofMaterial'] = this.typeofMaterial;
    data['DateIn'] = this.dateIn;
    data['TimeIn'] = this.timeIn;
    data['DateOut'] = this.dateOut;
    data['TimeOut'] = this.timeOut;
    return data;
  }
}