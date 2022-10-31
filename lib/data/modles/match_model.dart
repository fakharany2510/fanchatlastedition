class Match{
  String? date;
  String? dayName;
  String? TeamName;
  String? faceTeamName;
  String? manOfTheMatch;
  String? scoor;

  Match({
     this.date,
     this.dayName,
     this.TeamName,
     this.faceTeamName,
     this.manOfTheMatch,
     this.scoor,
});
  Match.fromJson(Map<String,dynamic> json){
    date          = json['date'];
    dayName       = json['dayName'];
    TeamName      = json['TeamName'];
    faceTeamName  = json['faceTeamName'];
    manOfTheMatch = json['manOfTheMatch'];
    scoor         = json['scoor'];

  }

  Map<String,dynamic> toMap(){
    return{
      'date'         : date,
      'dayName'      : dayName,
      'TeamName'     : TeamName,
      'faceTeamName' : faceTeamName,
      'manOfTheMatch': manOfTheMatch,
      'scoor'        : scoor

    };
  }
}