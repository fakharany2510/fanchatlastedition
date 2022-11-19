class MatchesModel{

  String? firstTeam;
  String? secondTeam;
  String? firstImage;
  String? date;
  String? score;
  String? secondImage;
  int? clock;


  MatchesModel({
    this.firstTeam,
    this.secondTeam,
    this.firstImage,
    this.secondImage,
    this.date,
    this.score,
    this.clock,
  });


  MatchesModel.fromJson(Map<String , dynamic> json){
    firstTeam=json['firstTeam'];
    secondTeam=json['secondTeam'];
    firstImage=json['firstImage'];
    secondImage=json['secondImage'];
    date=json['data'];
    score=json['score'];
    clock=json['clock'];
  }

  Map <String , dynamic> toMap(){
    return{
      'fisrtTeam':firstTeam,
      'secondTeam':secondTeam,
      'firstImage':firstImage,
      'secondImage':secondImage,
      'data':date,
      'score':score,
      'clock':clock,
    };
  }
}