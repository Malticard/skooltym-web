import '/exports/exports.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
    required this.classId,
  }) : super(key: key);

  final DashboardModel info;
  final int classId;
  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                CommonAppbarView(
                  titleTextSize: Responsive.isMobile(context) ? 18 : 24,
                  titleText: "Available Streams in ${info.className}",
                  topPadding: 3,
                ),
                if (info.classStreams.length > 0)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: StudentsPopUps(
                                id: index,
                                streamId: info.classStreams[index].id,
                                classId: classId,
                                className: info.className,
                                streamName: info.classStreams[index].streamName,
                              ),
                            ),
                          );
                        },
                        // leading:
                        //     SvgPicture.asset("assets/vectors/groups.svg"),
                        title: Text(
                          info.classStreams[index].streamName,
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        subtitle: Text(
                          "Tap to view",
                          style: TextStyles(context).getDescriptionStyle(),
                        ),
                      ),
                      itemCount: info.classStreams.length,
                      separatorBuilder: (ctx, ind) => const Divider(),
                    ),
                  ),
                if (info.classStreams.length == 0)
                  // Center(
                  //   child: Text("No streams available"),
                  // ),
                  CommonButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    buttonText: ("View students"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: StudentsPopUps(
                            id: null,
                            streamId: null,
                            classId: classId,
                            className: info.className,
                            streamName: null,
                          ),
                        ),
                      );
                    },
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
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: SizedBox(
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width / 4
              : MediaQuery.of(context).size.width / 3.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  info.className,
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 18),
                ),
              ),
              Row(
                children: [
                  Responsive(
                    desktop: Container(
                      padding: EdgeInsets.all(defaultPadding / 2),
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset(
                        "assets/vectors/students_class.svg",
                        fit: BoxFit.cover,
                        // color: Colors.red,
                      ),
                    ),
                    mobile: Container(
                      padding: EdgeInsets.zero,
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset(
                        "assets/vectors/students_class.svg",
                        fit: BoxFit.cover,
                        // color: Colors.red,
                      ),
                    ),
                  ),
                  Responsive(
                      desktop: const SizedBox(
                        width: 40,
                        height: 40,
                      ),
                      mobile: SizedBox(width: 2, height: 2)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${info.classStreams.length}',
                      style: Responsive.isMobile(context)
                          ? TextStyles(context)
                              .getBoldStyle()
                              .copyWith(fontSize: 13)
                          : TextStyles(context).getBoldStyle(),
                      children: [
                        TextSpan(
                          text: info.classStreams.length == 1
                              ? ' Stream'
                              : ' Streams',
                          style: Responsive.isMobile(context)
                              ? TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(fontSize: 14)
                              : TextStyles(context).getRegularStyle(),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "${info.classStudents.length}",
                      style: Responsive.isMobile(context)
                          ? TextStyles(context)
                              .getBoldStyle()
                              .copyWith(fontSize: 13)
                          : TextStyles(context).getBoldStyle(),
                      children: [
                        TextSpan(
                          text: info.classStudents.length == 1
                              ? ' Student'
                              : ' Students',
                          style: Responsive.isMobile(context)
                              ? TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(fontSize: 14)
                              : TextStyles(context).getRegularStyle(),
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
