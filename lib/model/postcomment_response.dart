class PostCommentResponse {
  String? compid;
  String? status;

  PostCommentResponse({this.compid, this.status});

  PostCommentResponse.fromJson(Map<String, dynamic> json) {
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
