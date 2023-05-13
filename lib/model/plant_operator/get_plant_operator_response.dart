class GetPlantOperatorVehicleTripResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<OperatorVehicleList>? operatorVehicleList;

  GetPlantOperatorVehicleTripResponse(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.operatorVehicleList});

  GetPlantOperatorVehicleTripResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['OperatorVehicleList'] != null) {
      operatorVehicleList = <OperatorVehicleList>[];
      json['OperatorVehicleList'].forEach((v) {
        operatorVehicleList!.add(new OperatorVehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.operatorVehicleList != null) {
      data['OperatorVehicleList'] =
          this.operatorVehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OperatorVehicleList {
  String? cNDWGRIEVANCESID;
  String? vEHICLENUMBER;
  String? vEHICLETYPEID;
  String? vEHICLETYPE;
  String? zONE;
  String? cIRCLE;
  String? wARD;
  String? dRIVERNAME;
  String? dRIVERMOBILENUMBER;
  String? sUPERVISORNUMBER;
  String? sUPERVISORNAME;
  String? tYPEOFWASTE;
  String? tICKETUPDATEDON;
  String? bEFORETRIPIMAGE;
  String? pLANTID;

  OperatorVehicleList(
      {this.cNDWGRIEVANCESID,
      this.vEHICLENUMBER,
      this.vEHICLETYPEID,
      this.vEHICLETYPE,
      this.zONE,
      this.cIRCLE,
      this.wARD,
      this.dRIVERNAME,
      this.dRIVERMOBILENUMBER,
      this.sUPERVISORNUMBER,
      this.sUPERVISORNAME,
      this.tYPEOFWASTE,
      this.tICKETUPDATEDON,
      this.bEFORETRIPIMAGE,
      this.pLANTID});

  OperatorVehicleList.fromJson(Map<String, dynamic> json) {
    cNDWGRIEVANCESID = json['CNDW_GRIEVANCES_ID'];
    vEHICLENUMBER = json['VEHICLE_NUMBER'];
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
    vEHICLETYPE = json['VEHICLE_TYPE'];
    zONE = json['ZONE'];
    cIRCLE = json['CIRCLE'];
    wARD = json['WARD'];
    dRIVERNAME = json['DRIVER_NAME'];
    dRIVERMOBILENUMBER = json['DRIVER_MOBILE_NUMBER'];
    sUPERVISORNUMBER = json['SUPERVISOR_NUMBER'];
    sUPERVISORNAME = json['SUPERVISOR_NAME'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
    tICKETUPDATEDON = json['TICKET_UPDATED_ON'];
    bEFORETRIPIMAGE = json['BEFORE_TRIP_IMAGE'];
    pLANTID = json['PLANT_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CNDW_GRIEVANCES_ID'] = this.cNDWGRIEVANCESID;
    data['VEHICLE_NUMBER'] = this.vEHICLENUMBER;
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    data['VEHICLE_TYPE'] = this.vEHICLETYPE;
    data['ZONE'] = this.zONE;
    data['CIRCLE'] = this.cIRCLE;
    data['WARD'] = this.wARD;
    data['DRIVER_NAME'] = this.dRIVERNAME;
    data['DRIVER_MOBILE_NUMBER'] = this.dRIVERMOBILENUMBER;
    data['SUPERVISOR_NUMBER'] = this.sUPERVISORNUMBER;
    data['SUPERVISOR_NAME'] = this.sUPERVISORNAME;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    data['TICKET_UPDATED_ON'] = this.tICKETUPDATEDON;
    data['BEFORE_TRIP_IMAGE'] = this.bEFORETRIPIMAGE;
    data['PLANT_ID'] = this.pLANTID;
    return data;
  }
}