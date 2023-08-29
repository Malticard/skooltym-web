// ignore_for_file: deprecated_member_use

import 'package:admin/tools/searchHelpers.dart';

import '../../../models/StudentModel.dart';
import '/exports/exports.dart';

class StudentsPopUps extends StatefulWidget {
  final int? classId;
  final int? id;
  final String? streamId;
  final String? className;
  final String? streamName;
  const StudentsPopUps({
    super.key,
    this.id,
    this.className,
    this.streamName,
    this.classId,
    this.streamId,
  });

  @override
  State<StudentsPopUps> createState() => _StudentsPopUpsState();
}

class _StudentsPopUpsState extends State<StudentsPopUps> {
  List<Student> studentData = [];
  String? _query;

  int _currentPage = 1;
  int rowsPerPage = 20;
  Timer? timer;
  StreamController<List<DashboardModel>> _dashDataController =
      StreamController<List<DashboardModel>>();
  @override
  void initState() {
    context.read<SchoolController>().getSchoolData();
    pollData();
    super.initState();
  }

  final PaginatorController _controller = PaginatorController();
  List<String> staffs = [
    "Student's Image",
    "Student Name",
    "Class",
    "Gender",
    "Actions"
  ];

// Polling data in realtime

  void pollData() async {
    if (mounted) {
      var dashData = await fetchDashBoardData(
          context.read<SchoolController>().state['school']);
      _dashDataController.add(dashData);
    }
    // fetch data periodically
    // Timer.periodic(Duration(seconds: 1), (timer) async {
    //   timer = timer;
    //   if (mounted) {
    if (_query!.isEmpty) {
      searchStudents(context.read<SchoolController>().state['school'], _query!);
    }
    //     var dashData = await fetchDashBoardData(
    //         context.read<SchoolController>().state['school']);
    //     _dashDataController.add(dashData);
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    if (_dashDataController.hasListener) {
      _dashDataController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: Responsive.isMobile(context) ? size.width : size.width / 2.5,
      child: Stack(
        children: [
          StreamBuilder(
            stream: _dashDataController.stream,
            builder: (context, snapshot) {
              var dashboard = snapshot.data;
              var studentData =
                  dashboard?[widget.classId ?? 0].classStudents ?? [];
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
                        // SizedBox(
                        //   width: Responsive.isMobile(context) ? 120 : 200,
                        //   child: SearchField(
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _query = value?.trim();
                        //       });
                        //     },
                        //   ),
                        // ),
                        if (!Responsive.isMobile(context))
                          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                      Text(
                        "",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                empty: !snapshot.hasData
                    ? Loader(
                        text:
                            "Students in ${widget.streamName == null ? widget.className : widget.streamName}",
                      )
                    : NoDataWidget(
                        text: "No "
                            "Students in ${(widget.id == null) ? dashboard![widget.classId ?? 0].className : dashboard?[widget.classId ?? 0].classStreams[widget.id ?? 0].streamName} "
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
                source: StudentsDashboardDataSource(
                    studentClass: widget.className ?? "",
                    studentStream: widget.streamName ?? "",
                    studentModel: widget.streamId == null
                        ? studentData
                        : studentData
                            .where(
                                (element) => element.stream == widget.streamId)
                            .toList(),
                    context: context,
                    currentPage: _currentPage,
                    paginatorController: _controller,
                    totalDocuments: widget.streamId == null
                        ? studentData.length
                        : studentData
                            .where(
                                (element) => element.stream == widget.streamId)
                            .toList()
                            .length),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Text(
                "Available students in ${widget.streamId == null ? widget.className : widget.streamName}"),
          ),
        ],
      ),
    );
  }
}
