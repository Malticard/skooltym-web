// import 'package:flutter/src/animation/animation_controller.dart';
import '../../../tools/searchHelpers.dart';
import '/exports/exports.dart';

class ViewPickUps extends StatefulWidget {
  const ViewPickUps({super.key});

  @override
  State<ViewPickUps> createState() => _ViewPickUpsState();
}

class _ViewPickUpsState extends State<ViewPickUps> {
  List<PickUp> pickUpData = [];
  int _currentPage = 1;
  String? _query;

  int rowsPerPage = 20;
  final PaginatorController _controller = PaginatorController();
// stream controller
  StreamController<PickUpModel> _pickUpController =
      StreamController<PickUpModel>();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchRealTimeData();
  }

  @override
  void dispose() {
    if (_pickUpController.hasListener) {
      _pickUpController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void fetchRealTimeData() async {
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var drops = await fetchPickUps(
            context.read<SchoolController>().state['school'],
            page: _currentPage,
            limit: rowsPerPage);
        _pickUpController.add(drops);
      }
      // Listen to the stream and update the UI
      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_query != null) {
            var pickUps = await searchPickups(
                context.read<SchoolController>().state['school'], _query!);
            _pickUpController.add(pickUps);
          } else {
            var drops = await fetchPickUps(
                context.read<SchoolController>().state['school'],
                page: _currentPage,
                limit: rowsPerPage);
            _pickUpController.add(drops);
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
        stream: _pickUpController.stream,
        builder: (context, snapshot) {
          var pickups = snapshot.data;
          pickUpData = pickups?.results ?? [];
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
              children: [
                Text(
                  "Available PickUps",
                  style: TextStyles(context).getTitleStyle(),
                ),
                if (!Responsive.isMobile(context))
                  Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                if (pickUpData.isNotEmpty)
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
              DataColumn2(
                numeric: false,
                label: Text("Student's Profile"),
              ),
              DataColumn2(
                numeric: false,
                label: Text("Student Name"),
              ),
              DataColumn2(
                numeric: false,
                label: Text("PickedUp By"),
              ),
              DataColumn2(
                numeric: false,
                label: Text("Cleared by"),
              ),
              DataColumn2(
                numeric: false,
                label: Text("Overtime Charge"),
              ),
              DataColumn2(
                numeric: false,
                label: Text("Date"),
              ),
              DataColumn2(
                numeric: false,
                label: Text("Time Of PickUp"),
              ),
            ],
            empty: Center(
              child: !snapshot.hasData
                  ? const Loader(
                      text: "PickUp data",
                    )
                  : const NoDataWidget(
                      text: "No PickUps recorded..",
                    ),
            ),
            source: PickUpDataSource(
                pickUpModel: pickUpData,
                context: context,
                paginatorController: _controller,
                currentPage: _currentPage,
                totalDocuments: pickups?.totalDocuments ?? 0),
          );
        },
      ),
    );
  }
}
