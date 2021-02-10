import 'dart:convert';
import 'dart:io';

import 'package:bluestacks_assignment/networking/custom_exception.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl =
      "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        //print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException('unknown_error'
            .tr(namedArgs: {'statusCode': '${response.statusCode}'}));
    }
  }
}
