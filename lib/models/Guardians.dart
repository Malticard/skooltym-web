// To parse this JSON data, do
//
//     final guardians = guardiansFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Guardians> guardiansFromJson(String str) => List<Guardians>.from(json.decode(str).map((x) => Guardians.fromJson(x)));

String guardiansToJson(List<Guardians> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guardians {
    Guardians({
        required this.id,
        required this.school,
        required this.relationship,
        required this.type,
        required this.guardianFname,
        required this.guardianLname,
        required this.guardianContact,
        required this.guardianEmail,
        required this.guardianGender,
        required this.guardianProfilePic,
        required this.guardianDateOfEntry,
        required this.guardianKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String school;
    final String relationship;
    final String type;
    final String guardianFname;
    final String guardianLname;
    final String guardianContact;
    final String guardianEmail;
    final String guardianGender;
    final String guardianProfilePic;
    final String guardianDateOfEntry;
    final List<GuardianKey> guardianKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory Guardians.fromJson(Map<String, dynamic> json) => Guardians(
        id: json["_id"],
        school: json["school"],
        relationship: json["relationship"],
        type: json["type"],
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
        guardianContact: json["guardian_contact"],
        guardianEmail: json["guardian_email"],
        guardianGender: json["guardian_gender"],
        guardianProfilePic: json["guardian_profile_pic"],
        guardianDateOfEntry: json["guardian_dateOfEntry"],
        guardianKey: List<GuardianKey>.from(json["guardian_key"].map((x) => GuardianKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "relationship": relationship,
        "type": type,
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
        "guardian_contact": guardianContact,
        "guardian_email": guardianEmail,
        "guardian_gender": guardianGender,
        "guardian_profile_pic": guardianProfilePic,
        "guardian_dateOfEntry": guardianDateOfEntry,
        "guardian_key": List<dynamic>.from(guardianKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class GuardianKey {
    GuardianKey({
        required this.key,
        required this.id,
    });

    final dynamic key;
    final String id;

    factory GuardianKey.fromJson(Map<String, dynamic> json) => GuardianKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}
