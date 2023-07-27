import '/exports/exports.dart';

class DashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const DashboardScreen({super.key, this.scaffoldKey});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String,dynamic> school = {};

  @override
  Widget build(BuildContext context) {
    context.read<SchoolController>().getSchoolData();
    // BlocProvider.of<FinanceViewController>(context).
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(0),
      // height: size.height /3,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[200]
          : Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //======= header section ========
          Padding(
            padding: EdgeInsets.only(
              top: size.width * 0.011,
              left: size.width * 0.031,
              right: size.width * 0.031,
            ),
            child: const Header(),
          ),
          const SizedBox(height: defaultPadding),
          // ====== end of header section ======
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 0,
                left: size.width * 0.061,
                right: size.width * 0.061),
            // ======= body section =======
            child: BlocConsumer<SchoolController, Map<String, dynamic>>(
              listener: (context, state) {
                setState(() {
                  school = state;
                });
              },
              builder: (context, state) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (school['role'] == 'Finance')
                      BlocBuilder<FinanceViewController, Widget>(
                          builder: (context, child) {
                        return Expanded(
                          flex: 5,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: Responsive.isDesktop(context)
                                ? MediaQuery.of(context).size.width / 2.2
                                : MediaQuery.of(context).size.height / 1.2,
                            child: child,
                          ),
                        );
                      }),
                    if (school['role'] == 'Admin')
                      BlocBuilder<WidgetController, Widget>(
                        builder: (context, child) {
                          return Expanded(
                        
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.2,
                              child: child,
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
            // ====== end of body section ======
          ),
        ],
      ),
    );
  }
}
