// To parse this JSON data, do
//
//     final pickUpModel = pickUpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PickUpModel> pickUpModelFromJson(String str) => List<PickUpModel>.from(json.decode(str).map((x) => PickUpModel.fromJson(x)));

String pickUpModelToJson(List<PickUpModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PickUpModel {
    PickUpModel({
        required this.id,
        required this.schoolName,
        required this.studentName,
        required this.pickUpTime,
        required this.pickedBy,
        required this.authorizedBy,
        required this.comments,
        required this.pickupKey,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String schoolName;
    final StudentName_ studentName;
    final String pickUpTime;
    final PickedBy pickedBy;
    final AuthorizedBy_ authorizedBy;
    final String comments;
    final List<PickupKey> pickupKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory PickUpModel.fromJson(Map<String, dynamic> json) => PickUpModel(
        id: json["_id"],
        schoolName: json["school_name"],
        studentName: StudentName_.fromJson(json["student_name"] ?? {}),
        pickUpTime: json["pick_up_time"],
        pickedBy: PickedBy.fromJson(json["picked_by"] ?? {}),
        authorizedBy: AuthorizedBy_.fromJson(json["authorized_by"]),
        comments: json["comments"],
        pickupKey: List<PickupKey>.from(json["pickup_key"].map((x) => PickupKey.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "student_name": studentName.toJson(),
        "pick_up_time": pickUpTime,
        "picked_by": pickedBy.toJson(),
        "authorized_by": authorizedBy.toJson(),
        "comments": comments,
        "pickup_key": List<dynamic>.from(pickupKey.map((x) => x.toJson())),
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
        staffFname: json["staff_fname"] ?? "",
        staffLname: json["staff_lname"] ?? "",
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
        guardianLname: json["guardian_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class PickupKey {
    PickupKey({
        required this.key,
        required this.id,
    });

    final dynamic key;
    final String id;

    factory PickupKey.fromJson(Map<String, dynamic> json) => PickupKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class StudentName_ {
    StudentName_({
        required this.studentFname,
        required this.studentLname,
    });

    final String studentFname;
    final String studentLname;

    factory StudentName_.fromJson(Map<String, dynamic> json) => StudentName_(
        studentFname: json["student_fname"] ?? "",
        studentLname: json["student_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "student_fname": studentFname,
        "student_lname": studentLname,
    };
}
