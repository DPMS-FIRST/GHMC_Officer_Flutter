class ShowNotificationResponse {
  String? sno;
  String? title;
  String? msg;
  String? isimage;
  String? imageurl;
  String? status;
  String? timestamp;

  ShowNotificationResponse(
      {this.sno,
      this.title,
      this.msg,
      this.isimage,
      this.imageurl,
      this.status,
      this.timestamp});

  ShowNotificationResponse.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    title = json['title'];
    msg = json['msg'];
    isimage = json['isimage'];
    imageurl = json['imageurl'];
    status = json['status'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['title'] = this.title;
    data['msg'] = this.msg;
    data['isimage'] = this.isimage;
    data['imageurl'] = this.imageurl;
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
