import '/exports/exports.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyFiles(),
        const SizedBox(height: defaultPadding),
        const RecentFiles(),
        // if (Responsive.isMobile(context))
        //   const SizedBox(height: defaultPadding),
        // if (Responsive.isMobile(context)) const StarageDetails(),
      ],
    );
  }
}
