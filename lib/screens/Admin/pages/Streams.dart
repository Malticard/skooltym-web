// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class StreamsUI extends StatefulWidget {
  const StreamsUI({super.key});

  @override
  State<StreamsUI> createState() => _StreamsUIState();
}

class _StreamsUIState extends State<StreamsUI> {
  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
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
          var streams = await fetchStreams(
              context.read<SchoolController>().state['school'],
              page: _currentPage,
              limit: rowsPerPage);
          _streamController.add(streams);
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
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 2.39,
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
                  header: Row(
                    children: [
                      const Text(
                        "Streams",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const AddStream(),
                          );
                        },
                        label: const Text("Add Stream"),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  columns: const [
                    DataColumn(
                      label: Text("#"),
                    ),
                    DataColumn(
                      label: Text("Stream"),
                    ),
                    DataColumn(
                      label: Text("Action"),
                    ),
                  ],
                  empty: FutureBuilder(
                      future: fetchStreams(
                          context.read<SchoolController>().state['school']),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const Loader(text: "Streams data")
                            : const Center(
                                child: Text("No Streams added.."),
                              );
                      }),
                  source: StreamDataSource(
                      context: context,
                      streamModel: streams,
                      currentPage: _currentPage,
                      totalDocuments: stream_obj?.totalDocuments ?? 0,
                      paginatorController: _pageController),
                );
              }),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const Text("Continue to add classes"),
              TextButton(
                onPressed: () {
                  context
                      .read<WidgetController>()
                      .pushWidget(const ClassesUI());
                  context.read<TitleController>().setTitle("Classes");
                  context.read<SideBarController>().changeSelected(4);
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
