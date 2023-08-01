import '/exports/exports.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonAppbarView(
          titleText: "Privacy policy",
          iconData: Icons.arrow_back,
          onBackClick: () => Routes.popPage(context),
        ),
      ],
    );
  }
}
