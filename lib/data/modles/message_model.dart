

class MessageModel{
  String? senderId;
  String? recevierId;
  String? recevierName;
  String? recevierImage;
  String? dateTime;
  String? text;
  String? image;
  String? voice;
  String? video;


  MessageModel({
   this.senderId,
    this.recevierId,
    this.recevierImage,
    this.recevierName,
    this.dateTime,
    this.text,
    this.image,
    this.voice,
    this.video
  });
  MessageModel.fromJson(Map<String , dynamic> json){
    senderId=json['senderId'];
    recevierId=json['recevierId'];
    recevierImage=json['recevierImage'];
    recevierName=json['recevierName'];
    dateTime=json['dateTime'];
    text=json['text'];
    image=json['image'];
    voice=json['voice'];
    video=json['video'];
  }

  Map <String , dynamic> toMap(){
    return{
      'senderId':senderId,
      'recevierId':recevierId,
      'recevierImage':recevierImage,
      'recevierName':recevierName,
      'dateTime':dateTime,
      'text':text,
      'image':image,
      'voice':voice,
      'video':video,
    };
  }
}