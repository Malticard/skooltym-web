import '/exports/exports.dart';

class UpdateClass extends StatefulWidget {
  final String className;
  final List<String>? streams;
  final String id;
  const UpdateClass({
    super.key,
    required this.className,
    this.streams,
    required this.id,
  });

  @override
  State<UpdateClass> createState() => _UpdateClassState();
}

class _UpdateClassState extends State<UpdateClass> {
  // text controllers
  final streamErrorController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  String _updatedStreams = "";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Theme.of(context).canvasColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 4,
        child: BlocBuilder<StepperController, StepperModel>(
            builder: (context, inx) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Update ${widget.className}",
                    style: TextStyles(context).getTitleStyle()),
              ),
              CommonTextField(
                icon: Icons.home_work_outlined,
                controller: _classController,
                hintText: "e.g Grade 2",
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
              CommonMenuWidget(
                // fieldColor: Colors.transparent,
                onChange: (v) {
                  setState(() {
                    _updatedStreams = json.decode(v).join(",");
                  });
                },
                hint: "Attach streams",
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 10, left: 10),
                data: context.read<MainController>().streams.map((e) => e.id).toList(),
                dropdownList: context.read<MainController>().streams.map((e) => e.streamName).toList(),
              ),
              const SizedBox(height: defaultPadding),
              CommonButton(
                  buttonText: "Save class",
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 15, left: 15),
                  onTap: () {
                    Map<String, dynamic> data = {
                      "school": context.read<SchoolController>().state['id'],
                      "class_name": _classController.text,
                      "class_streams": _updatedStreams
                    };
                    debugPrint("Saved data $data");
                    showProgress(context, msg: 'Adding stream in progress');
                    // saving class data to db
                    Client()
                        .patch(Uri.parse(AppUrls.updateClass + widget.id),
                            body: data)
                        .then((value) {
                      if (value.statusCode == 200) {
                        Routes.popPage(context);
                        showMessage(
                            context: context,
                            msg: "Stream added successfully",
                            type: 'success',
                            duration: 6);
                      } else {
                        Routes.popPage(context);
                        showMessage(
                            context: context,
                            msg: 'Stream not added',
                            type: 'danger',
                            duration: 6);
                      }
                    });
                    // done saving class data to db
                  })
            ],
          );
        }),
      ),
    );
  }
}
