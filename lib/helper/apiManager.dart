import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task_flutter/repository/api.dart';
import 'package:task_flutter/utils/constant.dart';

class APIManager extends Api {
  Future<dynamic> postAPICall(url, {Map? body}) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;
    try {
      final response = await http.post(URL,
          body: jsonEncode(body), headers: await getHeaders());
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(url) async {
    final URL = Uri.parse('${Constants.URL}$url');
    var responseJson;
    try {
      final response = await http.get(URL, headers: await getHeaders());
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteAPICall(url) async {
    final URL = Uri.parse('${Constants.URL}$url');
    var responseJson;
    try {
      final response = await http.delete(URL, headers: await getHeaders());
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}

bool isValidUrl(String url) {
  Uri uri = Uri.tryParse(url) ?? Uri();
  return uri.scheme.isNotEmpty && uri.host.isNotEmpty;
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
