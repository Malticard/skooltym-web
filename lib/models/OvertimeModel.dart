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
        required this.overtimeCharge,
        required this.status,
        required this.comments,
        required this.isComplete,
        required this.overtimeKey,
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
    final String actualTime;
    final int overtimeCharge;
    final String status;
    final String comments;
    final bool isComplete;
    final List<dynamic> overtimeKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
        id: json["_id"],
        student: Student.fromJson(json["student"] ?? {}),
        school: json["school"],
        guardian: Guardian.fromJson(json["guardian"] ?? {}),
        settings: Settings.fromJson(json["settings"]),
        staff: Staff.fromJson(json["staff"]),
        actualTime: json["actual_time"],
        overtimeCharge: json["overtime_charge"],
        status: json["status"],
        comments: json["comments"],
        isComplete: json["isComplete"],
        overtimeKey: List<dynamic>.from(json["overtime_key"].map((x) => x)),
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
        "overtime_charge": overtimeCharge,
        "status": status,
        "comments": comments,
        "isComplete": isComplete,
        "overtime_key": List<dynamic>.from(overtimeKey.map((x) => x)),
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
        guardianFname: json["guardian_fname"] ?? "",
        guardianLname: json["guardian_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class Settings {
    Settings({
        required this.pickUpEndTime,
        required this.pickUpAllowance,
        required this.overtimeRate,
        required this.overtimeInterval,
    });

    final DateTime pickUpEndTime;
    final String pickUpAllowance;
    final int overtimeRate;
    final String overtimeInterval;

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        pickUpEndTime: DateTime.parse(json["pick_up_end_time"].toString()),
        pickUpAllowance: json["pick_up_allowance"],
        overtimeRate: json["overtime_rate"],
        overtimeInterval: json["overtime_interval"],
    );

    Map<String, dynamic> toJson() => {
        "pick_up_end_time": pickUpEndTime.toIso8601String(),
        "pick_up_allowance": pickUpAllowance,
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
        required this.studentProfilePic,
    });

    final String username;
    final String studentProfilePic;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        username: json["username"] ?? "",
        studentProfilePic: json["student_profile_pic"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "student_profile_pic": studentProfilePic,
    };
}
