// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class Classes extends StatefulWidget {
  const Classes({super.key});

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  @override
  void initState() {
    super.initState();
  }
  // late List<TextEditingController> _ctrl;

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context)
        .staffUpdate(context.read<SchoolController>().state['school']);
    Provider.of<MainController>(context)
        .fetchClasses(context.read<SchoolController>().state['school']);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  //text controllers
  final List<TextEditingController> _ctrl =
      List.generate(50, (n) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    // responsive dimensions
    Size size = MediaQuery.of(context).size;

    // Provider.of<MainController>(context)
    //     .staffUpdate(context.read<SchoolController>().state['school']);
    // Provider.of<MainController>(context)
    //     .fetchClasses(context.read<SchoolController>().state['school']);
    return Stack(
      children: [
        SizedBox(
          // width: size.width,
          height: size.width / 2.39,
          child: Data_Table(
            header: Row(
              children: [
                const Text(
                  "Classes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddClass(),
                    );
                  },
                  label: const Text("Add Class"),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            columns: const [
              DataColumn(
                label: Text("No."),
              ),
              DataColumn(
                label: Text("Class"),
              ),
              DataColumn(
                label: Text("Action"),
              ),
            ],
            rows: List.generate(context.watch<MainController>().classes.length,
                (index) {
              return DataRow(
                cells: [
                  DataCell(Text("${index + 1}")),
                  DataCell(Text(context
                      .watch<MainController>()
                      .classes[index]
                      .className)),
                  DataCell(
                    buildActionButtons(
                      context,
                      () => showDialog(
                        context: context,
                        builder: (context) => UpdateClass(
                          streams: context
                              .read<MainController>()
                              .classes[index]
                              .classStreams,
                          className: context
                              .watch<MainController>()
                              .classes[index]
                              .className,
                          id: context.read<MainController>().classes[index].id,
                        ),
                      ),
                      () => showDialog(
                        context: context,
                        builder: (context) => CommonDelete(
                          title: context
                              .read<MainController>()
                              .classes[index]
                              .className,
                          url: AppUrls.deleteClass +
                              context.read<MainController>().classes[index].id,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            empty: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 5)),
                builder: (context, s) {
                  return s.connectionState == ConnectionState.waiting
                      ? const Loader(
                          text: "Classes data",
                        )
                      : const Center(
                          child: Text("No classes added.."),
                        );
                }),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const Text("Continue to add staffs members"),
              TextButton(
                onPressed: () {
                  context
                      .read<WidgetController>()
                      .pushWidget(const StaffView());
                  context.read<TitleController>().setTitle("Staffs");
                  context.read<SideBarController>().changeSelected(2);
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
