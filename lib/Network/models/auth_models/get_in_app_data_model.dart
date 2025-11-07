import 'package:json_annotation/json_annotation.dart';

part 'get_in_app_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetInAppDataModel {
  String? code;
  String? msg;
  List<InAppData>? data;

  GetInAppDataModel({
    this.code,
    this.msg,
    this.data,
  });

  factory GetInAppDataModel.fromJson(Map<String, dynamic> json) => _$GetInAppDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetInAppDataModelToJson(this);

  GetInAppDataModel copyWith({
    String? code,
    String? msg,
    List<InAppData>? data,
  }) {
    return GetInAppDataModel(
      code: code ?? this.code,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable()
class InAppData {
  String? inAppUpdateId;
  String? appUrl;
  String? iosUrl;
  String? appVersion;
  String? createdDate;

  InAppData({
    this.inAppUpdateId,
    this.appUrl,
    this.iosUrl,
    this.appVersion,
    this.createdDate,
  });

  factory InAppData.fromJson(Map<String, dynamic> json) => _$InAppDataFromJson(json);

  Map<String, dynamic> toJson() => _$InAppDataToJson(this);

  InAppData copyWith({
    String? inAppUpdateId,
    String? appUrl,
    String? iosUrl,
    String? appVersion,
    String? createdDate,
  }) {
    return InAppData(
      inAppUpdateId: inAppUpdateId ?? this.inAppUpdateId,
      appUrl: appUrl ?? this.appUrl,
      iosUrl: iosUrl ?? this.iosUrl,
      appVersion: appVersion ?? this.appVersion,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}
