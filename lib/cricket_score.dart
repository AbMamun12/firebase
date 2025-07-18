class CricketScore {
  final String matchId;
  final String teamOne;
  final String teamTwo;
  final int teamOneScore;
  final int teamTwoScore;
  final bool isMatchRunning;
  final String winnerTeam;

  CricketScore({
    required this.matchId,
    required this.teamOne,
    required this.teamTwo,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.isMatchRunning,
    required this.winnerTeam,
  });

  factory CricketScore.fromJson(String id,Map<String, dynamic> json) {
    return CricketScore(
      matchId: id,
      teamOne: json['teamOne'],
      teamTwo: json['teamTwo'],
      teamOneScore: json['teamOneScore'],
      teamTwoScore: json['teamTwoScore'],
      isMatchRunning: json['isMatchRunning'],
      winnerTeam: json['winnerTeam'],
    );
  }
}
