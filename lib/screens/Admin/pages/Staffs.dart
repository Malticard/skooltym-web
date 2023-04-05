// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class StaffView extends StatefulWidget {
  const StaffView({super.key});

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).staffUpdate(context);
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
        DataCell(buildActionButtons(context, () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                         width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 2.3,
                    child: UpdateStaff(staff: staffModel),
                  ),
                );
              });
        }, () {
          // delete functionality
          showDialog(
              context: context,
              builder: (context) {
            return CommonDelete(title: '${staffModel.staffFname} ${staffModel.staffLname}', url: AppUrls.deleteStaff + staffModel.id,);
              });
        })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Provider.of<MainController>(context).staffUpdate();
    return SizedBox(
      height: size.width / 2.5,
      child: Data_Table(
        header: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (context.watch<MainController>().staffData.length > 0)
                 Expanded(child: SearchField(onChanged: (value){
                  debugPrint("search value $value");
                    context.read<MainController>().searchStaff(value!);
                    debugPrint("search result ${context.read<MainController>().staffData[0].staffFname}");
                },)),
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
                        return AddStaff();
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
        empty: NoDataWidget(text: "You currently have no staff records"),
        rows: List.generate(
          context.watch<MainController>().staffData.length,
          (index) =>
              _dataRow(context.watch<MainController>().staffData[index], index),
        ),
      ),
    );
  }
}
