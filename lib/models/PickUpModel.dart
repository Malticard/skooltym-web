// To parse this JSON data, do
//
//     final pickUpModel = pickUpModelFromJson(jsonString);

// ignore_for_file: camel_case_types

import 'package:meta/meta.dart';
import 'dart:convert';

List<PickUpModel> pickUpModelFromJson(String str) => List<PickUpModel>.from(json.decode(str).map((x) => PickUpModel.fromJson(x)));

String pickUpModelToJson(List<PickUpModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PickUpModel {
    PickUpModel({
        required this.id,
        required this.schoolName,
        required this.studentName_,
        required this.pickUpTime,
        required this.pickedBy,
        required this.authorizedBy_,
        required this.comments,
        required this.pickupKey,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String schoolName;
    final StudentName_ studentName_;
    final DateTime pickUpTime;
    final PickedBy pickedBy;
    final AuthorizedBy_ authorizedBy_;
    final String comments;
    final List<dynamic> pickupKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory PickUpModel.fromJson(Map<String, dynamic> json) => PickUpModel(
        id: json["_id"],
        schoolName: json["school_name"],
        studentName_: StudentName_.fromJson(json["student_name"] ?? {}),
        pickUpTime: DateTime.parse(json["pick_up_time"]),
        pickedBy: PickedBy.fromJson(json["picked_by"] ?? {}),
        authorizedBy_: AuthorizedBy_.fromJson(json["authorized_by"]),
        comments: json["comments"],
        pickupKey: List<dynamic>.from(json["pickup_key"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "student_name": studentName_.toJson(),
        "pick_up_time": pickUpTime.toIso8601String(),
        "picked_by": pickedBy.toJson(),
        "authorized_by": authorizedBy_.toJson(),
        "comments": comments,
        "pickup_key": List<dynamic>.from(pickupKey.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class AuthorizedBy_ {
    AuthorizedBy_({
        required this.staffFname,
        required this.staffLname,
    });

    final String staffFname;
    final String staffLname;

    factory AuthorizedBy_.fromJson(Map<String, dynamic> json) => AuthorizedBy_(
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
    );

    Map<String, dynamic> toJson() => {
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class PickedBy {
    PickedBy({
        required this.guardianFname,
        required this.guardianLname,
    });

    final String guardianFname;
    final String guardianLname;

    factory PickedBy.fromJson(Map<String, dynamic> json) => PickedBy(
        guardianFname: json["guardian_fname"] ?? "",
        guardianLname: json["guardian_lname"]??"",
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class StudentName_ {
    StudentName_({
        required this.studentFname,
        required this.studentLname,
        required this.studentProfilePic,
    });

    final String studentFname;
    final String studentLname;
    final String studentProfilePic;

    factory StudentName_.fromJson(Map<String, dynamic> json) => StudentName_(
        studentFname: json["student_fname"] ?? "",
        studentLname: json["student_lname"] ?? "",
        studentProfilePic: json["student_profile_pic"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_profile_pic": studentProfilePic,
    };
}
