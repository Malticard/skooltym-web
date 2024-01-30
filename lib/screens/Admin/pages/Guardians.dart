// ignore_for_file: deprecated_member_use
import 'dart:developer';

import '../../../tools/searchHelpers.dart';
import '/models/Guardians.dart';

import '/exports/exports.dart';

class ViewGuardians extends StatefulWidget {
  const ViewGuardians({super.key});

  @override
  State<ViewGuardians> createState() => _ViewGuardiansState();
}

class _ViewGuardiansState extends State<ViewGuardians> {
  List<String> guardianColumns = [
    "Guardian's Profile",
    "Guardian Name",
    "Contact",
    "Relationship",
    "Actions"
  ];
  List<Guardian> guardianData = [];
  int _currentPage = 1;
  int rowsPerPage = 20;
  String? _query;

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
        var guardians = await fetchGuardians(context,
            page: _currentPage, limit: rowsPerPage);
        _guardianController.add(guardians);
      }
      // Listen to the stream and update the UI

      Timer.periodic(Duration(seconds: 1), (timer) async {
        this.timer = timer;
        // Add a check to see if the widget is still mounted before updating the state
        if (mounted) {
          if (_query != null) {
            var guardians = await searchGuardians(
                context.read<SchoolController>().state['school'], _query ?? "");
            _guardianController.add(guardians);
          } else {
            var guardians = await fetchGuardians(context,
                page: _currentPage, limit: rowsPerPage);
            _guardianController.add(guardians);
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
    context.read<FirstTimeUserController>().getFirstTimeUser();
    return StreamBuilder(
        stream: _guardianController.stream,
        builder: (context, snapshot) {
          var guardians = snapshot.data;
          guardianData = guardians?.results ?? [];
          return Column(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
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
                                  setState(() {
                                    _query = value?.trim();
                                  });
                                },
                              ),
                            ),
                          if (!Responsive.isMobile(context))
                            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                          const SizedBox(),
                          ElevatedButton.icon(
                            onPressed: () {
                              showAdaptiveDialog(
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
                        label: Text(
                          guardianColumns[index],
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                    ),
                    empty: Center(
                      child: snapshot.hasData
                          ? const NoDataWidget(
                              text: "No guardians registered yet..")
                          : Loader(
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
              ),
              if (context.read<FirstTimeUserController>().state)
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Text("Continue to dashboard"),
                      TextButton(
                        onPressed: () {
                          // log("User role : ${context.read<SchoolController>().state['role']}");
                          context.read<WidgetController>().pushWidget(0);
                          context.read<TitleController>().setTitle("Dashboard");
                          context.read<SideBarController>().changeSelected(0,
                              context.read<SchoolController>().state['role']);
                          BlocProvider.of<FirstTimeUserController>(context)
                              .setFirstTimeUser(
                            false,
                          );
                          // update staff
                          StaffService.updateStaff({
                            "is_first_time_user": "false",
                          });
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
