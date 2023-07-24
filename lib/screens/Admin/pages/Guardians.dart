// ignore_for_file: deprecated_member_use
import '/exports/exports.dart';

class ViewGuardians extends StatefulWidget {
  const ViewGuardians({super.key});

  @override
  State<ViewGuardians> createState() => _ViewGuardiansState();
}

class _ViewGuardiansState extends State<ViewGuardians> {
  @override
  void initState() {
    Provider.of<MainController>(context, listen: false).newGuardians(context);
    super.initState();
  }

  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];

  @override
  Widget build(BuildContext context) {
    Provider.of<MainController>(context, listen: true).newGuardians(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 2.5,
          child: CustomDataTable(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (context.watch<MainController>().guardians.isNotEmpty)
                    Expanded(
                      child: SearchField(
                        onChanged: (value) {
                          Provider.of<MainController>(context, listen: false)
                              .searchGuardians(value ?? "");
                        },
                      ),
                    ),
                  if (!Responsive.isMobile(context))
                    Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                  const SizedBox(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const SingleChildScrollView(
                            child: AddGuardian(),
                          );
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
              staffs.length,
              (index) => DataColumn(
                numeric: true,
                label: Text(
                  staffs[index],
                ),
              ),
            ),
            empty: Center(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2)),
                  builder: (context, d) {
                    return d.connectionState == ConnectionState.waiting
                        ? const Loader(
                            text: "Guardians data ",
                          )
                        : const NoDataWidget(
                            text: "No guardians registered yet..");
                  }),
            ),
            source: GuardianDataSource(
              guardianModel: context.watch<MainController>().guardians,
              context: context,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const Text("Continue to dashboard"),
              TextButton(
                onPressed: () {
                  context
                      .read<WidgetController>()
                      .pushWidget(const Dashboard());
                  context.read<TitleController>().setTitle("Dashboard");
                  context.read<SideBarController>().changeSelected(0);
                  context
                      .read<FirstTimeUserController>()
                      .setFirstTimeUser(false);
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
  }
}
