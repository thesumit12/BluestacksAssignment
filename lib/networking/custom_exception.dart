import 'package:easy_localization/easy_localization.dart';

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "error_communication".tr());
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "invalid_request".tr());
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "unauthorised".tr());
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message])
      : super(message, "invalid_input".tr());
}
