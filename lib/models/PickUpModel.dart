// To parse this JSON data, do
import 'dart:convert';

PickUpModel pickUpModelFromJson(String str) =>
    PickUpModel.fromJson(json.decode(str));

String pickUpModelToJson(PickUpModel data) => json.encode(data.toJson());

class PickUpModel {
  final int totalDocuments;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<PickUp> results;

  PickUpModel({
    required this.totalDocuments,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory PickUpModel.fromJson(Map<String, dynamic> json) => PickUpModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        results:
            List<PickUp>.from(json["results"].map((x) => PickUp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PickUp {
  final String id;
  final String school;
  final Settings settings;
  final StudentName studentName;
  final PickedBy pickedBy;
  final AuthorizedBy authorizedBy;
  final int overtimeCharge;
  final List<PickupKey> pickupKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  PickUp({
    required this.id,
    required this.school,
    required this.settings,
    required this.studentName,
    required this.pickedBy,
    required this.authorizedBy,
    required this.overtimeCharge,
    required this.pickupKey,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PickUp.fromJson(Map<String, dynamic> json) => PickUp(
        id: json["_id"],
        school: json["school"] ?? "",
        settings: Settings.fromJson(json["settings"]),
        studentName: StudentName.fromJson(json["student_name"] ?? {}),
        pickedBy: PickedBy.fromJson(json["picked_by"] ?? {}),
        authorizedBy: AuthorizedBy.fromJson(json["authorized_by"]),
        overtimeCharge: json["overtime_charge"] ?? 0,
        pickupKey: List<PickupKey>.from(
            json["pickup_key"].map((x) => PickupKey.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "settings": settings.toJson(),
        "student_name": studentName.toJson(),
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

class StudentName {
  final String studentFname;
  final String studentLname;
  final String studentProfilePic;

  StudentName({
    required this.studentFname,
    required this.studentLname,
    required this.studentProfilePic,
  });

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

class Settings {
    final String id;
    final String pickUpEndTime;
    final String pickUpAllowance;

    Settings({
        required this.id,
        required this.pickUpEndTime,
        required this.pickUpAllowance,
    });

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        id: json["_id"],
        pickUpEndTime: json["pick_up_end_time"],
        pickUpAllowance: json["pick_up_allowance"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "pick_up_end_time": pickUpEndTime,
        "pick_up_allowance": pickUpAllowance,
    };
}

