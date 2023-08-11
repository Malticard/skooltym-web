// To parse this JSON data, do
import 'dart:convert';

Guardians gaurdiansFromJson(String str) => Guardians.fromJson(json.decode(str));

String gaurdiansToJson(Guardians data) => json.encode(data.toJson());

class Guardians {
  final int totalDocuments;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<Guardian> results;

  Guardians({
    required this.totalDocuments,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory Guardians.fromJson(Map<String, dynamic> json) => Guardians(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        results: List<Guardian>.from(
            json["results"].map((x) => Guardian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "results": List<Guardian>.from(results.map((x) => x.toJson())),
      };
}

class Guardian {
  final String id;
  final List<String> students;
  final String school;
  final String relationship;
  final String type;
  final String guardianFname;
  final String guardianLname;
  final int guardianContact;
  final String guardianEmail;
  final String guardianGender;
  final String guardianProfilePic;
  final List<GuardianKey> guardianKey;
  final bool isComplete;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Guardian({
    required this.id,
    required this.students,
    required this.school,
    required this.relationship,
    required this.type,
    required this.guardianFname,
    required this.guardianLname,
    required this.guardianContact,
    required this.guardianEmail,
    required this.guardianGender,
    required this.guardianProfilePic,
    required this.guardianKey,
    required this.isComplete,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        id: json["_id"],
        students: List<String>.from(json["students"].map((x) => x)),
        school: json["school"],
        relationship: json["relationship"],
        type: json["type"],
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
        guardianContact: json["guardian_contact"],
        guardianEmail: json["guardian_email"],
        guardianGender: json["guardian_gender"],
        guardianProfilePic: json["guardian_profile_pic"],
        guardianKey: List<GuardianKey>.from(
            json["guardian_key"].map((x) => GuardianKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "students": List<dynamic>.from(students.map((x) => x)),
        "school": school,
        "relationship": relationship,
        "type": type,
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
        "guardian_contact": guardianContact,
        "guardian_email": guardianEmail,
        "guardian_gender": guardianGender,
        "guardian_profile_pic": guardianProfilePic,
        "guardian_key": List<dynamic>.from(guardianKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class GuardianKey {
  final dynamic key;
  final String id;

  GuardianKey({
    required this.key,
    required this.id,
  });

  factory GuardianKey.fromJson(Map<String, dynamic> json) => GuardianKey(
        key: json["key"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
      };
}
