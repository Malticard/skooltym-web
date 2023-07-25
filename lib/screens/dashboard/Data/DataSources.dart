import '../../../models/DropOffModels.dart';
import '../../../models/Guardians.dart';
import '../../../models/StudentModel.dart';
import '../../../widgets/FutureImage.dart';
import '/exports/exports.dart';

class StudentsDataSource extends DataTableSource {
  final List<Student> studentModel;
  final BuildContext context;
  final PaginatorController? paginatorController;
  final int totalDocuments;
  final int currentPage;
  StudentsDataSource(
      {this.paginatorController,
      required this.totalDocuments,
      required this.currentPage,
      required this.studentModel,
      required this.context});

  @override
  int get rowCount => totalDocuments;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  DataRow? getRow(int index) {
    final int pageIndex = currentPage ~/ paginatorController!.rowsPerPage;
    final int dataIndex = index % paginatorController!.rowsPerPage;
    final int dataLength = studentModel.length;

    if (pageIndex * paginatorController!.rowsPerPage + dataIndex >=
        dataLength) {
      return null;
    }

    Student studentData =
        studentModel[pageIndex * paginatorController!.rowsPerPage + dataIndex];

    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FutureImage(
                future: fetchAndDisplayImage(studentData.studentProfilePic),
              ),
            ),
            Text("${studentData.studentFname} ${studentData.studentLname}"),
          ],
        )),
        DataCell(Text(studentData.resultClass.className)),
        DataCell(Text(studentData.studentGender)),
        DataCell(
          buildActionButtons(context, () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: MediaQuery.of(context).size.width / 1.3,
                      child: UpdateStudent(studentModel: studentData),
                    ),
                  );
                });
          }, () {
            showDialog(
              context: context,
              builder: (context) {
                return CommonDelete(
                    title:
                        '${studentData.studentFname} ${studentData.studentLname}',
                    url: AppUrls.deleteStudent + studentData.id);
              },
            );
          }),
        ),
      ],
    );
  }
}

// Guardian DataSource
class GuardianDataSource extends DataTableSource {
  final List<Guardian> guardianModel;
  final BuildContext context;
  final int totalDocuments;
  final int currentPage;
  final PaginatorController? paginatorController;
  GuardianDataSource(
      {required this.totalDocuments,
      required this.currentPage,
      this.paginatorController,
      required this.guardianModel,
      required this.context});
  @override
  DataRow? getRow(int index) {
    final int pageIndex = currentPage ~/ paginatorController!.rowsPerPage;
    final int dataIndex = index % paginatorController!.rowsPerPage;
    final int dataLength = guardianModel.length;

    if (pageIndex * paginatorController!.rowsPerPage + dataIndex >=
        dataLength) {
      return null;
    }
    Guardian guardianData =
        guardianModel[pageIndex * paginatorController!.rowsPerPage + dataIndex];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FutureImage(
                future: fetchAndDisplayImage(guardianData.guardianProfilePic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "${guardianData.guardianFname} ${guardianData.guardianLname}",
                  style: const TextStyle(fontSize: 13.5),
                ),
              ),
            ),
          ],
        )),
        DataCell(Text(guardianData.guardianEmail)),
        DataCell(Text(guardianData.guardianGender)),
        DataCell(buildActionButtons(
          context,
          () {
            showDialog(
                context: context,
                builder: (context) {
                  return UpdateGuardian(guardianModel: guardianData);
                });
          },
          () {
            showDialog(
                context: context,
                builder: (context) {
                  return CommonDelete(
                    title:
                        "${guardianData.guardianFname} ${guardianData.guardianLname}",
                    url: AppUrls.deleteGuardian + guardianData.id,
                  );
                });
          },
        )),
      ],
    );
  }

  @override
  int get rowCount => totalDocuments;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}

