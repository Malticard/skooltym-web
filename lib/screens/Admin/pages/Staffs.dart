// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class StaffView extends StatefulWidget {
  const StaffView({super.key});

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView> {
  final _controller = PaginatorController();
  int _currentPage = 1;
  int rowsPerPage = 20;
  List<String> _staffColumns = [
    "Staff Name",
    "Role",
    "Email",
    "Gender",
    "Actions"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: size.width / 2.39,
          child: StreamBuilder(
            stream: fetchStaffs(context, page: _currentPage, limit: rowsPerPage)
                .asStream(),
            builder: (context, snapshot) {
              var staffs = snapshot.data;
              var staffData = staffs?.results ?? [];
              return snapshot.hasData
                  ? CustomDataTable(
                      paginatorController: _controller,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = (page ~/ rowsPerPage) + 1;
                        });
                      },
                      onRowsPerPageChanged: (rows) {
                        setState(() {
                          rowsPerPage = rows ?? 20;
                        });
                      },
                      header: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (staffData.isNotEmpty)
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
                              Spacer(
                                  flex: Responsive.isDesktop(context) ? 2 : 1),
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
                        _staffColumns.length,
                        (index) => DataColumn(
                          label: Text(
                            _staffColumns[index],
                          ),
                        ),
                      ),
                      empty: NoDataWidget(
                          text: "You currently have no staff records"),
                      source: StaffDataSource(
                        staffModel: staffData,
                        context: context,
                        currentPage: _currentPage,
                         paginatorController: _controller,
                        totalDocuments: staffs?.totalDocuments ?? 0,
                      ),
                    )
                  : Loader(text: "Staff...");
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
