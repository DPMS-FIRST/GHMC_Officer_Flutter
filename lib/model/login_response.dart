class ghmc_login {
  String? status;
  String? message;
  String? eMPD;
  String? eMPNAME;
  String? mOBILENO;
  String? dESIGNATION;
  String? tYPEID;
  String? mpin;
  String? otp;
  String? tOKENID;
  String? cATEGORY;
   String? roleId;
  String? ward;

  ghmc_login(
      {this.status,
      this.message,
      this.eMPD,
      this.eMPNAME,
      this.mOBILENO,
      this.dESIGNATION,
      this.tYPEID,
      this.mpin,
      this.otp,
      this.tOKENID,
      this.cATEGORY,
        this.roleId,
      this.ward
      });

  ghmc_login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    eMPD = json['EMP_D'];
    eMPNAME = json['EMP_NAME'];
    mOBILENO = json['MOBILE_NO'];
    dESIGNATION = json['DESIGNATION'];
    tYPEID = json['TYPE_ID'];
    mpin = json['mpin'];
    otp = json['otp'];
    tOKENID = json['TOKEN_ID'];
    cATEGORY = json['CATEGORY'];
      roleId = json['RoleID'];
    ward = json['Wardid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['EMP_D'] = this.eMPD;
    data['EMP_NAME'] = this.eMPNAME;
    data['MOBILE_NO'] = this.mOBILENO;
    data['DESIGNATION'] = this.dESIGNATION;
    data['TYPE_ID'] = this.tYPEID;
    data['mpin'] = this.mpin;
    data['otp'] = this.otp;
    data['TOKEN_ID'] = this.tOKENID;
    data['CATEGORY'] = this.cATEGORY;
     data['RoleID'] = this.roleId;
    data['Wardid'] = this.ward;
    return data;
  }
}