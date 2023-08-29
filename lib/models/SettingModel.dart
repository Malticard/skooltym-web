import 'dart:convert';

List<SettingsModel> settingsModelFromJson(String str) =>
    List<SettingsModel>.from(
        json.decode(str).map((x) => SettingsModel.fromJson(x)));

String settingsModelToJson(List<SettingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingsModel {
  SettingsModel({
    required this.id,
    required this.schoolId,
    required this.dropOffStartTime,
    required this.dropOffEndTime,
    required this.dropOffAllowance,
    required this.pickUpStartTime,
    required this.pickUpEndTime,
    required this.pickUpAllowance,
    required this.allowOvertime,
    required this.overtimeRate,
    required this.overtimeRateCurrency,
    required this.overtimeInterval,
    required this.isComplete,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.halfDayPickUpAllowance,
    required this.halfDayPickUpEndTime,
    required this.halfDayPickUpStartTime,
  });

  final String id;
  final String schoolId;
  final String dropOffStartTime;
  final String dropOffEndTime;
  final String dropOffAllowance;
  final String pickUpStartTime;
  final String pickUpEndTime;
  final String pickUpAllowance;
  final bool allowOvertime;
  final int overtimeRate;
  final String overtimeRateCurrency;
  final String overtimeInterval;
  final bool isComplete;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String halfDayPickUpAllowance;
  final String halfDayPickUpEndTime;
  final String halfDayPickUpStartTime;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        id: json["_id"],
        schoolId: json["school_id"],
        dropOffStartTime: json["drop_off_start_time"],
        dropOffEndTime: json["drop_off_end_time"],
        dropOffAllowance: json["drop_off_allowance"],
        pickUpStartTime: json["pick_up_start_time"],
        pickUpEndTime: json["pick_up_end_time"],
        pickUpAllowance: json["pick_up_allowance"],
        allowOvertime: json["allow_overtime"],
        overtimeRate: json["overtime_rate"],
        overtimeRateCurrency: json["overtime_rate_currency"],
        overtimeInterval: json["overtime_interval"],
        isComplete: json["isComplete"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        halfDayPickUpAllowance: json["halfDay_pick_up_allowance"],
        halfDayPickUpEndTime: json["halfDay_pick_up_end_time"],
        halfDayPickUpStartTime: json["halfDay_pick_up_start_time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "school_id": schoolId,
        "drop_off_start_time": dropOffStartTime,
        "drop_off_end_time": dropOffEndTime,
        "drop_off_allowance": dropOffAllowance,
        "pick_up_start_time": pickUpStartTime,
        "pick_up_end_time": pickUpEndTime,
        "pick_up_allowance": pickUpAllowance,
        "allow_overtime": allowOvertime,
        "overtime_rate": overtimeRate,
        "overtime_rate_currency": overtimeRateCurrency,
        "overtime_interval": overtimeInterval,
        "isComplete": isComplete,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "halfDay_pick_up_allowance": halfDayPickUpAllowance,
        "halfDay_pick_up_end_time": halfDayPickUpEndTime,
        "halfDay_pick_up_start_time": halfDayPickUpStartTime,
      };
}
