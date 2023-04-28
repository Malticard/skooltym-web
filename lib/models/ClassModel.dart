// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ClassModel> classModelFromJson(String str) => List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));

String classModelToJson(List<ClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
    final String school;
    final String className;
    final List<String> classStreams;
    final bool isComplete;
    final String id;

    ClassModel({
        required this.school,
        required this.className,
        required this.classStreams,
        required this.isComplete,
        required this.id,
    });

    factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        school: json["school"],
        className: json["class_name"],
        classStreams: List<String>.from(json["class_streams"].map((x) => x)),
        isComplete: json["isComplete"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "school": school,
        "class_name": className,
        "class_streams": List<dynamic>.from(classStreams.map((x) => x)),
        "isComplete": isComplete,
        "_id": id,
    };
}
