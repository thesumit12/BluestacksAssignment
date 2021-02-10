
class Tournament {
  Tournament({this.tournamentName, this.coverUrl, this.gameName});
  String tournamentName;
  String coverUrl;
  String gameName;

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      tournamentName: json['name'],
      coverUrl: json['cover_url'],
      gameName: json['game_name']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.tournamentName;
    data['cover_url'] = this.coverUrl;
    data['game_name'] = this.gameName;

    return data;
  }
}