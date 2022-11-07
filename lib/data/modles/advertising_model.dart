class AdvertisingModel{

  String ?advertisingLink;
  String? dateTime;
  String? postImage;
  String? postVideo;
  String? advertiseThumbnail;
  String? time;
  String? timeSmap;

  AdvertisingModel({

    this.advertisingLink,
    this.dateTime,
    this.postImage,
    this.postVideo,
    this.time,
    this.timeSmap,
    this.advertiseThumbnail
  });

  AdvertisingModel.formJson( Map <String , dynamic> json ){
    advertisingLink = json['advertisingLink'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
    postVideo=json['postVideo'];
    advertiseThumbnail=json['advertiseThumbnail'];
    time=json['time'];
    timeSmap=json['timeSmap'];
  }

  Map <String,dynamic> toMap(){
    return{
      'advertisingLink':advertisingLink,
      'dateTime':dateTime,
      'postImage':postImage,
      'postVideo':postVideo,
      'advertiseThumbnail':advertiseThumbnail,
      'time':time,
      'timeSmap':timeSmap,
    };
  }

}