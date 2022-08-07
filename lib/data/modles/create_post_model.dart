class BrowisePostModel{
  String? userId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postVideo;
  String? time;
  String? timeSmap;

  BrowisePostModel({
    this.userId,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postVideo,
    this.time,
    this.timeSmap
  });
  BrowisePostModel.fromJson(Map<String , dynamic> json){
    userId=json['userId'];
    name=json['name'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    postImage=json['postImage'];
    postVideo=json['postVideo'];
    time=json['time'];
    timeSmap=json['timeSmap'];
  }

  Map <String , dynamic> toMap(){
    return{
      'userId':userId,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
      'postVideo':postVideo,
      'time':time,
      'timeSmap':timeSmap,

    };
  }
}