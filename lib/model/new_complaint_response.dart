class NewComplaintResponse {
  String? id;
  String? type;
  String? status;

  NewComplaintResponse({this.id, this.type, this.status});

  NewComplaintResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}
