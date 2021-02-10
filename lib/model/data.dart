import 'package:bluestacks_assignment/model/tournament.dart';

class Data {
  String cursor;
  List<Tournament> tournaments;
  bool isLastBatch;

  Data({this.cursor, this.tournaments, this.isLastBatch});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        cursor: json['cursor'],
        tournaments: _createTournamentList(json),
        isLastBatch: json['is_last_batch']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cursor'] = this.cursor;
    if (this.tournaments != null) {
      data['tournaments'] = this.tournaments.map((v) => v.toJson()).toList();
    }
    data['is_last_batch'] = this.isLastBatch;
    return data;
  }

  static List<Tournament> _createTournamentList(Map<String, dynamic> json) {
    if(json['tournaments'] != null) {
      List<Tournament> list = new List();
      json['tournaments'].forEach((v) {
        list.add(new Tournament.fromJson(v));
      });
      return list;
    }
    return null;
  }
}
