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
  bool ?advertise ;
  bool ?premium ;
  DateTime? buyDate;
  DateTime? trialStartDate;
  int? numberOfPosts;
  bool? payed;
  int? days;

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
    this.accountActive,
    this.advertise,
    this.premium,
    this.numberOfPosts,
    this.payed,
    this.days,
    this.buyDate,
    this.trialStartDate,

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
    accountActive=json['advertise'];
    accountActive=json['business'];
    youtubeLink=json['youtubeLink'];
    twitterLink=json['twitterLink'];
    facebookLink=json['facebookLink'];
    instagramLink=json['instagramLink'];
    numberOfPosts=json['numberOfPosts'];
    payed=json['payed'];
    premium=json['premium'];
    advertise=json['advertise'];
    days=json['days'];
    buyDate=json['buyDate'];
    trialStartDate=json['trialStartDate'];

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
      'advertise':advertise,
      'premium':premium,
      'facebookLink':facebookLink,
      'youtubeLink':youtubeLink,
      'twitterLink':twitterLink,
      'instagramLink':instagramLink,
      'numberOfPosts':numberOfPosts,
      'payed':payed,
      'days':days,
      'buyDate':buyDate,
      'trialStartDate':trialStartDate,
    };
  }

}