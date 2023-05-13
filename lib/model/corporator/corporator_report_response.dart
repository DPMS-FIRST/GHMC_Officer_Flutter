class CorporatorReportResponse {
  String? filePath;
  String? status;
  String? fileName;
  String? status_Desc;
  String? tag;

  CorporatorReportResponse({this.filePath, this.status, this.fileName});

  CorporatorReportResponse.fromJson(Map<String, dynamic> json) {
    filePath = json['FilePath'];
    status = json['status'];
    fileName = json['fileName'];
    status_Desc = json['status_Desc'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FilePath'] = this.filePath;
    data['status'] = this.status;
    data['fileName'] = this.fileName;
    data['status_Desc'] = this.status_Desc;
    data['tag'] = this.tag;
    return data;
  }
}