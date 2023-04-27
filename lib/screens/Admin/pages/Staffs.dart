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

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context)
        .staffUpdate(context.read<SchoolController>().state['school']);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Staff Name", "Role", "Email", "Gender", "Actions"];
  DataRow _dataRow(StaffModel staffModel, int i) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  AppUrls.liveImages + staffModel.staffProfilePic,
                ),
              ),
              Text(
                staffModel.staffFname,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        DataCell(Text((staffModel.staffRole.roleType))),
        DataCell(Text(staffModel.staffEmail)),
        DataCell(Text(staffModel.staffGender)),
        DataCell(buildActionButtons(context, () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 2.3,
                    child: UpdateStaff(staff: staffModel),
                  ),
                );
              });
        }, () {
          // delete functionality
          showDialog(
              context: context,
              builder: (context) {
                return CommonDelete(
                  title: '${staffModel.staffFname} ${staffModel.staffLname}',
                  url: AppUrls.deleteStaff + staffModel.id,
                );
              });
        })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Provider.of<MainController>(context).staffUpdate();
    return SizedBox(
      height: size.width / 2.4,
      child: Stack(
        children: [
          Data_Table(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (context.watch<MainController>().staffData.isNotEmpty)
                    Expanded(
                      child: SearchField(
                        onChanged: (value) {
                          Provider.of<MainController>(context, listen: false)
                              .searchStaff(value ?? "");
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
            empty:
                const NoDataWidget(text: "You currently have no staff records"),
            rows: List.generate(
              context.watch<MainController>().sStaff.isEmpty
                  ? context.watch<MainController>().staffData.length
                  : context.watch<MainController>().sStaff.length,
              (index) => _dataRow(
                  context.watch<MainController>().sStaff.isEmpty
                      ? context.watch<MainController>().staffData[index]
                      : context.watch<MainController>().sStaff[index],
                  index),
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
      ),
    );
  }
}
