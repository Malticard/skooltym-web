import '/exports/exports.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  String _selectedStreams = "";
  // text controllers
  final streamErrorController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

  // stream controller
  StreamController<List<StreamModel>> _streamController =
      StreamController<List<StreamModel>>();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchRealTimeData();
  }

  @override
  void dispose() {
    if (_streamController.hasListener) {
      _streamController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void fetchRealTimeData() async {
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var streams = await fetchStreams(
            context.read<SchoolController>().state['school']);
        _streamController.add(streams);
      }
      // Listen to the stream and update the UI
      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          var streams = await fetchStreams(
              context.read<SchoolController>().state['school']);
          _streamController.add(streams);
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Theme.of(context).canvasColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Add a class",
                    style: TextStyles(context).getTitleStyle()),
              ),
              CommonTextField(
                icon: Icons.home_work_outlined,
                hintText: "Class Name",
                controller: _classController,
                contentPadding:
                    const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 15, left: 15),
                validate: (valid) {
                  setState(() {
                    streamErrorController.text = "Class "
                        "is"
                        " required to continue ";
                  });
                  return null;
                },
                // controller: _controllers[index],
                titleText: "Class Name",
              ),
              StreamBuilder(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  var controller = snapshot.data ?? [];
                  return CommonMenuWidget(
                    // fieldColor: Colors.transparent,
                    onChange: (v) {
                      if (v != null && v.isNotEmpty) {
                        setState(() {
                          _selectedStreams = json
                              .decode(v)
                              .join(","); // [jjjjk].join(",") => j,j,j,j
                        });
                      }
                    },
                    hint: "Attach streams",
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 10),
                    data: controller.map((e) => e.id).toList(),
                    dropdownList: controller.map((e) => e.streamName).toList(),
                  );
                },
              ),
              const SizedBox(height: defaultPadding),
              CommonButton(
                  buttonText: "Save class",
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 15, left: 15),
                  onTap: () {
                    // _stepText = [];
                    Map<String, dynamic> data = {
                      "school":
                          context.read<SchoolController>().state['school'],
                      "class_name": _classController.text,
                      "class_streams": _selectedStreams
                    };
                    debugPrint("Saved data $data");
                    showProgress(context, msg: 'Adding stream in progress');
                    // saving class data to db
                    Client()
                        .post(Uri.parse(AppUrls.addClass), body: data)
                        .then((value) {
                      if (value.statusCode == 200) {
                        Routes.popPage(context);
                        showMessage(
                            context: context,
                            msg: "Class added successfully",
                            type: 'success',
                            duration: 6);
                      } else {
                        Routes.popPage(context);
                        showMessage(
                            context: context,
                            msg: 'Class not added',
                            type: 'danger',
                            duration: 6);
                      }
                    }).whenComplete(() {
                      Routes.popPage(context);
                    });
                    // done saving class data to db
                  })
            ],
          ),
        ),
      ),
    );
  }
}
