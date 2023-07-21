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
    initStreams();
    super.initState();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];

  int currentStep = 0;
  final streamErrorController = TextEditingController();
  void initStreams() async {
    var stream = Provider.of<StreamsController>(context, listen: false);
    await stream.getStreams(context.read<SchoolController>().state['school']);
  }

  //text controllers
  @override
  Widget build(BuildContext context) {
    initStreams();
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 2.39,
          
          child: Consumer<StreamsController>(
              builder: (context, controller, widget) {
            return CustomDataTable(
              loaderText: "Streams data",
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
              empty: const Center(
                child: Text("No Streams added.."),
              ),
              source: StreamDataSource(
                  context: context, streamModel: controller.streams),
            );
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
