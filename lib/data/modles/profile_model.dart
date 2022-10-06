class ProfileModel{
  String? userId;
  String? name;
  String? image;
  String? dateTime;
  String? postImage;
  String? postVideo;
  String? time;
  String? timeSmap;
  int ?likes=0;
  String ?postId;
  ProfileModel({
    this.userId,
    this.name,
    this.image,
    this.dateTime,
    this.postImage,
    this.postVideo,
    this.time,
    this.timeSmap,
    this.likes,
    this.postId

  });
  ProfileModel.fromJson(Map<String , dynamic> json){
    userId=json['userId'];
    name=json['name'];
    image=json['image'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
    postVideo=json['postVideo'];
    time=json['time'];
    timeSmap=json['timeSmap'];
    likes=json['likes'];
    postId=json['postId'];


  }

  Map <String , dynamic> toMap(){
    return{
      'userId':userId,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'postImage':postImage,
      'postVideo':postVideo,
      'time':time,
      'timeSmap':timeSmap,
      'likes':likes,
      'postId':postId,

    };
  }
}