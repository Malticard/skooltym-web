import '/exports/exports.dart';

class ProfileWidget extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  const ProfileWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.email});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: //context.read<OnlineCheckerController>().state
                 // ? Image.network(image)
                   Image.asset(
                      "assets/images/profile_pic.png",
                      width: size.width / 10,
                    )),
        ),
        SizedBox(
          height: size.width / 10,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.03, left: size.width * 0.02),
            child: RichText(
              text: TextSpan(
                  text: name,
                  style: TextStyles(context).getRegularStyle().copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                  children: [
                    TextSpan(
                      text: email,
                      style: TextStyles(context).getRegularStyle().copyWith(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
