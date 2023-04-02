// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).getAllStudents();
    super.didChangeDependencies();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  DataRow _dataRow(StudentModel studentModel, int i) {
    return DataRow(
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
                "${studentModel.studentFname} ${studentModel.studentLname}"),
          ),
        ),
        DataCell(Text(studentModel.studentClass)),
        DataCell(Text(studentModel.studentGender)),
        DataCell(buildActionButtons(context, () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 3,
                    child: Center(child: Text("Edit Student")),
                  ),
                );
              });
        }, () {
          showDialog(
              context: context,
              builder: (context) {
                return CommonDelete(title: '${studentModel.studentFname} ${studentModel.studentLname}', url: AppUrls.deleteStudent + studentModel.id);
              });
        })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<MainController>(context).getAllStudents();
    return SizedBox(
      height: size.width / 2.5,
      child: Data_Table(
        header: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              if(context.read<MainController>().students.length > 0)
                Expanded(child: SizedBox(width:120,child: SearchField())),
              if (!Responsive.isMobile(context))
                Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
              Text(
                "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.width / 2.6,
                            child: AddStudent(),
                          ),
                        );
                      });
                },
                icon: Icon(Icons.add),
                label: Text("Add Staff"),
              ),
            ],
          ),
        ),
        empty: NoDataWidget(
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
        rows: List.generate(
          context.watch<MainController>().students.length,
          (index) =>
              _dataRow(context.watch<MainController>().students[index], index),
        ),
      ),
    );
  }
}
