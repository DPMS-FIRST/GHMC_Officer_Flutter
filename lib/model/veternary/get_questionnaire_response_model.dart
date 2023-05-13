class GetQuestionnaireResponseModel {
  int? statusCode;
  String? statusMessage;
  List<Questions>? questions;

  GetQuestionnaireResponseModel(
      {this.statusCode, this.statusMessage, this.questions});

  GetQuestionnaireResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    statusMessage = json['StatusMessage'];
    if (json['Questions'] != null) {
      questions = <Questions>[];
      json['Questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['StatusMessage'] = this.statusMessage;
    if (this.questions != null) {
      data['Questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? questionId;
  String? questionName;
  String? questionType;
  String? isImage;
  String? inputType;
  String? maxLength;

  Questions(
      {this.questionId,
      this.questionName,
      this.questionType,
      this.isImage,
      this.inputType,
      this.maxLength});

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['Question_Id'];
    questionName = json['Question_Name'];
    questionType = json['Question_Type'];
    isImage = json['Is_Image'];
    inputType = json['Input_Type'];
    maxLength = json['Max_Length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Question_Id'] = this.questionId;
    data['Question_Name'] = this.questionName;
    data['Question_Type'] = this.questionType;
    data['Is_Image'] = this.isImage;
    data['Input_Type'] = this.inputType;
    data['Max_Length'] = this.maxLength;
    return data;
  }
}
