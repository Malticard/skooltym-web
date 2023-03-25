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
    Provider.of<MainController>(context).staffUpdate();
    return Center(
      child: Data_Table(
        header: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
        rows: List.generate(
          context.read<MainController>().staffData.length,
          (index) =>
              _dataRow(context.read<MainController>().staffData[index], index),
        ),
      ),
    );
  }
}
