// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class OvertimeReports extends StatefulWidget {
  final String? overtimeStatus;
  const OvertimeReports({super.key,this.overtimeStatus});

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
    Provider.of<MainController>(context,listen: false).fetchPendingOvertime
      (widget.overtimeStatus ?? "Pending");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //invoke new overtimes
    Provider.of<MainController>(context,listen: false).fetchPendingOvertime
      (widget.overtimeStatus ?? "Pending");
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
          Expanded(

            child: Data_Table(
              columns: [
                DataColumn(
                  label: Text("Guardian Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Amount "),
                ),
                DataColumn(
                  label: Text("Staff"),
                ),
                DataColumn(
                  label: Text("Status"),),
              ],
              rows: List.generate(
                context.watch<MainController>().pendingOvertime.length,
                (index) => overtimeDataRow(context.watch<MainController>().pendingOvertime
                [index], index),
              ),
            ),
          ),
        ],
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
                child: Text(overtimeModel.student),
              ),
            ],
          ),
        ),
        DataCell(Text(overtimeModel.createdAt.toString())),
        DataCell(Text(overtimeModel.overtimeCharge.toString())),
        DataCell(Text(overtimeModel.guardian)),
        DataCell(Text(overtimeModel.status)),
        if (context.read<SchoolController>().state['role'] == 'Finance')
          DataCell(buildActionButtons("i", context)),
      ],
    );
  }
}
