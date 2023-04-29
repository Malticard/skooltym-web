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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).newGuardians(context);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];
  DataRow _dataRow(Guardians guardians, int i) {
    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  AppUrls.liveImages + guardians.guardianProfilePic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "${guardians.guardianFname} ${guardians.guardianLname}",
                  style: const TextStyle(fontSize: 13.5),
                ),
              ),
            ),
          ],
        )),
        DataCell(Text(guardians.guardianEmail)),
        DataCell(Text(guardians.guardianGender)),
        DataCell(buildActionButtons(
          context,
          () {
            showDialog(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                      child: UpdateGuardian(guardianModel: guardians));
                });
          },
          () {
            showDialog(
                context: context,
                builder: (context) {
                  return CommonDelete(
                    title:
                        "${guardians.guardianFname} ${guardians.guardianLname}",
                    url: AppUrls.deleteGuardian + guardians.id,
                  );
                });
          },
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MainController>(context).newGuardians(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 2.5,
          child: Data_Table(
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
            empty: const NoDataWidget(text: "No guardians registered yet.."),
            rows:  List.generate(
              context.watch<MainController>().sGuardian.isEmpty
                  ? context.watch<MainController>().guardians.length
                  : context.watch<MainController>().sGuardian.length,
              (index) => _dataRow(
                  context.watch<MainController>().sGuardian.isEmpty
                      ? context.watch<MainController>().guardians[index]
                      : context.watch<MainController>().sGuardian[index],
                  index),
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
