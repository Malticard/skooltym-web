import '/exports/exports.dart';

class UpdateStream extends StatefulWidget {
  final String stream;
  final String id;
  const UpdateStream({super.key, required this.stream, required this.id});

  @override
  State<UpdateStream> createState() => _UpdateStreamState();
}

class _UpdateStreamState extends State<UpdateStream> {
  // text controllers
  final streamErrorController = TextEditingController();
  late final  TextEditingController _updateStreamController;
  @override
  void initState() {
   _updateStreamController = TextEditingController(text: widget.stream);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Theme.of(context).canvasColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 5,
        child: BlocBuilder<StepperController, StepperModel>(
            builder: (context, inx) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Update ${widget.stream}",
                    style: TextStyles(context).getTitleStyle()),
              ),
              CommonTextField(
                icon: Icons.home_work_outlined,
                hintText: "Stream Name",
                controller: _updateStreamController,
                contentPadding:const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 15, left: 15),
                validate: (valid) {
                  setState(() {
                    streamErrorController.text = "Stream "
                        "is"
                        " required to continue ";
                  });
                  return null;
                },
                // controller: _controllers[index],
                titleText: "Stream Name",
              ),
              const SizedBox(height: defaultPadding),
              CommonButton(
                  buttonText:"Update stream",
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 15, left: 15),
                  onTap: () {
                    // _stepText = [];
                    Map<String, dynamic> data = {
                      "school":context.read<SchoolController>().state['id'],
                      "stream_name": _updateStreamController.text,
                    };
                    debugPrint("Saved data $data");
                    showProgress(context, msg: 'Adding stream in progress');
                    // saving class data to db
                    Client()
                        .patch(Uri.parse(AppUrls.updateStream + widget.id), body: data)
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
                    }).whenComplete(() {
                      Routes.popPage(context);
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
