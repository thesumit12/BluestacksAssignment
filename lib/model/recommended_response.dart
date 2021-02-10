import 'package:bluestacks_assignment/model/data.dart';

class RecommendedResponse {
  int code;
  Data data;
  bool success;

  RecommendedResponse({this.code, this.data, this.success});

  factory RecommendedResponse.fromJson(Map<String, dynamic> json) {
    return RecommendedResponse(
        code: json['code'],
        data: json['data'] != null ? new Data.fromJson(json['data']) : null,
        success: json['success']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}
