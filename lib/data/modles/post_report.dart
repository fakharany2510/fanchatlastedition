class PostReportModel{

  String? reportType;
  String? senderReport;
  String? postOwner;
  String? postId;
  String? postText;
  String? postImage;
  String? postVideo;


  PostReportModel({
    this.reportType,
    this.senderReport,
    this.postOwner,
    this.postId,
    this.postText,
    this.postImage,
    this.postVideo,
  });


  PostReportModel.fromJson(Map<String , dynamic> json){
    reportType=json['reportType'];
    senderReport=json['senderReport'];
    postOwner=json['postOwner'];
    postId=json['postId'];
    postText=json['postText'];
    postImage=json['postImage'];
    postVideo=json['postVideo'];
  }

  Map <String , dynamic> toMap(){
    return{
      'reportType':reportType,
      'senderReport':senderReport,
      'postOwner':postOwner,
      'postId':postId,
      'postText':postText,
      'postImage':postImage,
      'postVideo':postVideo,
    };
  }
}