// class Datasource
class ClassDataSource extends DataTableSource {
  final List<ClassModel> classModel;
  final BuildContext context;
  ClassDataSource({required this.classModel, required this.context});
  @override
  DataRow? getRow(int index) {
    ClassModel classData = classModel[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(classData.className)),
        DataCell(
          buildActionButtons(
            context,
            () => showDialog(
              context: context,
              builder: (context) => UpdateClass(
                streams: classData.classStreams.map((e) => e.id).toList(),
                className: classData.className,
                id: classData.id,
              ),
            ),
            () => showDialog(
              context: context,
              builder: (context) => CommonDelete(
                title: classData.className,
                url: AppUrls.deleteClass + classData.id,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => classModel.length;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}

// Datasource
class StreamDataSource extends DataTableSource {
  final List<StreamModel> streamModel;
  final BuildContext context;
  StreamDataSource({required this.streamModel, required this.context});
  @override
  DataRow? getRow(int index) {
    StreamModel streamData = streamModel[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${index + 1}")),
        DataCell(
          Text(streamData.streamName),
        ),
        DataCell(buildActionButtons(
          context,
          // update a stream
          () => showDialog(
              builder: (context) {
                return UpdateStream(
                  stream: streamData.streamName,
                  id: streamData.id,
                );
              },
              context: context),
          // delete a stream
          () => showDialog(
            context: context,
            builder: (context) => CommonDelete(
              title: streamData.streamName,
              url: AppUrls.deleteStream + streamData.id,
            ),
          ),
        )),
      ],
    );
  }

  @override
  int get rowCount => streamModel.length;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}

// Streams Datasource
class StaffDataSource extends DataTableSource {
  final List<Staff> staffModel;
  final BuildContext context;
  final int totalDocuments;
  final int currentPage;
  final PaginatorController? paginatorController;
  StaffDataSource(
      {required this.totalDocuments,
      required this.currentPage,
      this.paginatorController,
      required this.staffModel,
      required this.context});
  @override
  DataRow? getRow(int index) {
    final int pageIndex = currentPage ~/ paginatorController!.rowsPerPage;
    final int dataIndex = index % paginatorController!.rowsPerPage;
    final int dataLength = staffModel.length;

    if (pageIndex * paginatorController!.rowsPerPage + dataIndex >=
        dataLength) {
      return null;
    }
    Staff staffData =
        staffModel[pageIndex * paginatorController!.rowsPerPage + dataIndex];

    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FutureImage(
                      future: fetchAndDisplayImage(staffData.staffProfilePic))),
              Text(
                staffData.staffFname,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        DataCell(Text((staffData.staffRole.roleType))),
        DataCell(Text(staffData.staffEmail)),
        DataCell(Text(staffData.staffGender)),
        DataCell(buildActionButtons(context, () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 2.3,
                    child: UpdateStaff(staff: staffData),
                  ),
                );
              });
        }, () {
          // delete functionality
          showDialog(
              context: context,
              builder: (context) {
                return CommonDelete(
                  title: '${staffData.staffFname} ${staffData.staffLname}',
                  url: AppUrls.deleteStaff + staffData.id,
                );
              });
        })),
      ],
    );
  }

  @override
  int get rowCount => totalDocuments;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}

// Reports Datasource
class ReportsDataSource extends DataTableSource {
  final List<PaymentModel> paymentModel;
  final BuildContext context;
  ReportsDataSource({required this.paymentModel, required this.context});
  @override
  DataRow? getRow(int index) {
    PaymentModel paymentData = paymentModel[index];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(
          Row(
            children: [
              // Image.network(
              //   AppUrls.liveImages + paymentData.student.studentProfilePic,
              //   height: 33,
              //   width: 33,
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: MemoryImage(
                    processImage(paymentData.student.studentProfilePic),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(paymentData.student.username,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${paymentData.staff.staffFname} ${paymentData.staff.staffLname}",
            style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentData.dateOfPayment.split(".").first,
            style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentData.paymentMethod,
            style: const TextStyle(fontSize: 11))),
        // DataCell(Text(
        //     "${paymentData.staff.staffFname} ${paymentData.staff.staffLname}",
        //     style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentData.balance.toString(),
            style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentData.comment.toString(),
            style: const TextStyle(fontSize: 11))),
      ],
    );
  }

  @override
  int get rowCount => paymentModel.length;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}

