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
    Provider.of<MainController>(context).availableDropOffs(context.read<SchoolController>().state['school']);
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
                child: Text("${dropOff.studentName.studentFname} ${dropOff.studentName.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text(dropOff.droppedBy.guardianFname)),
        DataCell(Text("${dropOff.authorizedBy.staffFname} ${dropOff.authorizedBy.staffLname}")),
        DataCell(Text("7:25 AM")),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.width /2.5,
      child: Data_Table(
        header: Row(
          children: [
            Text(
              "Available Drops Recorded",
              style: TextStyles(context).getTitleStyle(),
            ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            if(context.read<MainController>().dropOffData.length > 0)
              Expanded(child: SearchField()),
          ],
        ),
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
        empty:  NoDataWidget(text:"No drop offs captured yet"),

        rows: List.generate(
          context.watch<MainController>().dropOffData.length,
          (index) => _dataRow(
              context.watch<MainController>().dropOffData[index], index),
        ),
      ),
    );
  }
}
