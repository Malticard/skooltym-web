// import 'package:flutter/src/animation/animation_controller.dart';
import 'package:admin/tools/searchHelpers.dart';

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
  String? _query;
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
        if (_query != null) {
          var _cleared = await searchClearedOvertime(
            context.read<SchoolController>().state['school'],
            _query ?? '',
          );
          _overtimeController.add(_cleared);
        } else {
          var overtimes = await fetchClearedOvertimeData(
              context.read<SchoolController>().state['school'],
              page: _currentPage,
              limit: rowsPerPage);
          _overtimeController.add(overtimes);
        }
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
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Cleared overtimes",
                    style: TextStyles(context).getRegularStyle(),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 120,
                      child: SearchField(
                        onChanged: (value) {
                          setState(() {
                            _query = value?.trim();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            columns: [
              DataColumn(
                label: Text(
                  "Student's profile",
                  // style: TextStyle(fontSize: 12),
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Student Name",
                  // style: TextStyle(fontSize: 12),
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Guardian Name",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Cleared By",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: SizedBox(
                    width: 800,
                    child: Text(
                      "Date",
                      style: TextStyles(context).getRegularStyle(),
                    )),
              ),
              DataColumn(
                label: Text(
                  "Overtime Balance",
                  // style: TextStyle(fontSize: 12),
                  style: TextStyles(context).getRegularStyle(),
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
              isPending: false,
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
  String? _query;
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
        if (_query != null) {
          var _pending = await searchPendingOvertime(
            context.read<SchoolController>().state['school'],
            _query ?? '',
          );
          _overtimeController.add(_pending);
        } else {
          var overtimes = await fetchPendingOvertimeData(
              context.read<SchoolController>().state['school'],
              page: _currentPage,
              limit: rowsPerPage);
          _overtimeController.add(overtimes);
        }
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
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Pending overtimes",
                    style: TextStyles(context).getRegularStyle(),
                  ),
                  Spacer(
                    flex: Responsive.isMobile(context) ? 1 : 2,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 120,
                      child: SearchField(
                        onChanged: (value) {
                          setState(() {
                            _query = value?.trim();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            columns: [
              DataColumn(
                label: Text(
                  "Student's profile",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Student Name",
                  style: TextStyles(context).getRegularStyle(),
                  // style: TextStyle(fontSize: 12),
                ),
              ),
              DataColumn(
                label: Text(
                  "Guardian Name",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Recorded By",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: SizedBox(
                    width: 800,
                    child: Text(
                      "Date",
                      style: TextStyles(context).getRegularStyle(),
                    )),
              ),
              DataColumn(
                label: Text(
                  "Overtime Charge",
                  style: TextStyles(context).getRegularStyle(),
                  // style: TextStyle(fontSize: 12),
                ),
              ),
              if (context.read<SchoolController>().state['role'] == 'Finance')
                DataColumn(
                  label: Text(
                    "Action",
                    style: TextStyles(context).getRegularStyle(),
                    // style: TextStyle(fontSize: 12),
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
                paginatorController: _pendingPaginatorController,
                isPending: true),
          );
        },
      ),
    );
  }
}
