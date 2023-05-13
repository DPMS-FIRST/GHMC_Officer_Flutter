class WhereAmIResponse {
  String? wardId;
  String? wardName;
  String? circlename;
  String? zone;
  bool? status;

  WhereAmIResponse(
      {this.wardId, this.wardName, this.circlename, this.zone, this.status});

  WhereAmIResponse.fromJson(Map<String, dynamic> json) {
    wardId = json['ward_id'];
    wardName = json['ward_name'];
    circlename = json['circlename'];
    zone = json['Zone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ward_id'] = this.wardId;
    data['ward_name'] = this.wardName;
    data['circlename'] = this.circlename;
    data['Zone'] = this.zone;
    data['status'] = this.status;
    return data;
  }
}
