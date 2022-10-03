class AdvertisingModel{


  String ?advertisingImage;
  String ?advertisingLink;

  AdvertisingModel({

    this.advertisingImage,
    this.advertisingLink,

  });

  AdvertisingModel.formJson( Map <String , dynamic> json ){
    advertisingImage = json['advertisingImage'];
    advertisingLink = json['advertisingLink'];

  }

  Map <String,dynamic> toMap(){
    return{
      'advertisingImage':advertisingImage,
      'advertisingLink':advertisingLink,
    };
  }

}