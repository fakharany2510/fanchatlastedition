class AdvertisingModel{

  String ?advertisingLink;
  String? dateTime;
  String? postImage;
  String? postVideo;
  String? time;
  String? timeSmap;

  AdvertisingModel({

    this.advertisingLink,
    this.dateTime,
    this.postImage,
    this.postVideo,
    this.time,
    this.timeSmap,
  });

  AdvertisingModel.formJson( Map <String , dynamic> json ){
    advertisingLink = json['advertisingLink'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
    postVideo=json['postVideo'];
    time=json['time'];
    timeSmap=json['timeSmap'];
  }

  Map <String,dynamic> toMap(){
    return{
      'advertisingLink':advertisingLink,
      'dateTime':dateTime,
      'postImage':postImage,
      'postVideo':postVideo,
      'time':time,
      'timeSmap':timeSmap,
    };
  }

}