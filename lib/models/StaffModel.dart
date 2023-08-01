// To parse this JSON data, do
import 'dart:convert';

StaffModel staffModelFromJson(String str) => StaffModel.fromJson(json.decode(str));

String staffModelToJson(StaffModel data) => json.encode(data.toJson());

class StaffModel {
    final int totalDocuments;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<Staff> results;

    StaffModel({
        required this.totalDocuments,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        results: List<Staff>.from(json["results"].map((x) => Staff.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Staff {
    final String id;
    final String staffSchool;
    final String staffFname;
    final String staffLname;
    final int staffContact;
    final String staffEmail;
    final StaffRole staffRole;
    final String staffGender;
    final String staffProfilePic;
    final String staffPassword;
    final List<StaffKey> staffKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Staff({
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
        required this.staffKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        id: json["_id"],
        staffSchool: json["staff_school"],
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
        staffContact: json["staff_contact"],
        staffEmail: json["staff_email"],
        staffRole: StaffRole.fromJson(json["staff_role"]),
        staffGender: json["staff_gender"],
        staffProfilePic: json["staff_profilePic"],
        staffPassword: json["staff_password"],
        staffKey: List<StaffKey>.from(json["staff_key"].map((x) => StaffKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "staff_school": staffSchool,
        "staff_fname": staffFname,
        "staff_lname": staffLname,
        "staff_contact": staffContact,
        "staff_email": staffEmail,
        "staff_role": staffRole.toJson(),
        "staff_gender": staffGender,
        "staff_profilePic": staffProfilePic,
        "staff_password": staffPassword,
        "staff_key": List<dynamic>.from(staffKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class StaffKey {
    final dynamic key;
    final String id;

    StaffKey({
        required this.key,
        required this.id,
    });

    factory StaffKey.fromJson(Map<String, dynamic> json) => StaffKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class StaffRole {
    final String roleType;

    StaffRole({
        required this.roleType,
    });

    factory StaffRole.fromJson(Map<String, dynamic> json) => StaffRole(
        roleType: json["role_type"],
    );

    Map<String, dynamic> toJson() => {
        "role_type": roleType,
    };
}
