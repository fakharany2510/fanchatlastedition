class BrowisePostModel{
  String? userId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postVideo;
  String? thumbnail;
  String? time;
  String? timeSmap;
  int ?likes=0;
  int ?comments =0;
  String ?postId;

  BrowisePostModel({
    this.userId,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postVideo,
    this.thumbnail,
    this.time,
    this.timeSmap,
    this.likes,
    this.comments,
    this.postId
  });
  BrowisePostModel.fromJson(Map<String , dynamic> json){
    userId=json['userId'];
    name=json['name'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    postImage=json['postImage'];
    postVideo=json['postVideo'];
    thumbnail=json['thumbnail'];
    time=json['time'];
    timeSmap=json['timeSmap'];
    likes=json['likes'];
    comments=json['comments'];
    postId=json['postId'];

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
      'thumbnail':thumbnail,
      'time':time,
      'timeSmap':timeSmap,
      'likes':likes,
      'comments':comments,
      'postId':postId,
    };
  }
}