// class BrowisePostModel{
//   String? userId;
//   String? name;
//   String? image;
//   String? dateTime;
//   String? text;
//   String? postImage;
//   String? postVideo;
//   BrowisePostModel({
//     this.userId,
//     this.name,
//     this.image,
//     this.dateTime,
//     this.text,
//     this.postImage,
//     this.postVideo
//   });
//   BrowisePostModel.fromJson(Map<String , dynamic> json){
//     userId=json['userId'];
//     name=json['name'];
//     image=json['image'];
//     dateTime=json['dateTime'];
//     text=json['text'];
//     postImage=json['postImage'];
//     postVideo=json['postVideo'];
//   }
//
//   Map <String , dynamic> toMap(){
//     return{
//       'userId':userId,
//       'name':name,
//       'image':image,
//       'dateTime':dateTime,
//       'text':text,
//       'postImage':postImage,
//       'postVideo':postVideo,
//     };
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? userId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postVideo;
  String? time;
  String? timeSmap;
  // List ?likes;

  PostModel({
    this.userId,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postVideo,
    this.time,
    this.timeSmap,
    // this.likes
  });
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
      // 'likes':likes!.toList(),

    };
   }
  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data()  as Map;
    return PostModel(
      userId: data['userId'],
      name: data['name'],
      image: data['image'],
      dateTime: data['dateTime'],
      text: data['text'],
      postImage: data['postImage'],
      postVideo: data['postVideo'],
      time: data['time'],
      timeSmap: data['timeSmap'],
      // likes: data['likes'],
    );
  }
}