// DropOff Datasource
class DropOffDataSource extends DataTableSource {
  final List<DropOff> dropOffModel;
  final BuildContext context;
  final int totalDocuments;
  final int currentPage;
  final PaginatorController? paginatorController;
  DropOffDataSource(
      {required this.totalDocuments,
      required this.currentPage,
      this.paginatorController,
      required this.dropOffModel,
      required this.context});
  @override
  DataRow? getRow(int index) {
    final int pageIndex = currentPage ~/ paginatorController!.rowsPerPage;
    final int dataIndex = index % paginatorController!.rowsPerPage;
    final int dataLength = dropOffModel.length;

    if (pageIndex * paginatorController!.rowsPerPage + dataIndex >=
        dataLength) {
      return null;
    }
    DropOff dropOffData =
        dropOffModel[pageIndex * paginatorController!.rowsPerPage + dataIndex];

    //  dropOffModel[index];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(
          Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: Image.network(
              //     AppUrls.liveImages +
              //         (dropOffData.studentName.studentProfilePic),
              //     height: 30,
              //     width: 30,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: CircleAvatar(
              //     radius: 24,
              //     backgroundImage: MemoryImage(
              //       processImage(dropOffData.studentName.studentProfilePic),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                    "${dropOffData.studentName.studentFname} ${dropOffData.studentName.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${dropOffData.droppedBy.guardianFname} ${dropOffData.droppedBy.guardianLname}")),
        DataCell(Text(
            "${dropOffData.authorizedBy.staffFname} ${dropOffData.authorizedBy.staffLname}")),
        DataCell(
          Text(formatDateTime(dropOffData.dropOffTime)),
        ),
      ],
    );
  }

  @override
  int get rowCount => dropOffModel.length;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}

// PickUp Datasource
class PickUpDataSource extends DataTableSource {
  final List<PickUp> pickUpModel;
  final BuildContext context;
  final int totalDocuments;
  final int currentPage;
  final PaginatorController? paginatorController;
  PickUpDataSource(
      {required this.totalDocuments,
      required this.currentPage,
      this.paginatorController,
      required this.pickUpModel,
      required this.context});
  @override
  DataRow? getRow(int index) {
    final int pageIndex = currentPage ~/ paginatorController!.rowsPerPage;
    final int dataIndex = index % paginatorController!.rowsPerPage;
    final int dataLength = pickUpModel.length;

    if (pageIndex * paginatorController!.rowsPerPage + dataIndex >=
        dataLength) {
      return null;
    }
    PickUp pickUp =
        pickUpModel[pageIndex * paginatorController!.rowsPerPage + dataIndex];

    // PickUp pickUp = pickUpModel[index];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(
          Row(
            children: [
              // Image.network(
              //   AppUrls.liveImages + (pickUp.studentN.studentProfilePic),
              //   height: 25,
              //   width: 25,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: CircleAvatar(
              //     radius: 24,
              //     backgroundImage: MemoryImage(
              //       processImage(pickUp.studentN.studentProfilePic),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                    "${pickUp.studentName.studentFname} ${pickUp.studentName.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${pickUp.pickedBy.guardianFname} ${pickUp.pickedBy.guardianLname}")),
        DataCell(Text(
            "${pickUp.authorizedBy.staffFname} ${pickUp.authorizedBy.staffLname}")),
        DataCell(Text(pickUp.overtimeCharge.toString().split(" ").first)),
        DataCell(Text(formatDate(pickUp.createdAt))),
        DataCell(Text(formatDateTime(pickUp.createdAt))),
        // DataCell(
        //   Text(pickUp.pickUpTime),
        // ),
      ],
    );
  }

  @override
  int get rowCount => totalDocuments;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}
