class MatchesModel{

  String? firstTeam;
  String? secondTeam;
  String? firstImage;
  String? date;
  String? score;
  String? secondImage;


  MatchesModel({
    this.firstTeam,
    this.secondTeam,
    this.firstImage,
    this.secondImage,
    this.date,
    this.score,
  });


  MatchesModel.fromJson(Map<String , dynamic> json){
    firstTeam=json['firstTeam'];
    secondTeam=json['secondTeam'];
    firstImage=json['firstImage'];
    secondImage=json['secondImage'];
    date=json['data'];
    score=json['score'];
  }

  Map <String , dynamic> toMap(){
    return{
      'fisrtTeam':firstTeam,
      'secondTeam':secondTeam,
      'firstImage':firstImage,
      'secondImage':secondImage,
      'data':date,
      'score':score,
    };
  }
}