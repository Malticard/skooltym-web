import 'package:admin/extensions/FormatString.dart';

import '../../../widgets/SkeletonLoader.dart';
import '/exports/exports.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: const FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  Timer? timer;

  @override
  void initState() {
    BlocProvider.of<SchoolController>(context).getSchoolData();
    fetchRealTimeData();
    super.initState();
  }

  StreamController<List<Map<String, dynamic>>> _dashboardController =
      StreamController<List<Map<String, dynamic>>>();
  void fetchRealTimeData() async {
    String schoolId = context.read<SchoolController>().state['school'];
    String role = context.read<SchoolController>().state['role'];
    if (mounted) {
      var dashboardData = await fetchDashboardMetaData(schoolId, role);
      _dashboardController.add(dashboardData);
    }

    // query database every after 4 seconds
    Timer.periodic(Duration(seconds: 2), (timer) async {
      this.timer = timer;
      if (mounted) {
        var dashboardData = await fetchDashboardMetaData(schoolId, role);
        _dashboardController.add(dashboardData);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    if (_dashboardController.hasListener) {
      _dashboardController.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context).getSchoolData();

    return StreamBuilder(
      stream: _dashboardController.stream,
      builder: (context, snapshot) {
        var cards = snapshot.data ?? [];
        return !snapshot.hasData
            ? Center(
                child: SkeletonLoader(),
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                  childAspectRatio: widget.childAspectRatio,
                ),
                itemBuilder: (context, index) => TapEffect(
                  onClick: () {
                    String role =
                        context.read<SchoolController>().state['role'];
                    context.read<TitleController>().setTitle(
                        cards[index]['label'].toString().capitalize, role);
                    // update side bar
                    context
                        .read<SideBarController>()
                        .changeSelected(cards[index]['page'], role);
                    if (role == "Admin") {
                      context
                          .read<WidgetController>()
                          .pushWidget(cards[index]['page']);
                    } else {
                      context
                          .read<FinanceViewController>()
                          .pushWidget(cards[index]['page']);
                    }
                  },
                  child: DashboardCard(
                    label: cards[index]['label'],
                    value: cards[index]['value'],
                    icon: cards[index]['icon'],
                    color: cards[index]['color'],
                    last_updated: "",
                  ),
                ),
              );
      },
    );
  }
}
