class CheeringModel{

  String? uId;
  String ?username;
  String ?userImage;
  String ?text;
  String ?time;
  String ?timeSpam;



  CheeringModel({

    this.uId,
    this.username,
    this.text,
    this.userImage,
    this.time,
    this.timeSpam

  });

  CheeringModel.formJson( Map <String , dynamic> json ){
    username = json['username'];
    timeSpam=json['timeSpam'];
    uId=json['uId'];
    userImage=json['userImage'];
    time=json['time'];
    text=json['text'];

  }

  Map <String,dynamic> toMap(){
    return{
      'username':username,
      'timeSpam':timeSpam,
      'uId':uId,
      'userImage':userImage,
      'time':time,
      'text':text,
    };
  }

}