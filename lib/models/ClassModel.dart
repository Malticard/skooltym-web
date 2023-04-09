// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ClassModel> classModelFromJson(String str) => List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));

String classModelToJson(List<ClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
    ClassModel({
        required this.id,
        required this.school,
        required this.className,
        required this.classStreams,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String school;
    final String className;
    final List<String> classStreams;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json["_id"],
        school: json["school"],
        className: json["class_name"],
        classStreams: List<String>.from(json["class_streams"].map((x) => x)),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "class_name": className,
        "class_streams": List<dynamic>.from(classStreams.map((x) => x)),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
