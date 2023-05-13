class ConcessionairePickupCaptureBindPlantNameRes {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<PLANTDTLS>? pLANTDTLS;

  ConcessionairePickupCaptureBindPlantNameRes(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.pLANTDTLS});

  ConcessionairePickupCaptureBindPlantNameRes.fromJson(
      Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['PLANTDTLS'] != null) {
      pLANTDTLS = <PLANTDTLS>[];
      json['PLANTDTLS'].forEach((v) {
        pLANTDTLS!.add(new PLANTDTLS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.pLANTDTLS != null) {
      data['PLANTDTLS'] = this.pLANTDTLS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PLANTDTLS {
  String? pLANTID;
  String? pLANTNAME;

  PLANTDTLS({this.pLANTID, this.pLANTNAME});

  PLANTDTLS.fromJson(Map<String, dynamic> json) {
    pLANTID = json['PLANT_ID'];
    pLANTNAME = json['PLANT_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PLANT_ID'] = this.pLANTID;
    data['PLANT_NAME'] = this.pLANTNAME;
    return data;
  }
}
