import 'package:dio/dio.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';

class ResponseModel {
  int? statusCode;
  Response? response;

  ResponseModel({this.statusCode, this.response});

  dynamic get data => response?.data;

  String? get message => response?.data?['msg']?.toString();

  bool get isSuccess => response!.statusCode! >= 200 && response!.statusCode! <= 299 && response!.data['code']!.toString().toInt() >= 200 && response!.data['code']!.toString().toInt() <= 299;

  dynamic getExtraData(String paramName) {
    return response!.data[paramName];
  }
}
