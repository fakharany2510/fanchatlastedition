class UserModel{
  String? uId;
  String ?username;
  String ?email;
  String ?phone;
  String ?bio;
  String ?image;
  String ?cover;
  String ?countryCode;
  String ?youtubeLink;
  String ?facebookLink;
  String ?twitterLink;
  String ?instagramLink;
  bool ?accountActive ;


  UserModel({
    this.uId,
    this.username,
    this.email,
    this.phone,
    this.image,
    this.cover,
    this.bio,
    this.countryCode,
    this.facebookLink,
    this.instagramLink,
    this.twitterLink,
    this.youtubeLink,
    this.accountActive

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
    accountActive=json['accountActive'];
    youtubeLink=json['youtubeLink'];
    twitterLink=json['twitterLink'];
    facebookLink=json['facebookLink'];
    instagramLink=json['instagramLink'];

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
      'countryCode':countryCode,
      'accountActive':accountActive,
      'facebookLink':facebookLink,
      'youtubeLink':youtubeLink,
      'twitterLink':twitterLink,
      'instagramLink':instagramLink,
    };
  }

}