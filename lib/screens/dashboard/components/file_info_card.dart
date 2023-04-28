import '/exports/exports.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final DashboardModel info;

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                 CommonAppbarView(
                  titleText: "Available Streams in ${info.className}",
                  topPadding: 10,
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => const Dialog(
                                  child: StudentsPopUps(),
                                ),
                              );
                            },
                            leading: const Icon(Icons.home),
                            title: Text(
                              "North",
                              style: TextStyles(context).getRegularStyle(),
                            ),
                            subtitle: Text(
                              "Tap to view",
                              style: TextStyles(context).getDescriptionStyle(),
                            ),
                          ),
                      itemCount: info.classStreams.length,
                      separatorBuilder: (ctx, ind) => const Divider()),
                )
              ],
            ),
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 3.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Class",
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 18),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 150,
                    height: 40,
                  ),
                  Container(
                    // padding:const EdgeInsets.all(defaultPadding),
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      // color: info['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SvgPicture.asset(
                      "assets/vectors/class.svg",
                      // color: Colors.red,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: TextStyles(context).getBoldStyle(),
                      children: [
                        TextSpan(
                          text: ' Streams',
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '2',
                      style: TextStyles(context).getBoldStyle(),
                      children: [
                        TextSpan(
                          text: ' Students',
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
