// To parse this JSON data, do
//
//     final dropOffModel = dropOffModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DropOffModel> dropOffModelFromJson(String str) => List<DropOffModel>.from(json.decode(str).map((x) => DropOffModel.fromJson(x)));

String dropOffModelToJson(List<DropOffModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropOffModel {
    DropOffModel({
        required this.id,
        required this.schoolName,
        required this.studentName,
        required this.dropOffTime,
        required this.droppedBy,
        required this.authorizedBy,
        required this.comments,
        required this.isComplete,
        required this.dropoffKey,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String schoolName;
    final StudentName studentName;
    final DateTime dropOffTime;
    final DroppedBy droppedBy;
    final AuthorizedBy authorizedBy;
    final String comments;
    final bool isComplete;
    final List<dynamic> dropoffKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory DropOffModel.fromJson(Map<String, dynamic> json) => DropOffModel(
        id: json["_id"],
        schoolName: json["school_name"] ?? "",
        studentName: StudentName.fromJson(json["student_name"] ?? {}),
        dropOffTime: DateTime.now(),//DateTime.parse(json["drop_off_time"]),
        droppedBy: DroppedBy.fromJson(json["dropped_by"] ?? {}),
        authorizedBy: AuthorizedBy.fromJson(json["authorized_by"]),
        comments: json["comments"],
        isComplete: json["isComplete"],
        dropoffKey: List<dynamic>.from(json["dropoff_key"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "student_name": studentName.toJson(),
        "drop_off_time": dropOffTime.toIso8601String(),
        "dropped_by": droppedBy.toJson(),
        "authorized_by": authorizedBy.toJson(),
        "comments": comments,
        "isComplete": isComplete,
        "dropoff_key": List<dynamic>.from(dropoffKey.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class AuthorizedBy {
    AuthorizedBy({
        required this.staffFname,
        required this.staffLname,
    });

    final String staffFname;
    final String staffLname;

    factory AuthorizedBy.fromJson(Map<String, dynamic> json) => AuthorizedBy(
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
    );

    Map<String, dynamic> toJson() => {
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class DroppedBy {
    DroppedBy({
        required this.guardianFname,
        required this.guardianLname,
    });

    final String guardianFname;
    final String guardianLname;

    factory DroppedBy.fromJson(Map<String, dynamic> json) => DroppedBy(
        guardianFname: json["guardian_fname"] ?? "",
        guardianLname: json["guardian_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class StudentName {
    StudentName({
        required this.studentFname,
        required this.studentLname,
        required this.studentProfilePic,
    });

    final String studentFname;
    final String studentLname;
    final String studentProfilePic;

    factory StudentName.fromJson(Map<String, dynamic> json) => StudentName(
        studentFname: json["student_fname"] ?? "",
        studentLname: json["student_lname"] ?? "",
        studentProfilePic: json["student_profile_pic"] ?? "profile.png",
    );

    Map<String, dynamic> toJson() => {
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_profile_pic": studentProfilePic,
    };
}
