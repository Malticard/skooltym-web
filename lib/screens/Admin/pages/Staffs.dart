// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class StaffView extends StatefulWidget {
  const StaffView({super.key});

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView> {
  @override
  void initState() {
    super.initState();
  }

  List<String> staffs = ["Staff Name", "Role", "Email", "Gender", "Actions"];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StaffController>(context, listen: true).getStaffs(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: size.width / 2.39,
          child: BlocBuilder<StaffController, List<StaffModel>>(
            builder: (context, staff) {
              return CustomDataTable(
                asyncTable: true,
                loaderText: "Staff data",
                header: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (staff.isNotEmpty)
                        Expanded(
                          child: SearchField(
                            onChanged: (value) {
                              // Provider.of<MainController>(context,
                              //         listen: false)
                              //     .searchStaff(value ?? "");
                            },
                          ),
                        ),
                      if (!Responsive.isMobile(context))
                        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                      Text(
                        "",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AddStaff();
                              });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add Staff"),
                      ),
                    ],
                  ),
                ),
                columns: List.generate(
                  staffs.length,
                  (index) => DataColumn(
                    label: Text(
                      staffs[index],
                    ),
                  ),
                ),
                // empty: const Center(
                //   child:
                //       NoDataWidget(text: "You currently have no staff records"),
                // ),
                source: StaffDataSource(
                  staffModel: staff,
                  context: context,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const Text("Continue to add students"),
              TextButton(
                onPressed: () {
                  context
                      .read<WidgetController>()
                      .pushWidget(const ViewStudents());
                  context.read<TitleController>().setTitle("Students");
                  context.read<SideBarController>().changeSelected(1);
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
