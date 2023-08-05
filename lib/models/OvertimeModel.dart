// // To parse this JSON data, do
// import 'dart:convert';

// List<OvertimeModel> overtimeModelFromJson(String str) => List<OvertimeModel>.from(json.decode(str).map((x) => OvertimeModel.fromJson(x)));

// String overtimeModelToJson(List<OvertimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class OvertimeModel {
//     OvertimeModel({
//         required this.id,
//         required this.student,
//         required this.school,
//         required this.guardian,
//         required this.settings,
//         required this.staff,
//         required this.actualTime,
//         required this.overtimeCharge,
//         required this.status,
//         required this.comments,
//         required this.isComplete,
//         required this.overtimeKey,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     final String id;
//     final Student_ student;
//     final String school;
//     final Guardian_ guardian;
//     final Settings settings;
//     final Staff staff;
//     final String actualTime;
//     final int overtimeCharge;
//     final String status;
//     final String comments;
//     final bool isComplete;
//     final List<dynamic> overtimeKey;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final int v;

//     factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
//         id: json["_id"],
//         student: Student_.fromJson(json["student"] ?? {}),
//         school: json["school"],
//         guardian: Guardian_.fromJson(json["guardian"] ?? {}),
//         settings: Settings.fromJson(json["settings"]),
//         staff: Staff.fromJson(json["staff"] ?? {}),
//         actualTime: json["actual_time"],
//         overtimeCharge: json["overtime_charge"],
//         status: json["status"],
//         comments: json["comments"],
//         isComplete: json["isComplete"],
//         overtimeKey: List<dynamic>.from(json["overtime_key"].map((x) => x)),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "student": student.toJson(),
//         "school": school,
//         "guardian": guardian.toJson(),
//         "settings": settings.toJson(),
//         "staff": staff.toJson(),
//         "actual_time": actualTime,
//         "overtime_charge": overtimeCharge,
//         "status": status,
//         "comments": comments,
//         "isComplete": isComplete,
//         "overtime_key": List<dynamic>.from(overtimeKey.map((x) => x)),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class Guardian_ {
//     Guardian_({
//         required this.guardianFname,
//         required this.guardianLname,
//     });

//     final String guardianFname;
//     final String guardianLname;

//     factory Guardian_.fromJson(Map<String, dynamic> json) => Guardian_(
//         guardianFname: json["guardian_fname"] ?? "",
//         guardianLname: json["guardian_lname"] ?? "",
//     );

//     Map<String, dynamic> toJson() => {
//         "guardian_fname": guardianFname,
//         "guardian_lname": guardianLname,
//     };
// }

// class Settings {
//     Settings({
//         required this.pickUpEndTime,
//         required this.pickUpAllowance,
//         required this.overtimeRate,
//         required this.overtimeInterval,
//     });

//     final DateTime pickUpEndTime;
//     final String pickUpAllowance;
//     final int overtimeRate;
//     final String overtimeInterval;

//     factory Settings.fromJson(Map<String, dynamic> json) => Settings(
//         pickUpEndTime: DateTime.parse(json["pick_up_end_time"].toString()),
//         pickUpAllowance: json["pick_up_allowance"],
//         overtimeRate: json["overtime_rate"],
//         overtimeInterval: json["overtime_interval"],
//     );

//     Map<String, dynamic> toJson() => {
//         "pick_up_end_time": pickUpEndTime.toIso8601String(),
//         "pick_up_allowance": pickUpAllowance,
//         "overtime_rate": overtimeRate,
//         "overtime_interval": overtimeInterval,
//     };
// }

// class Staff {
//     Staff({
//         required this.staffFname,
//         required this.staffLname,
//     });

//     final String staffFname;
//     final String staffLname;

//     factory Staff.fromJson(Map<String, dynamic> json) => Staff(
//         staffFname: json["staff_fname"] ?? "",
//         staffLname: json["staff_lname"] ?? "",
//     );

