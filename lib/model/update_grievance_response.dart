class UpdateGrievanceResponse {
  String? compid;
  String? status;

  UpdateGrievanceResponse({this.compid, this.status});

  UpdateGrievanceResponse.fromJson(Map<String, dynamic> json) {
    compid = json['compid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compid'] = this.compid;
    data['status'] = this.status;
    return data;
  }
}