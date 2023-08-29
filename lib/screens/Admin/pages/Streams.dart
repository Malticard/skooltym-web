// ignore_for_file: deprecated_member_use

import '../../../tools/searchHelpers.dart';
import '/exports/exports.dart';

class StreamsUI extends StatefulWidget {
  const StreamsUI({super.key});

  @override
  State<StreamsUI> createState() => _StreamsUIState();
}

class _StreamsUIState extends State<StreamsUI> {
  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  String? _query;
  final _pageController = PaginatorController();
  int _currentPage = 1;
  int rowsPerPage = 50;
  final streamErrorController = TextEditingController();

  // stream controller
  StreamController<StreamsModel> _streamController =
      StreamController<StreamsModel>();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchRealTimeData();
  }

  @override
  void dispose() {
    if (_streamController.hasListener) {
      _streamController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void fetchRealTimeData() async {
    try {
      // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        var streams = await fetchStreams(
            context.read<SchoolController>().state['school']);
        _streamController.add(streams);
      }
      // Listen to the stream and update the UI
      Timer.periodic(Duration(seconds: 3), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_query != null) {
            var streams = await searchStreams(
                context.read<SchoolController>().state['school'], _query!);
            _streamController.add(streams);
          } else {
            var streams = await fetchStreams(
                context.read<SchoolController>().state['school'],
                page: _currentPage,
                limit: rowsPerPage);
            _streamController.add(streams);
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  //text controllers
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: StreamBuilder(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  var stream_obj = snapshot.data;
                  var streams = stream_obj?.streams ?? [];
                  return CustomDataTable(
                    loaderText: "Streams data",
                    paginatorController: _pageController,
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
                        children: [
                          Text(
                            "Available Streams",
                            style: TextStyles(context).getRegularStyle(),
                          ),
                          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                          Expanded(
                            child: SearchField(
                              onChanged: (value) {
                                setState(() {
                                  _query = value?.trim();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) => const AddStream(),
                              );
                            },
                            label: const Text("Add Stream"),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    columns: [
                      DataColumn(
                        label: Text(
                          "#",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Stream",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Action",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                    ],
                    empty: !snapshot.hasData
                        ? const Loader(text: "Streams data")
                        : Center(
                            child: Text(
                              "No Streams added..",
                              style: TextStyles(context).getRegularStyle(),
                            ),
                          ),
                    source: StreamDataSource(
                        context: context,
                        streamModel: streams,
                        currentPage: _currentPage,
                        totalDocuments: stream_obj?.totalDocuments ?? 0,
                        paginatorController: _pageController),
                  );
                }),
          ),
        ),
        if (context.read<FirstTimeUserController>().state)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Text("Continue to add classes"),
                TextButton(
                  onPressed: () {
                    context.read<WidgetController>().pushWidget(4);
                    context.read<TitleController>().setTitle("Classes");
                    context.read<SideBarController>().changeSelected(
                        4, context.read<SchoolController>().state['role']);
                  },
                  child: Text(
                    "Click here",
                    style: TextStyles(context).getRegularStyle(),
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
