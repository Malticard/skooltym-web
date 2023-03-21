// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class OvertimeReports extends StatefulWidget {
  const OvertimeReports({super.key});

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
                  label: Text("Status"),
                ),
                if (context.read<SchoolController>().state['role'] == 'Finance')
                  DataColumn(
                    label: Text("Action"),
                  ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => overtimeDataRow(demoRecentFiles[index], index),
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
              SvgPicture.asset(
                fileInfo.icon!,
                height: 30,
                width: 30,
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
        DataCell(Text("Pending")),
        if (context.read<SchoolController>().state['role'] == 'Finance')
          DataCell(buildActionButtons(i)),
      ],
    );
  }

  // build Action Buttons
  Widget buildActionButtons(int id) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        TextButton(
          onPressed: () {
            showAppDialog(context,
                title:
                    "Are you sure you want to delete ${demoRecentFiles[id].title}?");
          },
          child: Icon(Icons.delete_outline_rounded, color: Colors.white),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }
}
