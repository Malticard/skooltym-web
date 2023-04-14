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
    // Provider.of<MainController>(context, listen: false)
    //     .fetchPendingOvertime(widget.overtimeStatus ?? "Pending");
    // ies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //invoke new overtimes
    Provider.of<MainController>(context, listen: false)
        .fetchPendingOvertime(widget.overtimeStatus ?? "Pending", context);
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
          const DataColumn(
            label: Text(
              "Student Name",
              style: TextStyle(fontSize: 13),
            ),
          ),
          const DataColumn(
            label: Text("Picked By", style: TextStyle(fontSize: 13)),
          ),
          const DataColumn(
            label: SizedBox(
                width: 800,
                child: Text("Default\nPickUpTime",
                    style: TextStyle(fontSize: 13))),
          ),
          const DataColumn(
            label:
                Text("Current \nPickUp Time", style: TextStyle(fontSize: 13)),
          ),
          const DataColumn(
            label: Text("Authorized by", style: TextStyle(fontSize: 13)),
          ),
          const DataColumn(
            label: Text("Interval(mins)", style: TextStyle(fontSize: 13)),
          ),
          const DataColumn(
            label: Text("Overtime rate", style: TextStyle(fontSize: 13)),
          ),
          const DataColumn(
            label: Text("Overtime\ncharge", style: TextStyle(fontSize: 13)),
          ),
          if (context.read<SchoolController>().state['role'] == 'Finance')
            const DataColumn(
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(overtimeModel.student.username,
                    style: const TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ),
         DataCell(Text(
            "${overtimeModel.guardian.guardianFname} ${overtimeModel.guardian.guardianLname}")),
         DataCell(Text(overtimeModel.settings.pickUpEndTime.toString())),
         DataCell(Text(overtimeModel.settings.pickUpEndTime.toString())),
         DataCell(Text(
            "${overtimeModel.staff.staffFname} ${overtimeModel.staff.staffLname}")),
         DataCell(
            Text(overtimeModel.settings.overtimeInterval.toString())),
         DataCell(Text(overtimeModel.settings.overtimeRate.toString())),
         DataCell(Text("50000")),
        // DataCell(Text(overtimeModel.status)),
        if (context.read<SchoolController>().state['role'] == 'Finance')
          DataCell(buildActionButtons(context, () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 6,
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: Column(
                            children: [
                              Center(child: Text("Clear overtime",style: TextStyles(context).getRegularStyle(),),),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(children: [ Text("Clear with cash",style: TextStyles(context).getRegularStyle(),)],),
                              ),
                              Row(children: [ Text("Clear with comment",style: TextStyles(context).getRegularStyle()),],),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonButton(
                                  height: 40,
                                  padding: const EdgeInsets.only(left: 40,right: 40),
                                  buttonText: "Clear",
                                  onTap: () {},
                                 
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      child: const Center(
                        child: Text("Delete"),
                      ),
                    ),
                  );
                });
          })),
      ],
    );
  }

  _buildButton() {
    return DataCell(
      ElevatedButton(
        onPressed: () {},
        child: const Text("Clear"),
      ),
    );
  }
}
