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
  void didChangeDependencies() {
    BlocProvider.of<SchoolController>(context).getSchoolData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context).getSchoolData();

    // context
    //     .read<MainController>()
    //     .fetchDashboardClasses(context.read<SchoolController>().state['id']);

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
                  future: fetchDashboardClassData(
                      context.read<SchoolController>().state['school']),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: Loader(
                              text: "Classes",
                            ),
                          )
                        : snapshot.hasError
                            ? Center(
                                child: Text(
                                  "${snapshot.error}",
                                  style: TextStyles(context).getTitleStyle(),
                                ),
                              )
                            : Expanded(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: defaultPadding,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) =>
                                      FileInfoCard(info: snapshot.data![index]),
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
