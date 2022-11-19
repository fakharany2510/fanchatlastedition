class Match {
  String? date;
  String? dayName;
  String? teamName;
  String? faceTeamName;
  String? manOfTheMatch;
  String? score;

  Match({
    this.date,
    this.dayName,
    this.teamName,
    this.faceTeamName,
    this.manOfTheMatch,
    this.score,
  });
  Match.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dayName = json['dayName'];
    teamName = json['TeamName'];
    faceTeamName = json['faceTeamName'];
    manOfTheMatch = json['manOfTheMatch'];
    score = json['scoor'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'dayName': dayName,
      'TeamName': teamName,
      'faceTeamName': faceTeamName,
      'manOfTheMatch': manOfTheMatch,
      'scoor': score
    };
  }
}
