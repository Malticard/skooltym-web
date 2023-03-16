// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    required this.id,
    required this.school,
    required this.studentFname,
    required this.studentLname,
    required this.studentContact,
    required this.studentEmail,
    required this.studentClass,
    required this.studentGender,
    required this.studentProfilePic,
    required this.studentKey,
    required this.createdAt,
    required this.updatedAt,
    required this.studentNo,
    required this.v,
  });

  final String id;
  final String school;
  final String studentFname;
  final String studentLname;
  final int studentContact;
  final String studentEmail;
  final String studentClass;
  final String studentGender;
  final String studentProfilePic;
  final List<StudentKey> studentKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int studentNo;
  final int v;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json["_id"],
        school: json["school"],
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        studentContact: json["student_contact"],
        studentEmail: json["student_email"],
        studentClass: json["student_class"],
        studentGender: json["student_gender"],
        studentProfilePic: json["student_profile_pic"],
        studentKey: List<StudentKey>.from(
            json["student_key"].map((x) => StudentKey.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        studentNo: json["student_no"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_contact": studentContact,
        "student_email": studentEmail,
        "student_class": studentClass,
        "student_gender": studentGender,
        "student_profile_pic": studentProfilePic,
        "student_key": List<dynamic>.from(studentKey.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "student_no": studentNo,
        "__v": v,
      };
}

class StudentKey {
  StudentKey({
    required this.key,
    required this.id,
  });

  final dynamic key;
  final String id;

  factory StudentKey.fromJson(Map<String, dynamic> json) => StudentKey(
        key: json["key"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
      };
}
