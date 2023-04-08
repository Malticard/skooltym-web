// To parse this JSON data, do
//
//     final overtimeModel = overtimeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OvertimeModel> overtimeModelFromJson(String str) => List<OvertimeModel>.from(json.decode(str).map((x) => OvertimeModel.fromJson(x)));

String overtimeModelToJson(List<OvertimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OvertimeModel {
    OvertimeModel({
        required this.id,
        required this.student,
        required this.school,
        required this.guardian,
        required this.settings,
        required this.staff,
        required this.actualTime,
        required this.status,
        required this.overtimeKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final Student student;
    final String school;
    final Guardian guardian;
    final Settings settings;
    final Staff staff;
    final int actualTime;
    final String status;
    final List<OvertimeKey> overtimeKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
        id: json["_id"],
        student: Student.fromJson(json["student"]),
        school: json["school"],
        guardian: Guardian.fromJson(json["guardian"]),
        settings: Settings.fromJson(json["settings"] ?? {}),
        staff: Staff.fromJson(json["staff"]),
        actualTime: json["actual_time"],
        status: json["status"],
        overtimeKey: List<OvertimeKey>.from(json["overtime_key"].map((x) => OvertimeKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student.toJson(),
        "school": school,
        "guardian": guardian.toJson(),
        "settings": settings.toJson(),
        "staff": staff.toJson(),
        "actual_time": actualTime,
        "status": status,
        "overtime_key": List<dynamic>.from(overtimeKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Guardian {
    Guardian({
        required this.guardianFname,
        required this.guardianLname,
    });

    final String guardianFname;
    final String guardianLname;

    factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class OvertimeKey {
    OvertimeKey({
        required this.key,
        required this.id,
    });

    final dynamic key;
    final String id;

    factory OvertimeKey.fromJson(Map<String, dynamic> json) => OvertimeKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class Settings {
    Settings({
        required this.pickUpEndTime,
        required this.overtimeRate,
        required this.overtimeInterval,
    });

    final String pickUpEndTime;
    final int overtimeRate;
    final int overtimeInterval;

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        pickUpEndTime: json["pick_up_end_time"] ?? "",
        overtimeRate: json["overtime_rate"] ?? 0,
        overtimeInterval: json["overtime_interval"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "pick_up_end_time": pickUpEndTime,
        "overtime_rate": overtimeRate,
        "overtime_interval": overtimeInterval,
    };
}

class Staff {
    Staff({
        required this.staffFname,
        required this.staffLname,
    });

    final String staffFname;
    final String staffLname;

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
    );

    Map<String, dynamic> toJson() => {
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class Student {
    Student({
        required this.username,
    });

    final String username;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}
