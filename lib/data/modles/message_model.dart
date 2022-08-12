class MessageModel{
  String? senderId;
  String? recevierId;
  String? dateTime;
  String? text;
  String? image;

  MessageModel({
   this.senderId,
    this.recevierId,
    this.dateTime,
    this.text,
    this.image
  });
  MessageModel.fromJson(Map<String , dynamic> json){
    senderId=json['senderId'];
    recevierId=json['recevierId'];
    dateTime=json['dateTime'];
    text=json['text'];
    image=json['image'];
  }

  Map <String , dynamic> toMap(){
    return{
      'senderId':senderId,
      'recevierId':recevierId,
      'dateTime':dateTime,
      'text':text,
      'image':image,
    };
  }
}