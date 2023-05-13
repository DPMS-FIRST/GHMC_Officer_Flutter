class InsertGrievanceResponse {
  String? compid;
  String? empName;
  String? empName1;
  String? status;
  String? Message;

  InsertGrievanceResponse(
      {this.compid, this.empName, this.empName1, this.status});

  InsertGrievanceResponse.fromJson(Map<String, dynamic> json) {
    compid = json['compid'];
    empName = json['EmpName'];
    empName1 = json['EmpName1'];
    status = json['status'];
    status = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compid'] = this.compid;
    data['EmpName'] = this.empName;
    data['EmpName1'] = this.empName1;
    data['status'] = this.status;
    data['Message'] = this.Message;
    return data;
  }
}
