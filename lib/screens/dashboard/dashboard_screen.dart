import '/exports/exports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Header(),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: context.read<WidgetController>().state),
                ),
                // if (!Responsive.isMobile(context))
                //   const SizedBox(width: defaultPadding),
                // // On Mobile means if the screen is less than 850 we don't want to show it
                // if (!Responsive.isMobile(context))
                //   const Expanded(
                //     flex: 2,
                //     child: StarageDetails(),
                //   ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
