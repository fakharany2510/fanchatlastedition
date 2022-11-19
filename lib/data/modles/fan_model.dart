class FanModel {
  String? userId;
  String? name;
  String? image;
  String? dateTime;
  String? postImage;
  String? thumbnailFanPosts;
  String? postVideo;
  String? time;
  String? timeSmap;
  int? likes = 0;
  String? postId;
  FanModel(
      {this.userId,
      this.name,
      this.image,
      this.dateTime,
      this.postImage,
      this.thumbnailFanPosts,
      this.postVideo,
      this.time,
      this.timeSmap,
      this.likes,
      this.postId});
  FanModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    thumbnailFanPosts = json['thumbnailFanPosts'];
    postVideo = json['postVideo'];
    time = json['time'];
    timeSmap = json['timeSmap'];
    likes = json['likes'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'thumbnailFanPosts': thumbnailFanPosts,
      'postVideo': postVideo,
      'time': time,
      'timeSmap': timeSmap,
      'likes': likes,
      'postId': postId,
    };
  }
}
