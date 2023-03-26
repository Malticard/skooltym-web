// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class ViewPickUps extends StatefulWidget {
  const ViewPickUps({super.key});

  @override
  State<ViewPickUps> createState() => _ViewPickUpsState();
}

class _ViewPickUpsState extends State<ViewPickUps>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DataRow _dataRow(PickUpModel pickUp, int i) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.asset(
                StaffIcons.profile,
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(pickUp.studentName),
              ),
            ],
          ),
        ),

        // DataCell(
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        //     child: Text(pickUp.studentName),
        //   ),
        // ),
        DataCell(Text(pickUp.pickedBy)),
        DataCell(Text(pickUp.pickUpTime)),
        DataCell(Text(pickUp.authorizedBy)),
        // DataCell(buildActionButtons(
        //     "${dropOff.guardianFname} ${dropOff.guardianLname}", context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.read<SchoolController>().state['role'] == 'Admin'
                ? "Reports"
                : "Overtimes pending",
            style: TextStyles(context).getTitleStyle(),
          ),
          SizedBox(
            width: size.width,
            height: size.width / 5,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: size.width * 0.06,
              columns: [
                DataColumn(
                  label: Text("Student Name"),
                ),
                DataColumn(
                  label: Text("Class"),
                ),
                DataColumn(
                  label: Text("Cleared by"),
                ),
                DataColumn(
                  label: Text("Time Of PickOff"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => _dataRow(
                    context.watch<MainController>().pickUpData[index], index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // row data
  DataRow overtimeDataRow(RecentFile fileInfo, int i) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.asset(
                StaffIcons.profile,
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(fileInfo.title!),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.date!)),
        DataCell(Text(fileInfo.size!)),
        DataCell(Text(fileInfo.size!)),
      ],
    );
  }
}
