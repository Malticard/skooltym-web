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

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  //text controllers
  final List<TextEditingController> _ctrl =
      List.generate(50, (n) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    // responsive dimensions
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<ClassController>(context).getClasses(context);

    return Stack(
      children: [
        SizedBox(
          // width: size.width,
          height: size.width / 2.39,
          child: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 3)),
              builder: (context, c) {
                return c.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: Loader(text: "Classes data"),
                      )
                    : BlocBuilder<ClassController, List<ClassModel>>(
                        builder: (context, class_) {
                          return Data_Table(
                            header: Row(
                              children: [
                                const Text(
                                  "Classes",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
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
                            rows: List.generate(class_.length, (index) {
                              return DataRow(
                                cells: [
                                  DataCell(Text("${index + 1}")),
                                  DataCell(Text(class_[index].className)),
                                  DataCell(
                                    buildActionButtons(
                                      context,
                                      () => showDialog(
                                        context: context,
                                        builder: (context) => UpdateClass(
                                          streams: class_[index].classStreams
                                              .map((e) => e.id)
                                              .toList(),
                                          className: class_[index].className,
                                          id: class_[index].id,
                                        ),
                                      ),
                                      () => showDialog(
                                        context: context,
                                        builder: (context) => CommonDelete(
                                          title: class_[index].className,
                                          url: AppUrls.deleteClass +
                                              class_[index].id,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            empty: const Center(
                              child: Text("No classes added.."),
                            ),
                          );
                        },
                      );
              }),
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
