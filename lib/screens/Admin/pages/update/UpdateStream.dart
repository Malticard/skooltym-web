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
  late final TextEditingController _updateStreamController;
  @override
  void initState() {
    _updateStreamController = TextEditingController(text: widget.stream);
    super.initState();
  }

  @override
  void dispose() {
    _updateStreamController.dispose();
    super.dispose();
  }

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
              child: Text("Update ${widget.stream}",
                  style: TextStyles(context).getTitleStyle()),
            ),
            CommonTextField(
              icon: Icons.home_work_outlined,
              hintText: "Stream Name",
              controller: _updateStreamController,
              contentPadding:
                  const EdgeInsets.only(top: 10, left: 10, bottom: 5),
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
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
                buttonText: "Update stream",
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 15, left: 15),
                onTap: () {
                  // _stepText = [];
                  Map<String, dynamic> data = {
                    "school": context.read<SchoolController>().state['id'],
                    "stream_name": _updateStreamController.text,
                  };
                  debugPrint("Saved data $data");
                  showProgress(context, msg: 'Updating stream in progress');
                  // saving class data to db
                  Client()
                      .patch(Uri.parse(AppUrls.updateStream + widget.id),
                          body: data)
                      .then((value) {
                    if (value.statusCode == 200) {
                      Routes.popPage(context);
                      showMessage(
                          context: context,
                          msg: "Stream updated successfully",
                          type: 'info',
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
        ),
      ),
    );
  }
}
