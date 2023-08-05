import '/exports/exports.dart';

class UpdateClass extends StatefulWidget {
  final String className;
  final List<String> streams;
  final String id;
  const UpdateClass({
    super.key,
    required this.className,
    required this.streams,
    required this.id,
  });

  @override
  State<UpdateClass> createState() => _UpdateClassState();
}

class _UpdateClassState extends State<UpdateClass> {
  // text controllers
  final streamErrorController = TextEditingController();
  late final TextEditingController _classController;
  String _updatedStreams = "";

  @override
  void initState() {
    setState(() {
      _updatedStreams = widget.streams.join(",");
    });

    _classController = TextEditingController(text: widget.className);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
       Provider.of<StreamsController>(context,listen: true).getStreams(context.read<SchoolController>().state['school']);
    return Dialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Theme.of(context).canvasColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3.4,
        child: Column(
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
              builder: (context, s,x) {
                return CommonMenuWidget(
                  // fieldColor: Colors.transparent,
                  onChange: (v) {
                    if (v != null) {
                      setState(() {
                        _updatedStreams = json.decode(v).join(",");
                      });
                    }
                  },
                  hint: "Attach streams",
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 10, left: 10),
                  data: 
                      s.streams
                      .map((e) => e.id)
                      .toList(),
                  dropdownList:s.streams
                      .map((e) => e.streamName)
                      .toList(),
                );
              },
            ),
            const SizedBox(height: defaultPadding),
            CommonButton(
              buttonText: "Save class",
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
              onTap: () {
                Map<String, dynamic> data = {
                  "school": context.read<SchoolController>().state['school'],
                  "class_name": _classController.text,
                  "class_streams": _updatedStreams
                };
                // debugPrint("Saved data $data");
                showProgress(context,
                    msg: 'Updating ${widget.className} in progress');
                // saving class data to db
                Client()
                    .patch(Uri.parse(AppUrls.updateClass + widget.id),
                        body: data)
                    .then((value) {
                  debugPrint("Updated data ${value.body}");
                  if (value.statusCode == 200) {
                    Routes.popPage(context);
                    showMessage(
                        context: context,
                        msg: "${widget.className} updated successfully",
                        type: 'success',
                        duration: 6);
                  } else {
                    Routes.popPage(context);
                    showMessage(
                        context: context,
                        msg: 'Class not updated.',
                        type: 'danger',
                        duration: 6);
                  }
                }).whenComplete(() {
                  Routes.popPage(context);
                });
                // done saving class data to db
              },
            )
          ],
        ),
      ),
    );
  }
}
