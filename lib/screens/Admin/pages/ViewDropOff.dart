// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class ViewDropOffs extends StatefulWidget {
  const ViewDropOffs({super.key});

  @override
  State<ViewDropOffs> createState() => _ViewDropOffsState();
}

class _ViewDropOffsState extends State<ViewDropOffs>
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

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).availableDropOffs();
    super.didChangeDependencies();
  }

  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];
  DataRow _dataRow(DropOffModel dropOff, int i) {
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
                child: Text(dropOff.studentName),
              ),
            ],
          ),
        ),

        // DataCell(
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        //     child: Text(dropOff.studentName),
        //   ),
        // ),
        DataCell(Text(dropOff.droppedBy)),
        DataCell(Text(dropOff.dropOffTime)),
        DataCell(Text(dropOff.authorizedBy)),
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
            "Available Drops Recorded",
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
                  label: Text("Dropped by"),
                ),
                DataColumn(
                  label: Text("Cleared by"),
                ),
                DataColumn(
                  label: Text("Time Of DropOff"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => _dataRow(
                    context.watch<MainController>().dropOffData[index], index),
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
