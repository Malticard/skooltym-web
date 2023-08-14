import '/exports/exports.dart';

class CommonDelete extends StatefulWidget {
  final String title;
  final String url;
  const CommonDelete({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  State<CommonDelete> createState() => _CommonDeleteState();
}

class _CommonDeleteState extends State<CommonDelete> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        height: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width / 2.7
            : MediaQuery.of(context).size.width / 10,
        child: Column(
          children: [
            const Space(space: 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Are you sure you want to delete ${widget.title}",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
            ),
            const Space(space: 0.032),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        showProgress(context,
                            msg: "Deleting ${widget.title}....");
                        Client().delete(Uri.parse(widget.url)).then((value) {
                          if (value.statusCode == 200 ||
                              value.statusCode == 201) {
                            Routes.popPage(context);
                            showMessage(
                                context: context,
                                type: 'success',
                                msg: '${widget.title} removed successfully..');
                          } else {
                            showMessage(
                                context: context,
                                msg: 'Error ${value.reasonPhrase}',
                                type: 'danger');
                          }
                        }).whenComplete(() {
                          Routes.popPage(context);
                        });
                      },
                      child: Text(
                        "Yes",
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: Colors.red),
                      ),
                    ),
                    TextButton(
                        onPressed: () => Routes.popPage(context),
                        child: const Text("No")),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
