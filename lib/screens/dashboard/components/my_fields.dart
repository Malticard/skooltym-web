import '/exports/exports.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: const [
        //         SizedBox(
        //           width: 20,
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
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
  StreamController<List<Map<String,dynamic>>> _dashboardController = StreamController<List<Map<String,dynamic>>>();
  void fetchRealTimeData() async {
    if(mounted){
        var dashboardData = await fetchDashboardMetaData(context);
        _dashboardController.add(dashboardData);

    }

        // query database every after 4 seconds
        Timer.periodic(Duration(seconds: 4), (timer) async { 
          this.timer = timer;
          if(mounted){
              var dashboardData = await fetchDashboardMetaData(context);
        _dashboardController.add(dashboardData);

          }
        });
  }

  @override
  void dispose() { 
    super.dispose();
    timer?.cancel();
    if(_dashboardController.hasListener){
      _dashboardController.close();
    }
  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context).getSchoolData();
    
    return 
            StreamBuilder(
              stream:_dashboardController.stream,
                  builder: (context, snapshot) {
                    var cards = snapshot.data ?? [];
                    return !snapshot.hasData ? Center(child: Loader(text: "Dashboard data",),): GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cards.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.crossAxisCount,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                        childAspectRatio: widget.childAspectRatio,
                      ),
                      itemBuilder: (context, index) => DashboardCard(
                        label: cards[index]['label'],
                        value: cards[index]['value'],
                        icon: cards[index]['icon'],
                        color: cards[index]['color'],
                        last_updated: ""
                      ), //FileInfoCard(info: cards[index]),
                    );
                  },
                );
  }
}
