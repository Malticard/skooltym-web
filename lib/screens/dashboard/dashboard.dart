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
      children: [
        const MyFiles(),
        const SizedBox(height: defaultPadding),
        SizedBox(
            height: MediaQuery.of(context).size.height / 1.98,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:  [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Classes",style: TextStyles(context).getTitleStyle(),),
                ),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: context.read<MainController>().dashboardClasses.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: defaultPadding,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) =>  FileInfoCard(info: context.read<MainController>().dashboardClasses[index]),
                  ),
              ),
              ],
            )),
        // if (Responsive.isMobile(context))
        //   const SizedBox(height: defaultPadding),
        // if (Responsive.isMobile(context)) const StarageDetails(),
      ],
    );
  }
}
