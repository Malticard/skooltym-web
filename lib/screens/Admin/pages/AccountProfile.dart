import '/exports/exports.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile>
    with TickerProviderStateMixin {
  // animation controller
  AnimationController? profileAnimationController;
  @override
  void initState() {
    profileAnimationController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 1000),
    );
    profileAnimationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BottomTopMoveAnimationView(
          animationController: profileAnimationController!,
          child: Column(
            children: [
              CommonAppbarView(
                iconData: Icons.arrow_back,
                titleText: "User Profile",
                onBackClick: () => Routes.popPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
