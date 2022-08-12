class UserModel{

  String? uId;
  String ?username;
  String ?email;
  String ?phone;
  String ?bio;
  String ?image;
  String ?cover;
  String ?countryCode;


  UserModel({
    this.uId,
    this.username,
    this.email,
    this.phone,
    this.image,
    this.cover,
    this.bio,
    this.countryCode

  });

  UserModel.formJson( Map <String , dynamic> json ){
    username = json['username'];
    email=json['email'];
    uId=json['uId'];
    phone=json['phone'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    countryCode=json['countryCode'];

  }

  Map <String,dynamic> toMap(){
    return{
      'username':username,
      'email':email,
      'uId':uId,
      'phone':phone,
      'image':image,
      'cover':cover,
      'bio':bio,
      'countryCode':countryCode
    };
  }

}