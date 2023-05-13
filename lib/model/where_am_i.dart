class WhereAmIModel {
  String? wardId;
  String? wardName;
  String? circlename;
  String? zone;
  bool? status;

  WhereAmIModel(
      {this.wardId, this.wardName, this.circlename, this.zone, this.status});

  WhereAmIModel.fromJson(Map<String, dynamic> json) {
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
