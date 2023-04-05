// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class OvertimeReports extends StatefulWidget {
  final String? overtimeStatus;
  final String? label;
  const OvertimeReports({super.key, this.overtimeStatus, this.label});

  @override
  State<OvertimeReports> createState() => _OvertimeReportsState();
}

class _OvertimeReportsState extends State<OvertimeReports>
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
    Provider.of<MainController>(context, listen: false)
        .fetchPendingOvertime(widget.overtimeStatus ?? "Pending");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //invoke new overtimes
    Provider.of<MainController>(context, listen: false)
        .fetchPendingOvertime(widget.overtimeStatus ?? "Pending");
    return SizedBox(
      width: size.width,
      height: size.width / 2.5,
      child: Data_Table(
        header: Text(
          context.read<SchoolController>().state['role'] == 'Admin'
              ? widget.label ?? "Reports"
              : "Overtimes pending",
          style: TextStyles(context).getTitleStyle(),
        ),
        columns: [
          DataColumn(
            label: Text("Student Name"),
          ),
          DataColumn(
            label: Text("Picked by"),
          ),
          DataColumn(
            label: Text("Standard PickUp"),
          ),
          DataColumn(
            label: Text("Actual PickUp"),
          ),
          DataColumn(
            label: Text("Authorized by"),
          ),
          DataColumn(
            label: Text("Interval"),
          ),
          DataColumn(
            label: Text("Overtime rate"),
          ),
          DataColumn(
            label: Text("Overtime charge"),
          ),
          if (context.read<SchoolController>().state['role'] == 'Finance')
            DataColumn(
              label: Text("Actions"),
            ),
        ],
        empty: SizedBox(
          height: MediaQuery.of(context).size.width / 7,
          child: NoDataWidget(
              text: "No ${widget.overtimeStatus} overtime "
                  "recorded "
                  ""),
        ),
        rows: List.generate(
          context.watch<MainController>().pendingOvertime.length,
          (index) => overtimeDataRow(
              context.watch<MainController>().pendingOvertime[index], index),
        ),
      ),
    );
  }

  // row data
  DataRow overtimeDataRow(OvertimeModel overtimeModel, int i) {
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
                child: Text("${overtimeModel.student.studentFname} ${overtimeModel.student.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text("${overtimeModel.guardian.guardianFname} ${overtimeModel.guardian.guardianLname}")),
        DataCell(Text(overtimeModel.settings.pickUpEndTime.toString())),
        DataCell(Text(overtimeModel.settings.overtimeRate.toString())),
        DataCell(Text("${overtimeModel.staff.staffFname} ${overtimeModel.staff.staffLname}")),
        DataCell(Text(overtimeModel.settings.overtimeInterval.toString())),
        DataCell(Text(overtimeModel.settings.overtimeRate.toString())),
        DataCell(Text(overtimeModel.overtimeCharge.toString())),
        // DataCell(Text(overtimeModel.status)),
        if (context.read<SchoolController>().state['role'] == 'Finance')
          DataCell(buildActionButtons(context, () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 3,
                      child: Center(child: Text("Edit Staff")),
                    ),
                  );
                });
          }, () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 3,
                      child: Center(
                        child: Text("Delete Staff"),
                      ),
                    ),
                  );
                });
          })),
      ],
    );
  }

  _buildButton() {
    return DataCell(ElevatedButton(onPressed: () {  },
    child: Text("Clear"),),);
  }
}
