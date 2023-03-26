// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StudentModel> studentModelFromJson(String str) => List<StudentModel>.from(
    json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentModelToJson(List<StudentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
  StudentModel({
    required this.isComplete,
    required this.id,
    required this.school,
    required this.studentFname,
    required this.studentLname,
    required this.studentContact,
    required this.studentEmail,
    required this.studentClass,
    required this.studentGender,
    required this.studentProfilePic,
    required this.createdAt,
    required this.updatedAt,
    required this.studentNo,
    required this.v,
  });

  final bool isComplete;
  final String id;
  final String school;
  final String studentFname;
  final String studentLname;
  final int studentContact;
  final String studentEmail;
  final String studentClass;
  final String studentGender;
  final String studentProfilePic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int studentNo;
  final int v;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        isComplete: json["isComplete"],
        id: json["_id"],
        school: json["school"],
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        studentContact: json["student_contact"],
        studentEmail: json["student_email"],
        studentClass: json["student_class"],
        studentGender: json["student_gender"],
        studentProfilePic: json["student_profile_pic"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        studentNo: json["student_no"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "isComplete": isComplete,
        "_id": id,
        "school": school,
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_contact": studentContact,
        "student_email": studentEmail,
        "student_class": studentClass,
        "student_gender": studentGender,
        "student_profile_pic": studentProfilePic,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "student_no": studentNo,
        "__v": v,
      };
}
