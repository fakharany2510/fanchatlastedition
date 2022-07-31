
class UserModel{

  String? uId;
  String ?username;
  String ?email;
  String ?phone;
  String ?bio;
  String ?image;
  String ?video;
  String ?cover;




  UserModel({
    this.uId,
    this.username,
    this.email,
    this.phone,
    this.image,
    this.cover,
    this.video,
    this.bio

  });

  UserModel.formJson( Map <String , dynamic> json ){
    username = json['username'];
    email=json['email'];
    uId=json['uId'];
    phone=json['phone'];
    image=json['image'];
    cover=json['cover'];
    video=json['video'];
    bio=json['bio'];
  }

  Map <String,dynamic> toMap(){
    return{
      'username':username,
      'email':email,
      'uId':uId,
      'phone':phone,
      'image':image,
      'cover':cover,
      'video':video,
      'bio':bio,
    };
  }

}

