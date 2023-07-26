// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class Classes extends StatefulWidget {
  const Classes({super.key});

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  // stream controller
  StreamController<List<ClassModel>> _classController =
      StreamController<List<ClassModel>>();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchStudentsRealTimeData();
  }
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
        AppUrls.getClasses + context.read<SchoolController>().state['school'],
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

      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            _classController.add(classModelFromJson(response.body));
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
              var controller = snapshot.data ?? [];
              return CustomDataTable(
                header: Row(
                  children: [
                    const Text(
                      "Classes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
