// To parse this JSON data, do
//
//     final streamModel = streamModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StreamModel> streamModelFromJson(String str) => List<StreamModel>.from(json.decode(str).map((x) => StreamModel.fromJson(x)));

String streamModelToJson(List<StreamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StreamModel {
    final String school;
    final String streamName;
    final bool isComplete;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    StreamModel({
        required this.school,
        required this.streamName,
        required this.isComplete,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
        school: json["school"],
        streamName: json["stream_name"],
        isComplete: json["isComplete"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "school": school,
        "stream_name": streamName,
        "isComplete": isComplete,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
