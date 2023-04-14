// To parse this JSON data, do
//
//     final results = resultsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));

String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
    Results({
        required this.guardianFname,
        required this.guardianLname,
        required this.guardianPhoto,
        required this.guardianRelationship,
        required this.guardianContact,
        required this.studentFname,
        required this.studentLname,
        required this.studentPhoto,
        required this.studentClass,
        required this.studentId,
    });

    final String guardianFname;
    final String guardianLname;
    final String guardianPhoto;
    final String guardianRelationship;
    final String guardianContact;
    final String studentFname;
    final String studentLname;
    final String studentPhoto;
    final String studentClass;
    final String studentId;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
        guardianPhoto: json["guardian_photo"],
        guardianRelationship: json["guardian_relationship"],
        guardianContact: json["guardian_contact"],
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        studentPhoto: json["student_photo"],
        studentClass: json["student_class"],
        studentId: json["student_id"],
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
        "guardian_photo": guardianPhoto,
        "guardian_relationship": guardianRelationship,
        "guardian_contact": guardianContact,
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_photo": studentPhoto,
        "student_class": studentClass,
        "student_id": studentId,
    };
}
