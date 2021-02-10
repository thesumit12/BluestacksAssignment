class User {
  User(
      {this.userId,
      this.userName,
      this.displayName,
      this.imageUrl,
      this.rating,
      this.tournamentPlayed,
      this.tournamentWon,
      this.winningPercent});

  User.userId({this.userId});

  String userId;
  String userName;
  String displayName;
  String imageUrl;
  String rating;
  String tournamentPlayed;
  String tournamentWon;
  String winningPercent;

  factory User.fromJson(String userId, Map<String, dynamic> json) {
    return User(
        userId: userId,
        userName: json['username'],
        displayName: json['display_name'],
        imageUrl: json['avatar_url'],
        rating: json['rating'],
        tournamentPlayed: json['t_played'],
        tournamentWon: json['t_won'],
        winningPercent: json['t_percent']);
  }
}
