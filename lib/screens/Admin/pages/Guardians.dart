// ignore_for_file: deprecated_member_use
import '/models/Guardians.dart';

import '/exports/exports.dart';

class ViewGuardians extends StatefulWidget {
  const ViewGuardians({super.key});

  @override
  State<ViewGuardians> createState() => _ViewGuardiansState();
}

class _ViewGuardiansState extends State<ViewGuardians> {
  List<String> guardianColumns = [
    "Guardian Name",
    "Address",
    "Gender",
    "Actions"
  ];
  List<Guardian> guardianData = [];
  int _currentPage = 1;
  int rowsPerPage = 20;
  final PaginatorController _controller = PaginatorController();
    // stream controller
  StreamController<Guardians> _guardianController =
      StreamController<Guardians>();
      Timer? timer;
  @override
  void initState() {
    super.initState();
    _fetchRealTimeData();
  }

  @override
  void dispose() {
     if (_guardianController.hasListener) {
      _guardianController.close();
    }
    timer?.cancel();
    super.dispose();
  }

  void _fetchRealTimeData() async {
    try {
       // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
          var guardians = await fetchGuardians(context, page: _currentPage, limit: rowsPerPage);
        _guardianController.add(guardians);
      }
      // Listen to the stream and update the UI
      
    Timer.periodic(Duration(seconds: 1), (timer) async {
       this.timer = timer;
               // Add a check to see if the widget is still mounted before updating the state
      if (mounted) {
        // _fetchRealTimeData();
        var guardians = await fetchGuardians(context, page: _currentPage, limit: rowsPerPage);
        _guardianController.add(guardians);
      }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream:_guardianController.stream,
        builder: (context, snapshot) {
          var guardians = snapshot.data;
          guardianData = guardians?.results ?? [];
          return  Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.width / 2.5,
                      child: CustomDataTable(
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
                              if (guardianData.isNotEmpty)
                                Expanded(
                                  child: SearchField(
                                    onChanged: (value) {
                                      // Provider.of<MainController>(context, listen: false)
                                      //     .searchGuardians(value ?? "");
                                    },
                                  ),
                                ),
                              if (!Responsive.isMobile(context))
                                Spacer(
                                    flex:
                                        Responsive.isDesktop(context) ? 2 : 1),
                              const SizedBox(),
                              ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AddGuardian();
                                    },
                                  );
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("Add Guardian"),
                              ),
                            ],
                          ),
                        ),
                        columns: List.generate(
                          guardianColumns.length,
                          (index) => DataColumn(
                            numeric: true,
                            label: Text(
                              guardianColumns[index],
                            ),
                          ),
                        ),
                        empty: Center(
                          child: snapshot.hasData ?const NoDataWidget(
                              text: "No guardians registered yet.."):Loader(
                  text: "Guardians...",
                ),
                        ),
                        source: GuardianDataSource(
                          paginatorController: _controller,
                          guardianModel: guardianData,
                          context: context,
                          currentPage: _currentPage,
                          totalDocuments: guardians?.totalDocuments ?? 0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Row(
                        children: [
                          const Text("Continue to dashboard"),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<WidgetController>()
                                  .pushWidget(const Dashboard());
                              context
                                  .read<TitleController>()
                                  .setTitle("Dashboard");
                              context
                                  .read<SideBarController>()
                                  .changeSelected(0);
                              context
                                  .read<FirstTimeUserController>()
                                  .setFirstTimeUser(false);
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
  
        });
  }
}
