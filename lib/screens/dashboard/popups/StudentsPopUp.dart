// ignore_for_file: deprecated_member_use

import '../../../models/StudentModel.dart';
import '/exports/exports.dart';

class StudentsPopUps extends StatefulWidget {
  final String stream;
  const StudentsPopUps({super.key, required this.stream});

  @override
  State<StudentsPopUps> createState() => _StudentsPopUpsState();
}

class _StudentsPopUpsState extends State<StudentsPopUps> {
  @override
  void initState() {
    BlocProvider.of<FetchStudentsController>(context)
        .getStudents(context.read<SchoolController>().state['school']);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<FetchStudentsController>(context, listen: true)
        .getStudents(context.read<SchoolController>().state['school']);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  DataRow _dataRow(Student studentModel, int i) {
    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  AppUrls.liveImages + studentModel.studentProfilePic,
                ),
              ),
            ),
            Text("${studentModel.studentFname} ${studentModel.studentLname}"),
          ],
        )),
        DataCell(Text(studentModel.resultClass.className)),
        DataCell(Text(studentModel.studentGender)),
        DataCell(buildActionButtons(context, () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.width / 2,
                    child: UpdateStudent(studentModel: studentModel),
                  ),
                );
              });
        }, () {
          showDialog(
              context: context,
              builder: (context) {
                return CommonDelete(
                    title:
                        '${studentModel.studentFname} ${studentModel.studentLname}',
                    url: AppUrls.deleteStudent + studentModel.id);
              });
        })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<FetchStudentsController>(context, listen: true)
        .getStudents(context.read<SchoolController>().state['school']);
    return SizedBox(
      height: size.width / 2.5,
      child: Stack(
        children: [
          BlocBuilder<FetchStudentsController, List<Student>>(
            builder: (context, students) {
              return CustomDataTable(
                header: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (students.isNotEmpty)
                        Expanded(
                          child: SizedBox(
                            width: 120,
                            child: SearchField(
                              onChanged: (value) {
                                // Provider.of<MainController>(context,
                                //         listen: false)
                                //     .searchStudents(value ?? "");
                              },
                            ),
                          ),
                        ),
                      if (!Responsive.isMobile(context))
                        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                      Text(
                        "",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                empty: NoDataWidget(
                  text: "No "
                      "Students in ${widget.stream} "
                      "yet...",
                ),
                columns: List.generate(
                  staffs.length,
                  (index) => DataColumn(
                    label: Text(
                      staffs[index],
                    ),
                  ),
                ),
                // rows: List.generate(
                //   students
                      // .where((element) =>
                      //     element.stream.streamName == widget.stream)
                      // .toList()
                //       .length,
                //   (index) => _dataRow(
                //       students
                //           .where((element) =>
                //               element.stream.streamName.trim() ==
                //               widget.stream.trim())
                //           .toList()[index],
                //       index),
                // ),
                source: StudentsDataSource(
                    studentModel: students.where((element) =>
                          element.stream.streamName == widget.stream)
                      .toList(), context: context, currentPage: 0, totalDocuments: 0),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Positioned(
              bottom: 10,
              left: 10,
              child: Row(
                children: [
                  Text("Available students in stream ${widget.stream}"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
