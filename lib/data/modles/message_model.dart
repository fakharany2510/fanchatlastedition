

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
  String? privateChatSumbnail;


  MessageModel({
   this.senderId,
    this.recevierId,
    this.recevierImage,
    this.recevierName,
    this.dateTime,
    this.text,
    this.image,
    this.voice,
    this.video,
    this.privateChatSumbnail,
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
    privateChatSumbnail=json['privateChatSumbnail'];
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
      'privateChatSumbnail':privateChatSumbnail,
    };
  }
}