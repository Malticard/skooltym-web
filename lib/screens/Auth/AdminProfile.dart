import '/exports/exports.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BottomTopMoveAnimationView(
        animationController: _controller!,
        child: Container(
          height: size.width / 2,
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           ProfileWidget(email: "${context.read<SchoolController>().state['email']}", image:"${context.read<SchoolController>().state['email']}", name:  "${context.read<SchoolController>().state['fname']} ${context.read<SchoolController>().state['lname']}\n",),
           DividerWidget()
          ]),
        ));
  }
}
