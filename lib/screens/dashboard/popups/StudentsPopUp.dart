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
fetchStudentsRealTimeData();
    super.initState();
  }


  final PaginatorController _controller = PaginatorController();
  List<String> staffs = ["Student's Image","Student Name", "Class", "Gender", "Actions"];
  List<Student> studentData = [];
  int _currentPage = 1;
  int rowsPerPage = 20;
    // stream controller
  StreamController<StudentModel> _studentController =
      StreamController<StudentModel>();
      Timer? timer;
  @override
  void dispose() {
     if (_studentController.hasListener) {
      _studentController.close();
    }
    timer?.cancel();
    super.dispose();
    
  }

  void fetchStudentsRealTimeData() async {
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
      
    Timer.periodic(Duration(seconds: 3), (timer) async {
       this.timer = timer;
               // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var students = await fetchStudents(
            context.read<SchoolController>().state['school'],
            page: _currentPage,
            limit: rowsPerPage);
        _studentController.add(students);
      }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width / 2.5,
      child: Stack(
        children: [
          StreamBuilder(
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
                header: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (studentData.isNotEmpty)
                        SizedBox(
                          width: 120,
                          child: Expanded(
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
                source: StudentsDataSource(
                    studentModel: studentData
                        .where((element) =>
                            element.stream.streamName == widget.stream)
                        .toList(),
                    context: context,
                    currentPage: _currentPage,
                    paginatorController: _controller,
                    totalDocuments: students?.totalDocuments ?? 0),
              );
            },
          ),
          
             Positioned(
              bottom: 20,
              left: 10,
              child: Text("Available students in stream ${widget.stream}"),
            ),
        
        ],
      ),
    );
  }
}