//     Map<String, dynamic> toJson() => {
//         "staff_fname": staffFname,
//         "staff_lname": staffLname,
//     };
// }

// class Student_ {
//     Student_({
//         required this.username,
//         required this.studentProfilePic,
//     });

//     final String username;
//     final String studentProfilePic;

//     factory Student_.fromJson(Map<String, dynamic> json) => Student_(
//         username: json["username"] ?? "",
//         studentProfilePic: json["student_profile_pic"] ?? "profile.png",
//     );

//     Map<String, dynamic> toJson() => {
//         "username": username,
//         "student_profile_pic": studentProfilePic,
//     };
// }

// To parse this JSON data, do
//
//     final overtimeModel = overtimeModelFromJson(jsonString);

import 'dart:convert';

OvertimeModel overtimeModelFromJson(String str) => OvertimeModel.fromJson(json.decode(str));

String overtimeModelToJson(OvertimeModel data) => json.encode(data.toJson());

class OvertimeModel {
    final int totalDocuments;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<Overtimes> results;

    OvertimeModel({
        required this.totalDocuments,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        results: List<Overtimes>.from(json["results"].map((x) => Overtimes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Overtimes {
    final String id;
    final StudentO student;
    final String school;
    final GuardianO guardian;
    final Staff_ staff;
    final int overtimeCharge;
    final String status;
    final String comments;
    final bool isComplete;
    final List<dynamic> overtimeKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Overtimes({
        required this.id,
        required this.student,
        required this.school,
        required this.guardian,
        required this.staff,
        required this.overtimeCharge,
        required this.status,
        required this.comments,
        required this.isComplete,
        required this.overtimeKey,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Overtimes.fromJson(Map<String, dynamic> json) => Overtimes(
        id: json["_id"],
        student: StudentO.fromJson(json["student"] ?? {}),
        school: json["school"],
        guardian: GuardianO.fromJson(json["guardian"] ?? {}),
        staff: Staff_.fromJson(json["staff"] ?? {}),
        overtimeCharge: json["overtime_charge"],
        status: json["status"],
        comments: json["comments"] ?? "",
        isComplete: json["isComplete"],
        overtimeKey: List<dynamic>.from(json["overtime_key"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student.toJson(),
        "school": school,
        "guardian": guardian.toJson(),
        "staff": staff.toJson(),
        "overtime_charge": overtimeCharge,
        "status": status,
        "comments": comments,
        "isComplete": isComplete,
        "overtime_key": List<dynamic>.from(overtimeKey.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class GuardianO {
    final String id;
    final String guardianFname;
    final String guardianLname;

    GuardianO({
        required this.id,
        required this.guardianFname,
        required this.guardianLname,
    });

    factory GuardianO.fromJson(Map<String, dynamic> json) => GuardianO(
        id: json["_id"] ?? "",
        guardianFname: json["guardian_fname"] ?? "",
        guardianLname: json["guardian_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class Staff_ {
    final String id;
    final String staffFname;
    final String staffLname;

    Staff_({
        required this.id,
        required this.staffFname,
        required this.staffLname,
    });

    factory Staff_.fromJson(Map<String, dynamic> json) => Staff_(
        id: json["_id"] ?? "",
        staffFname: json["staff_fname"] ?? "",
        staffLname: json["staff_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class StudentO {
    final String id;
    final String studentFname;
    final String studentLname;
    final String studentProfilePic;

    StudentO({ required this.studentFname,required this.studentLname,
        required this.id,
        
        required this.studentProfilePic,
    });

    factory StudentO.fromJson(Map<String, dynamic> json) => StudentO(
        id: json["_id"] ?? "",
        studentFname: json["student_fname"] ?? "",
        studentLname: json["student_lname"] ?? "",
        studentProfilePic: json["student_profile_pic"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_profile_pic": studentProfilePic,
    };
}
