// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class StudentsPopUps extends StatefulWidget {
  const StudentsPopUps({super.key});

  @override
  State<StudentsPopUps> createState() => _StudentsPopUpsState();
}

class _StudentsPopUpsState extends State<StudentsPopUps> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).getAllStudents(context);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  DataRow _dataRow(StudentModel studentModel, int i) {
    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                AppUrls.liveImages + studentModel.studentProfilePic,
              ),
            ),
            Text("${studentModel.studentFname} ${studentModel.studentLname}"),
          ],
        )),
        DataCell(Text(studentModel.studentModelClass.className)),
        DataCell(Text(studentModel.studentGender)),
        DataCell(buildActionButtons(context, () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.width / 2,
                    child: UpdateStudent(studentModel: studentModel),
                  ),
                );
              });
        }, () {
          showDialog(
              context: context,
              builder: (context) {
                return CommonDelete(
                    title:
                        '${studentModel.studentFname} ${studentModel.studentLname}',
                    url: AppUrls.deleteStudent + studentModel.id);
              });
        })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<MainController>(context).getAllStudents(context);
    return SizedBox(
      height: size.width / 2.5,
      child: Stack(
        children: [
          Data_Table(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (context.read<MainController>().students.isNotEmpty)
                    Expanded(
                      child: SizedBox(
                        width: 120,
                        child: SearchField(
                          onChanged: (value) {
                            Provider.of<MainController>(context, listen: false)
                                .searchStudents(value ?? "");
                          },
                        ),
                      ),
                    ),
                  if (!Responsive.isMobile(context))
                    Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                  Text(
                    "",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return Dialog(
                  //             child: SizedBox(
                  //               width: MediaQuery.of(context).size.width / 3.5,
                  //               height: MediaQuery.of(context).size.width / 2.2,
                  //               child: const SingleChildScrollView(
                  //                   child: AddStudent()),
                  //             ),
                  //           );
                  //         });
                  //   },
                  //   icon: const Icon(Icons.add),
                  //   label: const Text("Add Student"),
                  // ),
                ],
              ),
            ),
            empty: const NoDataWidget(
              text: "No "
                  "Students added as "
                  "yet...",
            ),
            columns: List.generate(
              staffs.length,
              (index) => DataColumn(
                label: Text(
                  staffs[index],
                ),
              ),
            ),
            rows:  List.generate(
              context.watch<MainController>().sStudent.isEmpty
                  ? context.watch<MainController>().students.length
                  : context.watch<MainController>().sStudent.length,
              (index) => _dataRow(
                  context.watch<MainController>().sStudent.isEmpty
                      ? context.watch<MainController>().students[index]
                      : context.watch<MainController>().sStudent[index],
                  index),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Row(
              children: [
                const Text("Continue to adding guardians"),
                TextButton(
                  onPressed: () {
                    context
                        .read<WidgetController>()
                        .pushWidget(const ViewGuardians());
                    context.read<TitleController>().setTitle("Guardians");
                    context.read<SideBarController>().changeSelected(3);
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
      ),
    );
  }
}