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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   "My Files",
            //   style: Theme.of(context).textTheme.subtitle1,
            // ),
            Row(
              children: [
                //   ElevatedButton.icon(
                //     style: TextButton.styleFrom(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: defaultPadding * 1.5,
                //         vertical: defaultPadding /
                //             (Responsive.isMobile(context) ? 2 : 1),
                //       ),
                //     ),
                //     onPressed: () {
                //       context.read<ThemeController>().toggleDarkLightTheme();
                //     },
                //     icon: const Icon(Icons.ac_unit_sharp),
                //     label: const Text("Change Theme"),
                //   ),
                const SizedBox(
                  width: 20,
                ),
                // ElevatedButton.icon(
                //   style: TextButton.styleFrom(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: defaultPadding * 1.5,
                //       vertical: defaultPadding /
                //           (Responsive.isMobile(context) ? 2 : 1),
                //     ),
                //   ),
                //   onPressed: () {},
                //   icon: const Icon(Icons.add),
                //   label: const Text("Add New"),
                // ),
              ],
            ),
          ],
        ),
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDashboardMetaData(context),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Loader(
                  text: "Dashboard Data",
                )
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                    childAspectRatio: widget.childAspectRatio,
                  ),
                  itemBuilder: (context, index) =>
                      FileInfoCard(info: snapshot.data![index]),
                );
        });
  }
}
