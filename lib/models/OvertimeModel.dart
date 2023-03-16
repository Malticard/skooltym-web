// To parse this JSON data, do
//
//     final overtimeModel = overtimeModelFromJson(jsonString);
import 'dart:convert';

List<OvertimeModel> overtimeModelFromJson(String str) =>
    List<OvertimeModel>.from(
        json.decode(str).map((x) => OvertimeModel.fromJson(x)));

String overtimeModelToJson(List<OvertimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OvertimeModel {
  OvertimeModel({
    required this.student,
    required this.guardian,
    required this.standardTime,
    required this.actualTime,
    required this.interval,
    required this.rate,
    required this.overtimeCharge,
    required this.status,
    required this.overtimeKey,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String student;
  final String guardian;
  final String standardTime;
  final String actualTime;
  final String interval;
  final int rate;
  final int overtimeCharge;
  final String status;
  final List<dynamic> overtimeKey;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
        student: json["student"],
        guardian: json["guardian"],
        standardTime: json["standard_time"],
        actualTime: json["actual_time"],
        interval: json["interval"],
        rate: json["rate"],
        overtimeCharge: json["overtime_charge"],
        status: json["status"],
        overtimeKey: List<dynamic>.from(json["overtime_key"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "student": student,
        "guardian": guardian,
        "standard_time": standardTime,
        "actual_time": actualTime,
        "interval": interval,
        "rate": rate,
        "overtime_charge": overtimeCharge,
        "status": status,
        "overtime_key": List<dynamic>.from(overtimeKey.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
