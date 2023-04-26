import 'dart:convert';

List<SettingsModel> settingsModelFromJson(String str) => List<SettingsModel>.from(json.decode(str).map((x) => SettingsModel.fromJson(x)));

String settingsModelToJson(List<SettingsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingsModel {
    SettingsModel({
        required this.id,
        required this.schoolId,
        required this.dropOffStartTime,
        required this.dropOffEndTime,
        required this.pickUpStartTime,
        required this.pickUpEndTime,
        required this.dropOffAllowance,
        required this.pickUpAllowance,
        required this.allowOvertime,
        required this.overtimeRate,
        required this.overtimeRateCurrency,
        required this.isComplete,
        required this.settingsKey,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.overtimeInterval,
    });

    final String id;
    final String schoolId;
    final String dropOffStartTime;
    final String dropOffEndTime;
    final DateTime pickUpStartTime;
    final DateTime pickUpEndTime;
    final String dropOffAllowance;
    final String pickUpAllowance;
    final bool allowOvertime;
    final int overtimeRate;
    final String overtimeRateCurrency;
    final bool isComplete;
    final List<dynamic> settingsKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final String overtimeInterval;

    factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        id: json["_id"],
        schoolId: json["school_id"],
        dropOffStartTime: json["drop_off_start_time"],
        dropOffEndTime: json["drop_off_end_time"],
        pickUpStartTime: DateTime.parse(json["pick_up_start_time"]),
        pickUpEndTime: DateTime.parse(json["pick_up_end_time"]),
        dropOffAllowance: json["drop_off_allowance"],
        pickUpAllowance: json["pick_up_allowance"],
        allowOvertime: json["allow_overtime"],
        overtimeRate: json["overtime_rate"],
        overtimeRateCurrency: json["overtime_rate_currency"],
        isComplete: json["isComplete"],
        settingsKey: List<dynamic>.from(json["settings_key"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        overtimeInterval: json["overtime_interval"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_id": schoolId,
        "drop_off_start_time": dropOffStartTime,
        "drop_off_end_time": dropOffEndTime,
        "pick_up_start_time": pickUpStartTime.toIso8601String(),
        "pick_up_end_time": pickUpEndTime.toIso8601String(),
        "drop_off_allowance": dropOffAllowance,
        "pick_up_allowance": pickUpAllowance,
        "allow_overtime": allowOvertime,
        "overtime_rate": overtimeRate,
        "overtime_rate_currency": overtimeRateCurrency,
        "isComplete": isComplete,
        "settings_key": List<dynamic>.from(settingsKey.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "overtime_interval": overtimeInterval,
    };
}
