import '/exports/exports.dart';

class StudentsDataSource extends AsyncDataTableSource {
  final List<StudentModel> studentModel;
  final BuildContext context;
  StudentsDataSource({required this.studentModel, required this.context});

  @override
  int get rowCount => studentModel.length;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    return AsyncRowsResponse(
      studentModel.length,
      List.generate(
        studentModel.length,
        (index) {
          StudentModel studentData = studentModel[index];
          return DataRow2.byIndex(
            index: index,
            cells: [
              DataCell(Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: MemoryImage(
                        processImage(studentData.studentProfilePic),
                      ),
                    ),
                  ),
                  Text(
                      "${studentData.studentFname} ${studentData.studentLname}"),
                ],
              )),
              DataCell(Text(studentData.studentModelClass.className)),
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
        },
      ),
    );
  }
}

// Guardian DataSource
class GuardianDataSource extends DataTableSource {
  final List<Guardians> guardianModel;
  final BuildContext context;
  GuardianDataSource({required this.guardianModel, required this.context});
  @override
  DataRow? getRow(int index) {
    Guardians guardianData = guardianModel[index];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: MemoryImage(
                  processImage(guardianData.guardianProfilePic),
                ),
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
  int get rowCount => guardianModel.length;
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
class StaffDataSource extends AsyncDataTableSource {
  final List<StaffModel> staffModel;
  final BuildContext context;
  StaffDataSource({required this.staffModel, required this.context});
  @override
  DataRow? getRow(int index) {
    StaffModel staffData = staffModel[index];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(
          Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: FutureBuilder(
              //     future: fetchAndDisplayImage(AppUrls.liveImages + staffData.staffProfilePic),
              //     builder: (context,snapshot) {
              //       return snapshot.hasData ? CircleAvatar(
              //         radius: 24,
              //         backgroundImage: MemoryImage(
              //           processImage(staffData.staffProfilePic),
              //         ),
              //       ):CircularProgressIndicator.adaptive();
              //     }
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: MemoryImage(
                    processImage(staffData.staffProfilePic),
                  ),
                ),
              ),
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
  int get rowCount => staffModel.length;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
  
  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
   return AsyncRowsResponse(staffModel.length, staffModel.map((staffData){
        return DataRow2.byIndex(
      index: start,
      cells: [
        DataCell(
          Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: FutureBuilder(
              //     future: fetchAndDisplayImage(AppUrls.liveImages + staffData.staffProfilePic),
              //     builder: (context,snapshot) {
              //       return snapshot.hasData ? CircleAvatar(
              //         radius: 24,
              //         backgroundImage: MemoryImage(
              //           processImage(staffData.staffProfilePic),
              //         ),
              //       ):CircularProgressIndicator.adaptive();
              //     }
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: MemoryImage(
                    processImage(staffData.staffProfilePic),
                  ),
                ),
              ),
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
 
   }).toList());
  }
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
  final List<DropOffModel> dropOffModel;
  final BuildContext context;
  DropOffDataSource({required this.dropOffModel, required this.context});
  @override
  DataRow? getRow(int index) {
    DropOffModel dropOffData = dropOffModel[index];
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: MemoryImage(
                    processImage(dropOffData.studentName.studentProfilePic),
                  ),
                ),
              ),
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
  final List<PickUpModel> pickUpModel;
  final BuildContext context;
  PickUpDataSource({required this.pickUpModel, required this.context});
  @override
  DataRow? getRow(int index) {
    PickUpModel pickUp = pickUpModel[index];
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: MemoryImage(
                    processImage(pickUp.studentN.studentProfilePic),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                    "${pickUp.studentN.studentFname} ${pickUp.studentN.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${pickUp.pickedBy.guardianFname} ${pickUp.pickedBy.guardianLname}")),
        DataCell(Text(
            "${pickUp.authorizedBy.staffFname} ${pickUp.authorizedBy.staffLname}")),
        DataCell(Text(pickUp.overtimeCharge.toString().split(" ").first)),
        DataCell(Text("${formatDate(pickUp.createdAt)}")),
        DataCell(
          Text(pickUp.pickUpTime),
        ),
      ],
    );
  }

  @override
  int get rowCount => pickUpModel.length;
  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;
}
