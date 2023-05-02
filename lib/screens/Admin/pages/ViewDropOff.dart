import '/exports/exports.dart';

class ViewDropOffs extends StatefulWidget {
  const ViewDropOffs({super.key});

  @override
  State<ViewDropOffs> createState() => _ViewDropOffsState();
}

class _ViewDropOffsState extends State<ViewDropOffs>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;

  @override
  void didChangeDependencies() {
    BlocProvider.of<DropOffController>(context)
        .getDropOff(context);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];
  DataRow _dataRow(DropOffModel dropOff, int i) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.network(
                AppUrls.liveImages + (dropOff.studentName.studentProfilePic),
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                    "${dropOff.studentName.studentFname} ${dropOff.studentName.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${dropOff.droppedBy.guardianFname} ${dropOff.droppedBy.guardianLname}")),
        DataCell(Text(
            "${dropOff.authorizedBy.staffFname} ${dropOff.authorizedBy.staffLname}")),
        DataCell(Text(dropOff.dropOffTime
            .toString()
            .split(" ")
            .last
           )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<DropOffController>(context)
        .getDropOff(context);
    return SizedBox(
      width: size.width,
      height: size.width / 2.39,
      child: BlocBuilder<DropOffController, List<DropOffModel>>(
        builder: (context, dropOffs) {
          return Data_Table(
            header: Row(
              children: [
                Text(
                  "Available Drops Recorded",
                  style: TextStyles(context).getTitleStyle(),
                ),
                if (!Responsive.isMobile(context))
                  Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                if (context.read<MainController>().dropOffData.isNotEmpty)
                  Expanded(
                    child: SearchField(
                      onChanged: (value) {
                        // Provider.of<MainController>(context, listen: false)
                        //     .searchDropOffs(value ?? "");
                      },
                    ),
                  ),
              ],
            ),
            columns: const [
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
            empty: Center(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 5)),
                  builder: (context, f) {
                    return f.connectionState == ConnectionState.waiting
                        ? const Loader(
                            text: "DropOff data..",
                          )
                        : const NoDataWidget(text: "No drop offs captured yet");
                  }),
            ),
            rows: List.generate(
              dropOffs.length,
              (index) => _dataRow(
                  dropOffs[index],
                  index),
            ),
          );
        },
      ),
    );
  }
}
