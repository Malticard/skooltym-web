import '../../../models/DropOffModels.dart';
import '/exports/exports.dart';

class ViewDropOffs extends StatefulWidget {
  const ViewDropOffs({super.key});

  @override
  State<ViewDropOffs> createState() => _ViewDropOffsState();
}

class _ViewDropOffsState extends State<ViewDropOffs> {
  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];
  List<DropOff> drop_offs = [];
  final _controller = PaginatorController();
  int _currentPage = 1;
  int rowsPerPage = 20;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width / 2.39,
      child: StreamBuilder(
        stream: fetchDropOffs(context.read<SchoolController>().state['school'])
            .asStream(),
        builder: (context, snapshot) {
          var drops = snapshot.data;
          drop_offs = drops!.results;
          return CustomDataTable(
            paginatorController: _controller,
            onPageChanged: (page) {
              setState(() {
                _currentPage = (page ~/ rowsPerPage) + 1;
              });
            },
            onRowsPerPageChanged: (rows) {
              setState(() {
                rowsPerPage = rows ?? 20;
              });
            },
            loaderText: "DropOff Data",
            header: Row(
              children: [
                Text(
                  "Available Drops Recorded",
                  style: TextStyles(context).getTitleStyle(),
                ),
                if (!Responsive.isMobile(context))
                  Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                if (drop_offs.isNotEmpty)
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
              child: const NoDataWidget(text: "No drop offs captured yet"),
            ),
            source: DropOffDataSource(
                dropOffModel: drop_offs,
                context: context,
                currentPage: _currentPage,
                totalDocuments: drops.totalDocuments),
          );
        },
      ),
    );
  }
}
