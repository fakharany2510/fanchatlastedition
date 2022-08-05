class BrowisePostModel{
  String? userId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postVideo;
  BrowisePostModel({
    this.userId,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postVideo
  });
  BrowisePostModel.fromJson(Map<String , dynamic> json){
    userId=json['userId'];
    name=json['name'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    postImage=json['postImage'];
    postVideo=json['postVideo'];
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
    };
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Post {
//   String? userId;
//   String? name;
//   String? image;
//   String? dateTime;
//   String? text;
//   String? postImage;
//   String? postVideo;
//
//   Post({
//     this.userId,
//     this.name,
//     this.image,
//     this.dateTime,
//     this.text,
//     this.postImage,
//     this.postVideo
//   });
//   factory Post.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data()  as Map;
//     return Post(
//       userId: data['userId'],
//       name: data['name'],
//       image: data['image'],
//       dateTime: data['dateTime'],
//       text: data['text'],
//       postImage: data['postImage'],
//       postVideo: data['postVideo'],
//     );
//   }
// }