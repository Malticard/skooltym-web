// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<String> classModelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String classModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
