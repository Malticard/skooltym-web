// ignore_for_file: deprecated_member_use

import '../../../models/StudentModel.dart';
import '/exports/exports.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents>{

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  List<Student> studentData = [];
  int _currentPage = 1;
  int rowsPerPage = 20;
  final PaginatorController _controller = PaginatorController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          height: size.width / 2.39,
          child: StreamBuilder(
              stream: fetchStudents(
                      context.read<SchoolController>().state['school'],
                      page: _currentPage,
                      limit: rowsPerPage)
                  .asStream(),
              builder: (context, snapshot) {
                var students = snapshot.data;
                var studentData = students?.results ?? [];
                return CustomDataTable(
                  paginatorController: _controller,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = (page ~/ rowsPerPage) + 1;
                    });
                  },
                  onRowsPerPageChanged: (rows) {
                    setState(() {
                      rowsPerPage = rows ?? 20;
                    });
                  },
                  source: StudentsDataSource(
                    studentModel: studentData,
                    context: context,
                    currentPage: _currentPage,
                    totalDocuments: students?.totalDocuments ?? 0,
                  ),
                  header: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (studentData.isNotEmpty)
                          Expanded(
                            child: SizedBox(
                              width: 120,
                              child: SearchField(
                                onChanged: (value) {
                                  // controller.searchStudents(value ?? "");
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
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.2,
                                      child: const SingleChildScrollView(
                                          child: AddStudent()),
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add Student"),
                        ),
                      ],
                    ),
                  ),
                  empty: Center(
                    child: FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 2)),
                        builder: (context, d) {
                          return d.connectionState == ConnectionState.waiting
                              ? const Loader(
                                  text: "Students data ",
                                )
                              : const NoDataWidget(
                                  text: "No students registered yet..");
                        }),
                  ),
                  columns: List.generate(
                    staffs.length,
                    (index) => DataColumn2(
                      numeric: true,
                      label: Text(
                        staffs[index],
                      ),
                    ),
                  ),
                  // List.generate(
                  //   context.watch<MainController>().sStudent.isEmpty
                  //       ? context.watch<MainController>().students.length
                  //       : context.watch<MainController>().sStudent.length,
                  //   (index) => _dataRow(
                  //       context.watch<MainController>().sStudent.isEmpty
                  //           ? context
                  //               .watch<MainController>()
                  //               .students[index]
                  //           : context
                  //               .watch<MainController>()
                  //               .sStudent[index],
                  //       index),
                  // ),
                );
              }),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const Text("Continue to adding guardians"),
              TextButton(
                onPressed: () {
                  context
                      .read<WidgetController>()
                      .pushWidget(const ViewGuardians());
                  context.read<TitleController>().setTitle("Guardians");
                  context.read<SideBarController>().changeSelected(3);
                },
                child: Text(
                  "Click here",
                  style: TextStyles(context).getRegularStyle(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
