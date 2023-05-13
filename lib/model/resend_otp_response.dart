class ResendOtpModel {
  String? otp;
  bool? status;

  ResendOtpModel({this.otp, this.status});

  ResendOtpModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['status'] = this.status;
    return data;
  }
}