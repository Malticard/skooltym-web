import 'dart:convert';

List<StudentsNotPaginatedModel> studentsNotPaginatedModelFromJson(String str) =>
    List<StudentsNotPaginatedModel>.from(
        json.decode(str).map((x) => StudentsNotPaginatedModel.fromJson(x)));

String studentsNotPaginatedModelToJson(List<StudentsNotPaginatedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentsNotPaginatedModel {
  final String id;
  final String school;
  final Class studentsNotPaginatedModelClass;
  final List<dynamic> guardians;
  final String studentFname;
  final String studentLname;
  final String otherName;
  final String username;
  final bool isVanStudent;
  final Stream stream;
  final String studentGender;
  final String studentProfilePic;
  final bool isHalfDay;
  final bool isDropped;
  final bool isPicked;
  final List<StudentKey> studentKey;
  final bool isComplete;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  StudentsNotPaginatedModel({
    required this.id,
    required this.school,
    required this.studentsNotPaginatedModelClass,
    required this.guardians,
    required this.studentFname,
    required this.studentLname,
    required this.otherName,
    required this.username,
    required this.isVanStudent,
    required this.stream,
    required this.studentGender,
    required this.studentProfilePic,
    required this.isHalfDay,
    required this.isDropped,
    required this.isPicked,
    required this.studentKey,
    required this.isComplete,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory StudentsNotPaginatedModel.fromJson(Map<String, dynamic> json) =>
      StudentsNotPaginatedModel(
        id: json["_id"],
        school: json["school"],
        studentsNotPaginatedModelClass: Class.fromJson(json["_class"]),
        guardians: List<dynamic>.from(json["guardians"].map((x) => x)),
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        otherName: json["other_name"],
        username: json["username"],
        isVanStudent: json["isVanStudent"],
        stream: Stream.fromJson(json["stream"]),
        studentGender: json["student_gender"],
        studentProfilePic: json["student_profile_pic"],
        isHalfDay: json["isHalfDay"],
        isDropped: json["isDropped"],
        isPicked: json["isPicked"],
        studentKey: List<StudentKey>.from(
            json["student_key"].map((x) => StudentKey.fromJson(x))),
        isComplete: json["isComplete"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "_class": studentsNotPaginatedModelClass.toJson(),
        "guardians": List<dynamic>.from(guardians.map((x) => x)),
        "student_fname": studentFname,
        "student_lname": studentLname,
        "other_name": otherName,
        "username": username,
        "isVanStudent": isVanStudent,
        "stream": stream.toJson(),
        "student_gender": studentGender,
        "student_profile_pic": studentProfilePic,
        "isHalfDay": isHalfDay,
        "isDropped": isDropped,
        "isPicked": isPicked,
        "student_key": List<dynamic>.from(studentKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Stream {
  final String streamName;

  Stream({
    required this.streamName,
  });

  factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        streamName: json["stream_name"],
      );

  Map<String, dynamic> toJson() => {
        "stream_name": streamName,
      };
}

class StudentKey {
  final int key;
  final String id;

  StudentKey({
    required this.key,
    required this.id,
  });

  factory StudentKey.fromJson(Map<String, dynamic> json) => StudentKey(
        key: json["key"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
      };
}

class Class {
  final String className;

  Class({
    required this.className,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        className: json["class_name"],
      );

  Map<String, dynamic> toJson() => {
        "class_name": className,
      };
}
