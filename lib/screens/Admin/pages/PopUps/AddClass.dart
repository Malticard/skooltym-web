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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<FetchStudentsController>(context, listen: false)
        .getStudents(context.read<SchoolController>().state['school']);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchStudentsController>(context, listen: false)
        .getStudents(context.read<SchoolController>().state['school']);

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
                padding:
                    const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
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
              Consumer<StreamsController>(
                builder: (context,controller,widget) {
                  return CommonMenuWidget(
                    // fieldColor: Colors.transparent,
                    onChange: (v) {
                      setState(() {
                        _selectedStreams = json
                            .decode(v)
                            .join(","); // [jjjjk].join(",") => j,j,j,j
                      });
                    },
                    hint: "Attach streams",
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 10),
                    data: 
                        controller.streams
                        .map((e) => e.id)
                        .toList(),
                    dropdownList: controller.streams
                        .map((e) => e.streamName)
                        .toList(),
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
                      "school": context.read<SchoolController>().state['school'],
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
