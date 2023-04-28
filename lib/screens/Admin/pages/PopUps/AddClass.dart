import '/exports/exports.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  // text controllers
  final streamErrorController = TextEditingController();
  final TextEditingController streamController = TextEditingController();
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
                child: Text("Add a class",
                    style: TextStyles(context).getTitleStyle()),
              ),
              CommonTextField(
                icon: Icons.home_work_outlined,
                hintText: "Class Name",
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
                onChange: (v) {},
                hint: "Attach streams",
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 10, left: 10),
                data: [],
                dropdownList: [],
              ),
              const SizedBox(height: defaultPadding),
              CommonButton(
                  buttonText: "Save class",
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 15, left: 15),
                  onTap: () {
                    // _stepText = [];
                    Map<String, dynamic> data = {};
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
