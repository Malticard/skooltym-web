// To parse this JSON data, do
//
//     final pickUpModel = pickUpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PickUpModel> pickUpModelFromJson(String str) => List<PickUpModel>.from(json.decode(str).map((x) => PickUpModel.fromJson(x)));

String pickUpModelToJson(List<PickUpModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PickUpModel {
    final String id;
    final String school;
    final String settings;
    final StudentN studentN;
    final String pickUpTime;
    final PickedBy pickedBy;
    final AuthorizedBy authorizedBy;
    final int overtimeCharge;
    final List<PickupKey> pickupKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    PickUpModel({
        required this.id,
        required this.school,
        required this.settings,
        required this.studentN,
        required this.pickUpTime,
        required this.pickedBy,
        required this.authorizedBy,
        required this.overtimeCharge,
        required this.pickupKey,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory PickUpModel.fromJson(Map<String, dynamic> json) => PickUpModel(
        id: json["_id"],
        school: json["school"],
        settings: json["settings"],
        studentN: StudentN.fromJson(json["student_n"] ?? {}),
        pickUpTime: json["pick_up_time"],
        pickedBy: PickedBy.fromJson(json["picked_by"] ?? {}),
        authorizedBy: AuthorizedBy.fromJson(json["authorized_by"]),
        overtimeCharge: json["overtime_charge"],
        pickupKey: List<PickupKey>.from(json["pickup_key"].map((x) => PickupKey.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "settings": settings,
        "student_n": studentN.toJson(),
        "pick_up_time": pickUpTime,
        "picked_by": pickedBy.toJson(),
        "authorized_by": authorizedBy.toJson(),
        "overtime_charge": overtimeCharge,
        "pickup_key": List<dynamic>.from(pickupKey.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class AuthorizedBy {
    final String staffFname;
    final String staffLname;

    AuthorizedBy({
        required this.staffFname,
        required this.staffLname,
    });

    factory AuthorizedBy.fromJson(Map<String, dynamic> json) => AuthorizedBy(
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
    );

    Map<String, dynamic> toJson() => {
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class PickedBy {
    final String guardianFname;
    final String guardianLname;

    PickedBy({
        required this.guardianFname,
        required this.guardianLname,
    });

    factory PickedBy.fromJson(Map<String, dynamic> json) => PickedBy(
        guardianFname: json["guardian_fname"] ?? "",
        guardianLname: json["guardian_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class PickupKey {
    final dynamic key;
    final String id;

    PickupKey({
        required this.key,
        required this.id,
    });

    factory PickupKey.fromJson(Map<String, dynamic> json) => PickupKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class StudentN {
    final String studentFname;
    final String studentLname;
    final String studentProfilePic;

    StudentN({
        required this.studentFname,
        required this.studentLname,
        required this.studentProfilePic,
    });

    factory StudentN.fromJson(Map<String, dynamic> json) => StudentN(
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
