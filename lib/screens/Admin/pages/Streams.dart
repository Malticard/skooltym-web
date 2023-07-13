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
    // initStreams();
    super.initState();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];

  int currentStep = 0;
  final streamErrorController = TextEditingController();
  // void initStreams() async {
  //   var stream = Provider.of<StreamsController>(context, listen: false);
  //   await stream.getStreams(context.read<SchoolController>().state['school']);
  // }

  //text controllers
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 2.39,
          child: StreamBuilder(
              stream:
                  fetchStreams(context.read<SchoolController>().state['school'])
                      .asStream(),
              builder: (context, snap) {
                var response = snap.data;
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Loader(
                      text: "Streams data",
                    ),
                  );
                } else {
                  return Data_Table(
                    header: Row(
                      children: [
                        const Text(
                          "Streams",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                    rows: List.generate(response!.length, (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text("${index + 1}")),
                          DataCell(
                            Text(response![index].streamName),
                          ),
                          DataCell(buildActionButtons(
                            context,
                            // update a stream
                            () => showDialog(
                                builder: (context) {
                                  return UpdateStream(
                                    stream: response[index].streamName,
                                    id: response[index].id,
                                  );
                                },
                                context: context),
                            // delete a stream
                            () => showDialog(
                              context: context,
                              builder: (context) => CommonDelete(
                                title: response[index].streamName,
                                url: AppUrls.deleteStream + response[index].id,
                              ),
                            ),
                          )),
                        ],
                      );
                    }),
                    empty: const Center(
                      child: Text("No Streams added.."),
                    ),
                  );
                }
              }),
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
