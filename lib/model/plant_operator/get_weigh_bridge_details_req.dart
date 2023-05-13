class WeighBridgeDetailsReq {
  String? tRANSACTIONNO;
  String? vEHICLENO;
  String? tICKETID;
  String? tOKENID;

  WeighBridgeDetailsReq(
      {this.tRANSACTIONNO, this.vEHICLENO, this.tICKETID, this.tOKENID});

  WeighBridgeDetailsReq.fromJson(Map<String, dynamic> json) {
    tRANSACTIONNO = json['TRANSACTION_NO'];
    vEHICLENO = json['VEHICLE_NO'];
    tICKETID = json['TICKET_ID'];
    tOKENID = json['TOKEN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TRANSACTION_NO'] = this.tRANSACTIONNO;
    data['VEHICLE_NO'] = this.vEHICLENO;
    data['TICKET_ID'] = this.tICKETID;
    data['TOKEN_ID'] = this.tOKENID;
    return data;
  }
}