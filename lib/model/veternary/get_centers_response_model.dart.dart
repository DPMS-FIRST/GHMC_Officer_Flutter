class getCentersResponseModel {
  int? statusCode;
  String? statusMessage;
  List<Centers>? centers;

  getCentersResponseModel({this.statusCode, this.statusMessage, this.centers});

  getCentersResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    statusMessage = json['StatusMessage'];
    if (json['Centers'] != null) {
      centers = <Centers>[];
      json['Centers'].forEach((v) {
        centers!.add(new Centers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['StatusMessage'] = this.statusMessage;
    if (this.centers != null) {
      data['Centers'] = this.centers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Centers {
  int? centerId;
  String? centerName;

  Centers({this.centerId, this.centerName});

  Centers.fromJson(Map<String, dynamic> json) {
    centerId = json['Center_Id'];
    centerName = json['Center_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Center_Id'] = this.centerId;
    data['Center_Name'] = this.centerName;
    return data;
  }
}
