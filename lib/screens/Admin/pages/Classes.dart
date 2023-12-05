// ignore_for_file: deprecated_member_use

import '/tools/searchHelpers.dart';

import '/exports/exports.dart';

class ClassesUI extends StatefulWidget {
  const ClassesUI({super.key});

  @override
  State<ClassesUI> createState() => _ClassesUIState();
}

class _ClassesUIState extends State<ClassesUI> {
  // stream controller
  StreamController<ClassModel> _classController =
      StreamController<ClassModel>();
  var _paginatorController = PaginatorController();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchStudentsRealTimeData();
  }

  String? _query;
  int _currentPage = 1;
  int rowsPerPage = 50;
  @override
  void dispose() {
    if (_classController.hasListener) {
      _classController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void fetchStudentsRealTimeData() async {
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var classes = await fetchClasses(
            context.read<SchoolController>().state['school']);
        _classController.add(classes);
      }
      // Listen to the stream and update the UI

      Timer.periodic(Duration(seconds: 1), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_query != null) {
            var classes = await searchClasses(
                context.read<SchoolController>().state['school'], _query!);
            _classController.add(classes);
          } else {
            var classes = await fetchClasses(
                context.read<SchoolController>().state['school']);
            _classController.add(classes);
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  //text controllers
  @override
  Widget build(BuildContext context) {
    // responsive dimensions
    Size size = MediaQuery.of(context).size;
    context.read<FirstTimeUserController>().getFirstTimeUser();
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            // width: size.width,
            height: size.height,
            child: StreamBuilder(
              stream: _classController.stream,
              builder: (context, snapshot) {
                var classModel = snapshot.data;
                var controller = classModel?.classes ?? [];

                return CustomDataTable(
                  paginatorController: _paginatorController,
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
                      children: [
                        Text(
                          "Available Classes",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                        Expanded(
                          child: SearchField(onChanged: (value) {
                            setState(() {
                              _query = value?.trim();
                            });
                          }),
                        ),
                        if (!Responsive.isMobile(context))
                          Padding(
                            padding: EdgeInsets.all(15),
                          ),
                        ElevatedButton.icon(
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => const AddClass(),
                            );
                          },
                          label: const Text("Add Class"),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        "No.",
                        style: TextStyles(context).getRegularStyle(),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Class",
                        style: TextStyles(context).getRegularStyle(),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Action",
                        style: TextStyles(context).getRegularStyle(),
                      ),
                    ),
                  ],
                  empty: !snapshot.hasData
                      ? const Loader(text: "Classes data")
                      : const Center(
                          child: Text("No Classes added.."),
                        ),
                  source: ClassDataSource(
                    classModel: controller,
                    context: context,
                    currentPage: _currentPage,
                    paginatorController: _paginatorController,
                    totalDocuments: classModel?.totalDocuments ?? 0,
                  ),
                );
              },
            ),
          ),
        ),
        if (context.read<FirstTimeUserController>().state)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  "Continue to add staff members",
                  style: TextStyles(context).getRegularStyle(),
                ),
                TextButton(
                  onPressed: () {
                    context.read<WidgetController>().pushWidget(2);
                    context.read<TitleController>().setTitle("Staff");
                    context.read<SideBarController>().changeSelected(
                        2, context.read<SchoolController>().state['role']);
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
