
import 'dart:convert';

DropOffModel dropOffModelFromJson(String str) => DropOffModel.fromJson(json.decode(str));

String dropOffModelToJson(DropOffModel data) => json.encode(data.toJson());

class DropOffModel {
    final int totalDocuments;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<DropOff> results;

    DropOffModel({
        required this.totalDocuments,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    factory DropOffModel.fromJson(Map<String, dynamic> json) => DropOffModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        results: List<DropOff>.from(json["dropoffs"].map((x) => DropOff.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "dropoffs": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class DropOff {
    final String id;
    final String schoolName;
    final StudentName studentName;
    final DateTime dropOffTime;
    final DroppedBy droppedBy;
    final AuthorizedBy authorizedBy;
    final String comments;
    final List<DropoffKey> dropoffKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    DropOff({
        required this.id,
        required this.schoolName,
        required this.studentName,
        required this.dropOffTime,
        required this.droppedBy,
        required this.authorizedBy,
        required this.comments,
        required this.dropoffKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory DropOff.fromJson(Map<String, dynamic> json) => DropOff(
        id: json["_id"],
        schoolName: json["school_name"],
        studentName: StudentName.fromJson(json["student_name"]),
        dropOffTime: DateTime.parse(json["drop_off_time"]),
        droppedBy: DroppedBy.fromJson(json["dropped_by"]),
        authorizedBy: AuthorizedBy.fromJson(json["authorized_by"]),
        comments: json["comments"],
        dropoffKey: List<DropoffKey>.from(json["dropoff_key"].map((x) => DropoffKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "student_name": studentName.toJson(),
        "drop_off_time": dropOffTime.toIso8601String(),
        "dropped_by": droppedBy.toJson(),
        "authorized_by": authorizedBy.toJson(),
        "comments": comments,
        "dropoff_key": List<dynamic>.from(dropoffKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class AuthorizedBy {
    final String staffFname;
    final String staffLname;

    AuthorizedBy({
        required this.staffFname,
        required this.staffLname,
    });

    factory AuthorizedBy.fromJson(Map<String, dynamic> json) => AuthorizedBy(
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
    );

    Map<String, dynamic> toJson() => {
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class DropoffKey {
    final int key;
    final String id;

    DropoffKey({
        required this.key,
        required this.id,
    });

    factory DropoffKey.fromJson(Map<String, dynamic> json) => DropoffKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class DroppedBy {
    final String guardianFname;
    final String guardianLname;

    DroppedBy({
        required this.guardianFname,
        required this.guardianLname,
    });

    factory DroppedBy.fromJson(Map<String, dynamic> json) => DroppedBy(
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class StudentName {
    final String studentFname;
    final String studentLname;
    final String studentProfilePic;

    StudentName({
        required this.studentFname,
        required this.studentLname,
        required this.studentProfilePic,
    });

    factory StudentName.fromJson(Map<String, dynamic> json) => StudentName(
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        studentProfilePic: json["student_profile_pic"],
    );

    Map<String, dynamic> toJson() => {
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_profile_pic": studentProfilePic,
    };
}
