// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DashboardModel> dashboardModelFromJson(String str) => List<DashboardModel>.from(json.decode(str).map((x) => DashboardModel.fromJson(x)));

String dashboardModelToJson(List<DashboardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardModel {
    final String className;
    final List<ClassStream_> classStreams;
    final List<ClassStudent> classStudents;

    DashboardModel({
        required this.className,
        required this.classStreams,
        required this.classStudents,
    });

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        className: json["class_name"],
        classStreams: List<ClassStream_>.from(json["class_streams"].map((x) => ClassStream_.fromJson(x))),
        classStudents: List<ClassStudent>.from(json["class_students"].map((x) => ClassStudent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "class_name": className,
        "class_streams": List<dynamic>.from(classStreams.map((x) => x.toJson())),
        "class_students": List<dynamic>.from(classStudents.map((x) => x.toJson())),
    };
}

class ClassStream_ {
    final String id;
    final String school;
    final String streamName;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    ClassStream_({
        required this.id,
        required this.school,
        required this.streamName,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory ClassStream_.fromJson(Map<String, dynamic> json) => ClassStream_(
        id: json["_id"],
        school: json["school"],
        streamName: json["stream_name"],
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "stream_name": streamName,
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ClassStudent {
    final String id;
    final String school;
    final String classStudentClass;
    final List<dynamic> guardians;
    final String studentFname;
    final String studentLname;
    final String otherName;
    final String username;
    final String stream;
    final String studentGender;
    final String studentProfilePic;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    ClassStudent({
        required this.id,
        required this.school,
        required this.classStudentClass,
        required this.guardians,
        required this.studentFname,
        required this.studentLname,
        required this.otherName,
        required this.username,
        required this.stream,
        required this.studentGender,
        required this.studentProfilePic,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory ClassStudent.fromJson(Map<String, dynamic> json) => ClassStudent(
        id: json["_id"],
        school: json["school"],
        classStudentClass: json["_class"],
        guardians: List<dynamic>.from(json["guardians"].map((x) => x)),
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        otherName: json["other_name"],
        username: json["username"],
        stream: json["stream"],
        studentGender: json["student_gender"],
        studentProfilePic: json["student_profile_pic"],
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "_class": classStudentClass,
        "guardians": List<dynamic>.from(guardians.map((x) => x)),
        "student_fname": studentFname,
        "student_lname": studentLname,
        "other_name": otherName,
        "username": username,
        "stream": stream,
        "student_gender": studentGender,
        "student_profile_pic": studentProfilePic,
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
