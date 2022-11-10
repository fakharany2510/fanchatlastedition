class UserReportModel{

  String? senderReportId;
  String? senderReportName;
  String? senderReportImage;
  String? userId;
  String? userName;
  String? userImage;


  UserReportModel({
    this.senderReportId,
    this.senderReportName,
    this.senderReportImage,
    this.userId,
    this.userName,
    this.userImage,


  });


  UserReportModel.fromJson(Map<String , dynamic> json){
    senderReportId=json['senderReportId'];
    senderReportName=json['senderReportName'];
    senderReportImage=json['senderReportImage'];
    userId=json['userId'];
    userImage=json['userImage'];
    userName=json['userName'];
  }

  Map <String , dynamic> toMap(){
    return{
      'senderReportId':senderReportId,
      'senderReportName':senderReportName,
      'senderReportImage':senderReportImage,
      'userId':userId,
      'userImage':userImage,
      'userName':userName,
    };
  }
}