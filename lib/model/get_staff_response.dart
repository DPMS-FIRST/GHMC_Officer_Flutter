class GetStaff {
  String? tag;
  bool? status;
 

  GetStaff({this.tag, this.status,});

  GetStaff.fromJson(Map<String, dynamic> json) {
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