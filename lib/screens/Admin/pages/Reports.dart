// import 'package:flutter/src/animation/animation_controller.dart';
import '../../../models/OvertimeModel.dart';
import '/exports/exports.dart';

class ClearedOvertime extends StatefulWidget {
  const ClearedOvertime({super.key});

  @override
  State<ClearedOvertime> createState() => _ClearedOvertimeState();
}

class _ClearedOvertimeState extends State<ClearedOvertime>
    with SingleTickerProviderStateMixin {
  int _currentPage = 1;
  Timer? timer;
  int rowsPerPage = 20;
  final PaginatorController _controller = PaginatorController();
  // stream controller
  StreamController<OvertimeModel> _overtimeController =
      StreamController<OvertimeModel>();
  @override
  void initState() {
    super.initState();
    realTimeClearedPayments();
  }

  void realTimeClearedPayments() async {
    // initial data
    var overtimes = await fetchClearedOvertimeData(
        context.read<SchoolController>().state['school'],
        page: _currentPage,
        limit: rowsPerPage);
    _overtimeController.add(overtimes);
    // listen to the stream
    Timer.periodic(Duration(seconds: 1), (timer) async {
      this.timer = timer;
      if (mounted) {
        var overtimes = await fetchClearedOvertimeData(
            context.read<SchoolController>().state['school'],
            page: _currentPage,
            limit: rowsPerPage);
        _overtimeController.add(overtimes);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_overtimeController.hasListener) {
      _overtimeController.close();
    }
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.width / 2.5,
      child: StreamBuilder(
        stream: _overtimeController.stream,
        builder: (context, payload) {
          var overtimeModel = payload.data;
          var _overtimes = overtimeModel?.results ?? [];
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
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   "Payments",
                //   style: TextStyles(context).getTitleStyle(),
                // ),
              ],
            ),
            columns: const [
              DataColumn(
                label: Text(
                  "Student's profile",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              DataColumn(
                label: Text(
                  "Student Name",
                  style: TextStyle(fontSize: 12),
                ),
              ),
               DataColumn(
                label: Text("Guardian Name", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: Text("Cleared By", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: SizedBox(
                    width: 800,
                    child: Text("Date", style: TextStyle(fontSize: 12))),
              ),
              DataColumn(
                label: Text(
                  "Overtime Charge",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
         
            empty: !payload.hasData
                ? Loader(
                    text: "cleared overtimes...",
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.width / 9,
                    child: const NoDataWidget(
                        text: "No Cleared  overtimes captured"
                            ""),
                  ),
            source: ReportsDataSource(
              overtimeModel: _overtimes
                  .where((element) => element.status != 'Pending')
                  .toList(),
              context: context,
              currentPage: _currentPage,
              totalDocuments: _overtimes
                  .where((element) => element.status != 'Pending')
                  .toList()
                  .length,
              paginatorController: _controller,
            ),
          );
        },
      ),
    );
  }
}

//  pending overtimes
class PendingOvertime extends StatefulWidget {
  const PendingOvertime({super.key});

  @override
  State<PendingOvertime> createState() => _PendingOvertimeState();
}

class _PendingOvertimeState extends State<PendingOvertime>
    with SingleTickerProviderStateMixin {
  int _currentPage = 1;
  Timer? timer;
  int rowsPerPage = 20;
  final PaginatorController _pendingPaginatorController = PaginatorController();
  // stream controller
  StreamController<OvertimeModel> _overtimeController =
      StreamController<OvertimeModel>();
  @override
  void initState() {
    super.initState();
    realTimeClearedPayments();
  }

  void realTimeClearedPayments() async {
    // initial data
    var pendingOvertimes = await fetchPendingOvertimeData(
        context.read<SchoolController>().state['school'],
        page: _currentPage,
        limit: rowsPerPage);
    _overtimeController.add(pendingOvertimes);
    // listen to the stream
    Timer.periodic(Duration(seconds: 1), (timer) async {
      this.timer = timer;
      if (mounted) {
        var overtimes = await fetchPendingOvertimeData(
            context.read<SchoolController>().state['school'],
            page: _currentPage,
            limit: rowsPerPage);
        _overtimeController.add(overtimes);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_overtimeController.hasListener) {
      _overtimeController.close();
    }
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width / 2.5,
      child: StreamBuilder(
        stream: _overtimeController.stream,
        builder: (context, payload) {
          var overtimeModel = payload.data;
          var _overtimes = overtimeModel?.results ?? [];
          return CustomDataTable(
            paginatorController: _pendingPaginatorController,
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   "Pending",
                //   style: TextStyles(context).getTitleStyle(),
                // ),
              ],
            ),
            columns: const [
              DataColumn(
                label: Text(
                  "Student's profile",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              DataColumn(
                label: Text(
                  "Student Name",
                  style: TextStyle(fontSize: 12),
                ),
              ),
               DataColumn(
                label: Text("Guardian Name", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: Text("Cleared By", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: SizedBox(
                    width: 800,
                    child: Text("Date", style: TextStyle(fontSize: 12))),
              ),
              DataColumn(
                label: Text(
                  "Overtime Charge",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
         
            empty: SizedBox(
              height: MediaQuery.of(context).size.width / 9,
              child: !payload.hasData
                  ? Loader(
                      text: "pending overtimes...",
                    )
                  : const NoDataWidget(
                      text: "No Pending overtimes captured"
                          ""),
            ),
            source: ReportsDataSource(
                overtimeModel: _overtimes
                    .where((element) => element.status == 'Pending')
                    .toList(),
                context: context,
                currentPage: _currentPage,
                totalDocuments: _overtimes
                    .where((element) => element.status == "Pending")
                    .toList()
                    .length,
                paginatorController: _pendingPaginatorController),
          );
        },
      ),
    );
  }
}
