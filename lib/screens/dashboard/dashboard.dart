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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context).getSchoolData();
    BlocProvider.of<DashboardDataController>(context)
        .getDashBoardData(context.read<SchoolController>().state['school']);
    return Column(
      children: [
        const MyFiles(),
        const SizedBox(height: defaultPadding),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (context.read<SchoolController>().state['role'] == 'Admin')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Classes Summary",
                    style: TextStyles(context).getTitleStyle(),
                  ),
                ),
              if (context.read<SchoolController>().state['role'] == 'Admin')
                FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2)),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: Loader(
                              text: "Classes data",
                            ),
                          )
                        : snapshot.hasError
                            ? Center(
                                child: Text(
                                  "${snapshot.error}",
                                  style: TextStyles(context).getTitleStyle(),
                                ),
                              )
                            : BlocBuilder<DashboardDataController, List<DashboardModel>>(
                                builder: (context, dashClasses) {
                                  return Expanded(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: dashClasses.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: defaultPadding,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 1,
                                      ),
                                      itemBuilder: (context, index) =>
                                          FileInfoCard(
                                              info: dashClasses[index]),
                                    ),
                                  );
                                },
                              );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
