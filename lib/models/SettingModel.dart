// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SettingsModel> settingsModelFromJson(String str) =>
    List<SettingsModel>.from(
        json.decode(str).map((x) => SettingsModel.fromJson(x)));

String settingsModelToJson(List<SettingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingsModel {
  final bool clockInClockOut;
  final String id;
  final String schoolId;
  final String dropOffStartTime;
  final String dropOffEndTime;
  final String dropOffAllowance;
  final String pickUpStartTime;
  final String pickUpEndTime;
  final String pickUpAllowance;
  final String halfDayPickUpStartTime;
  final String halfDayPickUpEndTime;
  final String halfDayPickUpAllowance;
  final bool allowOvertime;
  final int overtimeRate;
  final String overtimeRateCurrency;
  final String overtimeInterval;
  final List<SettingsKey> settingsKey;
  final bool isComplete;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SettingsModel({
    required this.clockInClockOut,
    required this.id,
    required this.schoolId,
    required this.dropOffStartTime,
    required this.dropOffEndTime,
    required this.dropOffAllowance,
    required this.pickUpStartTime,
    required this.pickUpEndTime,
    required this.pickUpAllowance,
    required this.halfDayPickUpStartTime,
    required this.halfDayPickUpEndTime,
    required this.halfDayPickUpAllowance,
    required this.allowOvertime,
    required this.overtimeRate,
    required this.overtimeRateCurrency,
    required this.overtimeInterval,
    required this.settingsKey,
    required this.isComplete,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        clockInClockOut: json["clock_in_clock_out"],
        id: json["_id"],
        schoolId: json["school_id"],
        dropOffStartTime: json["drop_off_start_time"],
        dropOffEndTime: json["drop_off_end_time"],
        dropOffAllowance: json["drop_off_allowance"],
        pickUpStartTime: json["pick_up_start_time"],
        pickUpEndTime: json["pick_up_end_time"],
        pickUpAllowance: json["pick_up_allowance"],
        halfDayPickUpStartTime: json["halfDay_pick_up_start_time"],
        halfDayPickUpEndTime: json["halfDay_pick_up_end_time"],
        halfDayPickUpAllowance: json["halfDay_pick_up_allowance"],
        allowOvertime: json["allow_overtime"],
        overtimeRate: json["overtime_rate"],
        overtimeRateCurrency: json["overtime_rate_currency"],
        overtimeInterval: json["overtime_interval"],
        settingsKey: List<SettingsKey>.from(
            json["settings_key"].map((x) => SettingsKey.fromJson(x))),
        isComplete: json["isComplete"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "clock_in_clock_out": clockInClockOut,
        "_id": id,
        "school_id": schoolId,
        "drop_off_start_time": dropOffStartTime,
        "drop_off_end_time": dropOffEndTime,
        "drop_off_allowance": dropOffAllowance,
        "pick_up_start_time": pickUpStartTime,
        "pick_up_end_time": pickUpEndTime,
        "pick_up_allowance": pickUpAllowance,
        "halfDay_pick_up_start_time": halfDayPickUpStartTime,
        "halfDay_pick_up_end_time": halfDayPickUpEndTime,
        "halfDay_pick_up_allowance": halfDayPickUpAllowance,
        "allow_overtime": allowOvertime,
        "overtime_rate": overtimeRate,
        "overtime_rate_currency": overtimeRateCurrency,
        "overtime_interval": overtimeInterval,
        "settings_key": List<dynamic>.from(settingsKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class SettingsKey {
  final int key;
  final String id;

  SettingsKey({
    required this.key,
    required this.id,
  });

  factory SettingsKey.fromJson(Map<String, dynamic> json) => SettingsKey(
        key: json["key"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
      };
}
