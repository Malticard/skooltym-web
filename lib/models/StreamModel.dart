// To parse this JSON data, do
//
//     final streamsModel = streamsModelFromJson(jsonString);

import 'dart:convert';

StreamsModel streamsModelFromJson(String str) => StreamsModel.fromJson(json.decode(str));

String streamsModelToJson(StreamsModel data) => json.encode(data.toJson());

class StreamsModel {
    final int totalDocuments;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<Streams> streams;

    StreamsModel({
        required this.totalDocuments,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.streams,
    });

    factory StreamsModel.fromJson(Map<String, dynamic> json) => StreamsModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        streams: List<Streams>.from(json["streams"].map((x) => Streams.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "streams": List<dynamic>.from(streams.map((x) => x.toJson())),
    };
}

class Streams {
    final String id;
    final String school;
    final String streamName;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Streams({
        required this.id,
        required this.school,
        required this.streamName,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Streams.fromJson(Map<String, dynamic> json) => Streams(
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
