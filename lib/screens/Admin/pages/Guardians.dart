// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class ViewGuardians extends StatefulWidget {
  const ViewGuardians({super.key});

  @override
  State<ViewGuardians> createState() => _ViewGuardiansState();
}

class _ViewGuardiansState extends State<ViewGuardians> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).staffUpdate();
    super.didChangeDependencies();
  }

  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];
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
                            child: AddGuardian(),
                          ),
                        );
                      });
                },
                icon: Icon(Icons.add),
                label: Text("Add Guardian"),
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
          context.watch<MainController>().staffData.length,
          (index) =>
              _dataRow(context.watch<MainController>().staffData[index], index),
        ),
      ),
    );
  }
}
