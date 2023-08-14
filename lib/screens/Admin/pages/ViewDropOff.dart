import '../../../models/DropOffModels.dart';
import '../../../tools/searchHelpers.dart';
import '/exports/exports.dart';

class ViewDropOffs extends StatefulWidget {
  const ViewDropOffs({super.key});

  @override
  State<ViewDropOffs> createState() => _ViewDropOffsState();
}

class _ViewDropOffsState extends State<ViewDropOffs> {
  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];
  List<DropOff> drop_offs = [];
  String? _query;
  final _controller = PaginatorController();
  int _currentPage = 1;
  int rowsPerPage = 20;

  // REALTIME DATA POLLING

  // stream controller
  StreamController<DropOffModel> _dropOffController =
      StreamController<DropOffModel>();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchRealTimeData();
  }

  @override
  void dispose() {
    if (_dropOffController.hasListener) {
      _dropOffController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void fetchRealTimeData() async {
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var drops = await fetchDropOffs(
          context.read<SchoolController>().state['school'],
          page: _currentPage,
          limit: rowsPerPage,
        );
        _dropOffController.add(drops);
      }
      // Listen to the stream and update the UI
      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_query != null) {
            var drops = await searchDropOffs(
              context.read<SchoolController>().state['school'],
              _query!,
            );
            _dropOffController.add(drops);
          } else {
            var drops = await fetchDropOffs(
              context.read<SchoolController>().state['school'],
              page: _currentPage,
              limit: rowsPerPage,
            );
            _dropOffController.add(drops);
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width / 2.39,
      child: StreamBuilder(
        stream: _dropOffController.stream,
        builder: (context, snapshot) {
          var drops = snapshot.data;
          drop_offs = drops?.results ?? [];
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
                        setState(() {
                          _query = value;
                        });
                      },
                    ),
                  ),
              ],
            ),
            columns: [
              DataColumn(
                label: Text(
                  "Student Profile",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Student Name",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Dropped by",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Cleared by",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Date",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Time Of DropOff",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
            ],
            empty: !snapshot.hasData
                ? Loader(
                    text: "DropOffs ..",
                  )
                : Center(
                    child:
                        const NoDataWidget(text: "No drop offs captured yet"),
                  ),
            source: DropOffDataSource(
                dropOffModel: drop_offs,
                context: context,
                currentPage: _currentPage,
                paginatorController: _controller,
                totalDocuments: drops?.totalDocuments ?? 0),
          );
        },
      ),
    );
  }
}
