class UpdateMpinResponse {
  String? tag;
  bool? status;

  UpdateMpinResponse({this.tag, this.status});

  UpdateMpinResponse.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['status'] = this.status;
    return data;
  }
}
