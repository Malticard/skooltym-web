// To parse this JSON data, do
//;
import 'dart:convert';

ClassModel classModelFromJson(String str) => ClassModel.fromJson(json.decode(str));

String classModelToJson(ClassModel data) => json.encode(data.toJson());

class ClassModel {
    final int totalDocuments;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<Classes> classes;

    ClassModel({
        required this.totalDocuments,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.classes,
    });

    factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        classes: List<Classes>.from(json["classes"].map((x) => Classes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
    };
}

class Classes {
    final String id;
    final String school;
    final String className;
    final List<ClassStream> classStreams;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Classes({
        required this.id,
        required this.school,
        required this.className,
        required this.classStreams,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        id: json["_id"],
        school: json["school"],
        className: json["class_name"],
        classStreams: List<ClassStream>.from(json["class_streams"].map((x) => ClassStream.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "class_name": className,
        "class_streams": List<dynamic>.from(classStreams.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ClassStream {
    final String id;
    final String streamName;

    ClassStream({
        required this.id,
        required this.streamName,
    });

    factory ClassStream.fromJson(Map<String, dynamic> json) => ClassStream(
        id: json["_id"],
        streamName: json["stream_name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "stream_name": streamName,
    };
}
