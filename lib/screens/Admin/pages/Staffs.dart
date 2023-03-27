// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class Staff extends StatefulWidget {
  const Staff({super.key});

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).staffUpdate();
    super.didChangeDependencies();
  }

  List<String> staffs = ["Staff Name", "Email", "Gender", "Actions"];
  DataRow _dataRow(StaffModel staffModel, int i) {
    return DataRow(
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(staffModel.staffFname),
          ),
        ),
        DataCell(Text(staffModel.staffEmail)),
        DataCell(Text(staffModel.staffGender)),
        DataCell(buildActionButtons(
            "${staffModel.staffFname} ${staffModel.staffLname}", context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<MainController>(context).staffUpdate();
    return SizedBox(
      height: size.width / 2.5,
      child: Data_Table(
        header: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(context.watch<MainController>().staffData.length > 0)
                 const Expanded(child: SearchField()),
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
                            height: MediaQuery.of(context).size.width / 3,
                            child: AddStaff(),
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
        columns: List.generate(
          staffs.length,
          (index) => DataColumn(
            label: Text(
              staffs[index],
            ),
          ),
        ),
        empty: NoDataWidget(text:"You currently have no staff records"),
        rows: List.generate(
          context.watch<MainController>().staffData.length,
          (index) =>
              _dataRow(context.watch<MainController>().staffData[index], index),
        ),
      ),
    );
  }
}
