// To parse this JSON data, do
import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    final int totalDocuments;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<Payments> results;

    PaymentModel({
        required this.totalDocuments,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        results: List<Payments>.from(json["results"].map((x) => Payments.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Payments {
    final String id;
    final String school;
    final GuardianP guardian;
    final StudentP student;
    final StaffP staff;
    final DateTime dateOfPayment;
    final String paymentMethod;
    final int paidAmount;
    final String comment;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Payments({
        required this.id,
        required this.school,
        required this.guardian,
        required this.student,
        required this.staff,
        required this.dateOfPayment,
        required this.paymentMethod,
        required this.paidAmount,
        required this.comment,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        id: json["_id"],
        school: json["school"],
        guardian: GuardianP.fromJson(json["guardian"]),
        student: StudentP.fromJson(json["student"]),
        staff: StaffP.fromJson(json["staff"]),
        dateOfPayment: DateTime.parse(json["date_of_payment"]),
        paymentMethod: json["payment_method"],
        paidAmount: json["paid_amount"],
        comment: json["comment"],
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "guardian": guardian.toJson(),
        "student": student.toJson(),
        "staff": staff.toJson(),
        "date_of_payment": "${dateOfPayment.year.toString().padLeft(4, '0')}-${dateOfPayment.month.toString().padLeft(2, '0')}-${dateOfPayment.day.toString().padLeft(2, '0')}",
        "payment_method": paymentMethod,
        "paid_amount": paidAmount,
        "comment": comment,
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class GuardianP {
    final String id;
    final String guardianFname;
    final String guardianLname;

    GuardianP({
        required this.id,
        required this.guardianFname,
        required this.guardianLname,
    });

    factory GuardianP.fromJson(Map<String, dynamic> json) => GuardianP(
        id: json["_id"],
        guardianFname: json["guardian_fname"] ?? "",
        guardianLname: json["guardian_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class StaffP {
    final String id;
    final String staffFname;
    final String staffLname;

    StaffP({
        required this.id,
        required this.staffFname,
        required this.staffLname,
    });

    factory StaffP.fromJson(Map<String, dynamic> json) => StaffP(
        id: json["_id"],
        staffFname: json["staff_fname"] ?? "",
        staffLname: json["staff_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class StudentP {
    final String id;
    final String username;
    final String studentProfilePic;

    StudentP({
        required this.id,
        required this.username,
        required this.studentProfilePic,
    });

    factory StudentP.fromJson(Map<String, dynamic> json) => StudentP(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        studentProfilePic: json["student_profile_pic"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "student_profile_pic": studentProfilePic,
    };
}
