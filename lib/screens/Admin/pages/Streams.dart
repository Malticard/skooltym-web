// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class Streams extends StatefulWidget {
  const Streams({super.key});

  @override
  State<Streams> createState() => _StreamsState();
}

class _StreamsState extends State<Streams> {
  @override
  void initState() {
    super.initState();
  }
  // late List<TextEditingController> _ctrl;

  @override
  void didChangeDependencies() {
    // Provider.of<MainController>(context)
    //     .staffUpdate(context.read<SchoolController>().state['school']);
    Provider.of<MainController>(context)
        .fetchStreams(context.read<SchoolController>().state['school']);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];

  // List<String> _stepText = <String>[];

  int currentStep = 0;
  final EdgeInsets _padding = const EdgeInsets.only(right: 0, left: 0);
  final streamErrorController = TextEditingController();
  //text controllers
  @override
  Widget build(BuildContext context) {
    Provider.of<MainController>(context,listen: false)
        .fetchStreams(context.read<SchoolController>().state['school']);
    // responsive dimensions
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 2.39,
          child: Data_Table(
            header: Row(
              children: [
                const Text(
                  "Streams",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddStream(),
                    );
                  },
                  label: const Text("Add Stream"),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            columns: const [
              DataColumn(
                label: Text("#"),
              ),
              DataColumn(
                label: Text("Stream"),
              ),
              DataColumn(
                label: Text("Action"),
              ),
            ],
            rows: List.generate(context.read<MainController>().streams.length,
                (index) {
              // debugPrint(
              //     "Classes > ${context.read<MainController>().classes.length}");
              return DataRow(
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(
                    Text(context
                        .read<MainController>()
                        .streams[index]
                        .streamName),
                  ),
                  DataCell(buildActionButtons(
                    context,
                    // update a stream
                    () => showDialog(
                        builder: (context) {
                          return UpdateStream(
                            stream: context
                                .read<MainController>()
                                .streams[index]
                                .streamName,
                            id: context
                                .read<MainController>()
                                .streams[index]
                                .id,
                          );
                        },
                        context: context),
                    // delete a stream
                    () => showDialog(
                      context: context,
                      builder: (context) => CommonDelete(
                        title: context
                            .read<MainController>()
                            .streams[index]
                            .streamName,
                        url: AppUrls.deleteClass +
                            context.read<MainController>().streams[index].id,
                      ),
                    ),
                  )),
                ],
              );
            }),
            empty: const Center(
              child: Text("No Streams added.."),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const Text("Continue to add classes"),
              TextButton(
                onPressed: () {
                  context.read<WidgetController>().pushWidget(const Classes());
                  context.read<TitleController>().setTitle("Classes");
                  context.read<SideBarController>().changeSelected(4);
                },
                child: Text(
                  "Click here",
                  style: TextStyles(context).getRegularStyle(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
