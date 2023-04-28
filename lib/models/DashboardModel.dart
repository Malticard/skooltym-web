// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DashboardModel> dashboardModelFromJson(String str) => List<DashboardModel>.from(json.decode(str).map((x) => DashboardModel.fromJson(x)));

String dashboardModelToJson(List<DashboardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardModel {
    final String className;
    final List<String> classStreams;
    final int classStudents;

    DashboardModel({
        required this.className,
        required this.classStreams,
        required this.classStudents,
    });

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        className: json["class_name"],
        classStreams: List<String>.from(json["class_streams"].map((x) => x)),
        classStudents: json["class_students"],
    );

    Map<String, dynamic> toJson() => {
        "class_name": className,
        "class_streams": List<dynamic>.from(classStreams.map((x) => x)),
        "class_students": classStudents,
    };
}
