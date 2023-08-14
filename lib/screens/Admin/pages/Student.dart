// ignore_for_file: deprecated_member_use

import 'package:admin/tools/searchHelpers.dart';

import '../../../models/StudentModel.dart';
import '/exports/exports.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  List<String> staffs = [
    "Student's Photo",
    "Student Name",
    "Class",
    "Gender",
    "Actions"
  ];
  List<Student> studentData = [];
  int _currentPage = 1;
  Timer? timer;
  int rowsPerPage = 20;
  final PaginatorController _controller = PaginatorController();
  // stream controller
  StreamController<StudentModel> _studentController =
      StreamController<StudentModel>();
  String? _query;
  @override
  void initState() {
    super.initState();
    fetchStudentsRealTimeData();
  }

  @override
  void dispose() {
    if (_studentController.hasListener) {
      _studentController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void fetchStudentsRealTimeData() async {
    String school = context.read<SchoolController>().state['school'];
    try {
      // Fetch the initial data from the server

      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var students = await fetchStudents(
            context.read<SchoolController>().state['school'],
            page: _currentPage,
            limit: rowsPerPage);
        _studentController.add(students);
      }
      // Listen to the stream and update the UI

      Timer.periodic(Duration(seconds: 2), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_query != null) {
            var students = await searchStudents(school, _query ?? "");
            _studentController.add(students);
          } else {
            var students = await fetchStudents(school,
                page: _currentPage, limit: rowsPerPage);
            _studentController.add(students);
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<FirstTimeUserController>()
        .getFirstTimeUser(context.read<SchoolController>().state['role']);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 5,
          // height:Responsive.isMobile(context) ? size.width : size.width / 2.39,
          child: StreamBuilder(
              stream: _studentController.stream,
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
                    paginatorController: _controller,
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
                                  setState(() {
                                    _query = value?.trim();
                                  });
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
                                      width: Responsive.isDesktop(context)
                                          ? size.width / 3
                                          : size.width,
                                      height: Responsive.isMobile(context)
                                          ? size.height * 1.25
                                          : size.width / 1.5,
                                      child: AddStudent(),
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
                    child: !snapshot.hasData
                        ? const Loader(
                            text: "Students data ",
                          )
                        : const NoDataWidget(
                            text: "No students registered yet.."),
                  ),
                  columns: List.generate(
                    staffs.length,
                    (index) => DataColumn(
                      label: Text(
                        staffs[index],
                        style: TextStyles(context).getRegularStyle(),
                      ),
                    ),
                  ),
                );
              }),
        ),
        if (context.read<FirstTimeUserController>().state)
          Expanded(
            child: Row(
              children: [
                const Text("Continue to add guardians"),
                TextButton(
                  onPressed: () {
                    context.read<WidgetController>().pushWidget(3);
                    context.read<TitleController>().setTitle("Guardians",
                        context.read<SchoolController>().state['role']);
                    context.read<SideBarController>().changeSelected(
                        3, context.read<SchoolController>().state['role']);
                  },
                  child: Text(
                    "Click here",
                    style: TextStyles(context).getRegularStyle(),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
