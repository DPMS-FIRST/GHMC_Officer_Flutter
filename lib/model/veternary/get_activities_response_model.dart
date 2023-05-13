class VgetActivitiesResponseModel {
  int? statusCode;
  String? statusMessage;
  List<Activities>? activities;

  VgetActivitiesResponseModel(
      {this.statusCode, this.statusMessage, this.activities});

  VgetActivitiesResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    statusMessage = json['StatusMessage'];
    if (json['Activities'] != null) {
      activities = <Activities>[];
      json['Activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['StatusMessage'] = this.statusMessage;
    if (this.activities != null) {
      data['Activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  int? activityId;
  String? activityName;

  Activities({this.activityId, this.activityName});

  Activities.fromJson(Map<String, dynamic> json) {
    activityId = json['Activity_Id'];
    activityName = json['Activity_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Activity_Id'] = this.activityId;
    data['Activity_Name'] = this.activityName;
    return data;
  }
}
