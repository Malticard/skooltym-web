import '/exports/exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    context.read<SchoolController>().getSchoolData();
    pollData();
    super.initState();
  }

  StreamController<List<DashboardModel>> _dashDataController =
      StreamController<List<DashboardModel>>();
// Polling data in realtime
  Timer? timer;
  void pollData() async {
    if (mounted) {
      var dashData = await fetchDashBoardData(
          context.read<SchoolController>().state['school']);
      _dashDataController.add(dashData);
    }
    // fetch data periodically
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (mounted) {
        var dashData = await fetchDashBoardData(
            context.read<SchoolController>().state['school']);
        _dashDataController.add(dashData);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    if (_dashDataController.hasListener) {
      _dashDataController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context).getSchoolData();
    return Column(
      children: [
        const MyFiles(),
        const SizedBox(height: defaultPadding),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: BlocBuilder<SchoolController, Map<String, dynamic>>(
            builder: (context, school) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (school['role'] == 'Admin')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Classes Summary",
                        style: TextStyles(context).getTitleStyle(),
                      ),
                    ),
                  if (school['role'] == 'Admin')
                    Expanded(
                      child: StreamBuilder(
                        stream: _dashDataController.stream,
                        builder: (context, snapshot) {
                          var dashClasses = snapshot.data ?? [];
                          return !snapshot.hasData
                              ? Loader(text: "Classes data..")
                              : snapshot.data!.isEmpty? NoDataWidget(text: "No classes available",): SingleChildScrollView(
                                  child: SizedBox(
                                    height:Responsive.isMobile(context) ?  MediaQuery.of(context).size.width / 2 :MediaQuery.of(context).size.height,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: dashClasses.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            Responsive.isMobile(context)
                                                ? 2
                                                : 4,
                                        crossAxisSpacing: defaultPadding,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 1,
                                      ),
                                      itemBuilder: (context, index) =>
                                          FileInfoCard(
                                        info: dashClasses[index],
                                        classId: index,
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
