// ignore_for_file: deprecated_member_use

import 'package:admin/tools/searchHelpers.dart';

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
    Response response = await Client().get(
      Uri.parse(
        AppUrls.getClasses +
            context.read<SchoolController>().state['school'] +
            "?page=" +
            _currentPage.toString() +
            "&pageSize=" +
            rowsPerPage.toString(),
      ),
    );
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          _classController.add(classModelFromJson(response.body));
        }
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
            if (response.statusCode == 200 || response.statusCode == 201) {
              _classController.add(classModelFromJson(response.body));
            }
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

    return Stack(
      children: [
        SizedBox(
          // width: size.width,
          height: size.width / 2.39,
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
                header: Row(
                  children: [
                    Expanded(
                      child: SearchField(onChanged: (value) {
                        setState(() {
                          _query = value?.trim();
                        });
                      }),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AddClass(),
                        );
                      },
                      label: const Text("Add Class"),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                columns: const [
                  DataColumn(
                    label: Text("No."),
                  ),
                  DataColumn(
                    label: Text("Class"),
                  ),
                  DataColumn(
                    label: Text("Action"),
                  ),
                ],
                empty: FutureBuilder(
                    future: fetchClasses(
                        context.read<SchoolController>().state['school']),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Loader(text: "Classes data")
                          : const Center(
                              child: Text("No Classes added.."),
                            );
                    }),
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
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const Text("Continue to add staffs members"),
              TextButton(
                onPressed: () {
                  context
                      .read<WidgetController>()
                      .pushWidget(const StaffView());
                  context.read<TitleController>().setTitle("Staffs");
                  context.read<SideBarController>().changeSelected(2);
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
