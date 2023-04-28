import '../../../../exports/exports.dart';

class AddStream extends StatefulWidget {
  const AddStream({super.key});

  @override
  State<AddStream> createState() => _AddStreamState();
}

class _AddStreamState extends State<AddStream> {
  // text controllers
   String streamError = "";
  final TextEditingController streamController = TextEditingController();
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
                child: Text("Add a stream",
                    style: TextStyles(context).getTitleStyle()),
              ),
              CommonTextField(
                icon: Icons.home_work_outlined,
                hintText: "Stream Name",
                controller: streamController,
                contentPadding:const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 15, left: 15),
                validate: (valid) {
                  setState(() {
                    streamError = "Stream "
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
                  buttonText: "Save stream",
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 15, left: 15),
                  onTap: () {
                    // _stepText = [];
                    Map<String, dynamic> data = {
                      "school":context.read<SchoolController>().state['id'],
                      "stream_name":streamController.text,
                    };
                    debugPrint("Saved data $data");
                    showProgress(context, msg: 'Adding stream in progress');
                    // saving class data to db
                    Client()
                        .post(Uri.parse(AppUrls.addStream), body: data)
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
