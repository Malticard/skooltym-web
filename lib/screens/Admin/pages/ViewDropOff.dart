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
    BlocProvider.of<DropOffController>(context).getDropOff(context);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<DropOffController>(context).getDropOff(context);
    return SizedBox(
      width: size.width,
      height: size.width / 2.39,
      child: BlocBuilder<DropOffController, List<DropOffModel>>(
        builder: (context, dropOffs) {
          return CustomDataTable(
            loaderText: "DropOff Data",
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
              child:  const NoDataWidget(text: "No drop offs captured yet"),
            ),
            source: DropOffDataSource(dropOffModel: dropOffs, context: context),
          );
        },
      ),
    );
  }
}
