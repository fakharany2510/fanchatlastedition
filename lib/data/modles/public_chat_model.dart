

class PublicChatModel{
  String? senderId;
  String? senderName;
  String? senderImage;
  String? dateTime;
  String? text;
  String? image;
  String? voice;

  PublicChatModel({
    this.senderId,
    this.senderImage,
    this.senderName,
    this.dateTime,
    this.text,
    this.image,
    this.voice
  });
  PublicChatModel.fromJson(Map<String , dynamic> json){
    senderId=json['senderId'];
    senderName=json['senderName'];
    senderImage=json['senderImage'];
    dateTime=json['dateTime'];
    text=json['text'];
    image=json['image'];
    voice=json['voice'];
  }

  Map <String , dynamic> toMap(){
    return{
      'senderId':senderId,
      'dateTime':dateTime,
      'text':text,
      'image':image,
      'voice':voice,
      'senderImage':senderImage,
      'senderName':senderName
    };
  }
}