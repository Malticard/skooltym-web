import '/exports/exports.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonAppbarView(
          titleText: "About",
          iconData: Icons.arrow_back,
          onBackClick: () => Routes.popPage(context),
        ),
      ],
    );
    ;
  }
}
