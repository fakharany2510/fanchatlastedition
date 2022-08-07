class CommentModel{
  String? username;
  String? userId;
  String? userImage;
  String? comment;
  String? date;


  CommentModel({
    this.username,
    this.userId,
    this.userImage,
    this.comment,
    this.date,

  });

  CommentModel.fromFire(Map <String , dynamic> fire ){
    username = fire['username'];
    userId = fire['userId'];
    userImage = fire['userImage'];
    comment = fire['comment'];
    date = fire['date'];

  }


  Map <String , dynamic> toMap () {
    return {
      'username': username,
      'userId': userId,
      'userImage': userImage,
      'comment': comment,
      'date': date
    };
  }
  }