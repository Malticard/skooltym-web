// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StaffModel> staffModelFromJson(String str) => List<StaffModel>.from(json.decode(str).map((x) => StaffModel.fromJson(x)));

String staffModelToJson(List<StaffModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffModel {
    StaffModel({
        required this.id,
        required this.staffSchool,
        required this.staffFname,
        required this.staffLname,
        required this.staffContact,
        required this.staffEmail,
        required this.staffRole,
        required this.staffGender,
        required this.staffProfilePic,
        required this.staffPassword,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String staffSchool;
    final String staffFname;
    final String staffLname;
    final String staffContact;
    final String staffEmail;
    final StaffRole staffRole;
    final String staffGender;
    final String staffProfilePic;
    final String staffPassword;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        id: json["staff_id"],
        staffSchool: json["staff_school"],
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
        staffContact: json["staff_contact"].toString(),
        staffEmail: json["staff_email"],
        staffRole: StaffRole.fromJson(json["staff_role"]),
        staffGender: json["staff_gender"],
        staffProfilePic: json["staff_profilePic"],
        staffPassword: json["staff_password"],
        isComplete: json["isComplete"] ?? false,
        createdAt: DateTime.now(),//DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.now(),//DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "staff_id": id,
        "staff_school": staffSchool,
        "staff_fname": staffFname,
        "staff_lname": staffLname,
        "staff_contact": staffContact,
        "staff_email": staffEmail,
        "staff_role": staffRole.toJson(),
        "staff_gender": staffGender,
        "staff_profilePic": staffProfilePic,
        "staff_password": staffPassword,
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class StaffRole {
    StaffRole({
        required this.roleType,
    });

    final String roleType;

    factory StaffRole.fromJson(Map<String, dynamic> json) => StaffRole(
        roleType: json["role_type"],
    );

    Map<String, dynamic> toJson() => {
        "role_type": roleType,
    };
}
