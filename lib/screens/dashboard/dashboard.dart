import '/exports/exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // context.read<MainController>().fetchDashboardClasses(context.read<SchoolController>().state['id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<MainController>().fetchDashboardClasses(context.read<SchoolController>().state['id']);

    return Column(
      children: [
        const MyFiles(),
        const SizedBox(height: defaultPadding),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Classes Summary",
                  style: TextStyles(context).getTitleStyle(),
                ),
              ),
              FutureBuilder(
                future: Client().get(Uri.parse(AppUrls.dashboard +
                    context.read<SchoolController>().state['school'])),
                builder: (context, snapshot) {
                  // print("Dashboard data => ${snapshot.data?.body}");
                  var classes =
                      dashboardModelFromJson(snapshot.data?.body ?? "");
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                        child: Loader(
                            text: "Classes",
                          ),
                      )
                      : snapshot.hasError
                          ? Center(
                              child: Text(
                                "No classes saved",
                                style: TextStyles(context).getTitleStyle(),
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: classes.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: defaultPadding,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) =>
                                    FileInfoCard(info: classes[index]),
                              ),
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
