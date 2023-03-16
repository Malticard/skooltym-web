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
            "Overtime",
            style: TextStyles(context).getTitleStyle(),
          ),
          SizedBox(
            width: size.width,
            height: size.width / 5,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: size.width * 0.06,
              columns: const [
                DataColumn(
                  label: Text("File Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Size"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
