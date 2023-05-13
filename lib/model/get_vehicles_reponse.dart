class GetVehiclesResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<VEHICLELIST>? vEHICLELIST;

  GetVehiclesResponse({this.sTATUSCODE, this.sTATUSMESSAGE, this.vEHICLELIST});

  GetVehiclesResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['VEHICLELIST'] != null) {
      vEHICLELIST = <VEHICLELIST>[];
      json['VEHICLELIST'].forEach((v) {
        vEHICLELIST!.add(new VEHICLELIST.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.vEHICLELIST != null) {
      data['VEHICLELIST'] = this.vEHICLELIST!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VEHICLELIST {
  String? vEHICLETYPEID;
  String? vEHICLETYPE;
  String? aMOUNT;

  VEHICLELIST({this.vEHICLETYPEID, this.vEHICLETYPE, this.aMOUNT});

  VEHICLELIST.fromJson(Map<String, dynamic> json) {
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
    vEHICLETYPE = json['VEHICLE_TYPE'];
    aMOUNT = json['AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    data['VEHICLE_TYPE'] = this.vEHICLETYPE;
    data['AMOUNT'] = this.aMOUNT;
    return data;
  }
}
