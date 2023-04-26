import '/exports/exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:   [
        MyFiles(),
        const SizedBox(height: defaultPadding),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: const OvertimeReports(overtimeStatus: "Pending",label:"Pending "
              "Overtime"),
        ),
        // if (Responsive.isMobile(context))
        //   const SizedBox(height: defaultPadding),
        // if (Responsive.isMobile(context)) const StarageDetails(),
      ],
    );
  }
}
