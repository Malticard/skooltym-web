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
        results: List<Payments>.from(json["results"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "results": List<Payments>.from(results.map((x) => x)),
    };
}

// List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(json.decode(str).map((x) => PaymentModel.fromJson(x)));

// String paymentModelToJson(List<PaymentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payments {
    final String id;
    final String school;
    final Studen_t student;
    final Staff_ staff;
    final String dateOfPayment;
    final String paymentMethod;
    final int paidAmount;
    final int balance;
    final String comment;
    final bool isComplete;
    final List<dynamic> paymentKey;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Payments({
        required this.id,
        required this.school,
        required this.student,
        required this.staff,
        required this.dateOfPayment,
        required this.paymentMethod,
        required this.paidAmount,
        required this.balance,
        required this.comment,
        required this.isComplete,
        required this.paymentKey,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        id: json["_id"],
        school: json["school"],
        student: Studen_t.fromJson(json["student"] ?? {}),
        staff: Staff_.fromJson(json["staff"] ?? {}),
        dateOfPayment: json["date_of_payment"],
        paymentMethod: json["payment_method"],
        paidAmount: json["paid_amount"] ?? 0,
        balance: json["balance"] ?? 0,
        comment: json["comment"] ?? "",
        isComplete: json["isComplete"],
        paymentKey: List<dynamic>.from(json["payment_key"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "student": student.toJson(),
        "staff": staff.toJson(),
        "date_of_payment": dateOfPayment,
        "payment_method": paymentMethod,
        "paid_amount": paidAmount,
        "balance": balance,
        "comment": comment,
        "isComplete": isComplete,
        "payment_key": List<dynamic>.from(paymentKey.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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

class Studen_t {
    final String id;
    final String username;
    final String studentProfilePic;

    Studen_t({
        required this.id,
        required this.username,
        required this.studentProfilePic,
    });

    factory Studen_t.fromJson(Map<String, dynamic> json) => Studen_t(
        id: json["_id"] ??"",
        username: json["username"] ?? "",
        studentProfilePic: json["student_profile_pic"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "student_profile_pic": studentProfilePic,
    };
}
