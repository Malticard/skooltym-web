import '/exports/exports.dart';

class AddStream extends StatefulWidget {
  const AddStream({super.key});

  @override
  State<AddStream> createState() => _AddStreamState();
}

class _AddStreamState extends State<AddStream> {
  // text controllers
  String streamError = "";
  final TextEditingController _streamController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Theme.of(context).canvasColor,
      child: SizedBox(
        width: Responsive.isMobile(context) ? size.width : size.width / 3,
        height:
            Responsive.isMobile(context) ? size.width / 1.7 : size.width / 3.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Add a stream",
                  style: TextStyles(context).getTitleStyle()),
            ),
            CommonTextField(
              icon: Icons.home_work_outlined,
              hintText: "Stream Name",
              controller: _streamController,
              contentPadding:
                  const EdgeInsets.only(top: 10, left: 10, bottom: 5),
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
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
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
              onTap: () {
                // _stepText = [];
                Map<String, dynamic> data = {
                  "school": context.read<SchoolController>().state['school'],
                  "stream_name": _streamController.text.trim(),
                };
                debugPrint("Saved data $data");
                showProgress(context, msg: 'Adding stream in progress');
                // saving class data to db
                Client()
                    .post(Uri.parse(AppUrls.addStream), body: data)
                    .then((value) {
                  // print("Addeing => ${value.body}");
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
