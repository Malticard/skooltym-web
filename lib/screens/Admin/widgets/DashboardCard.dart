import '/exports/exports.dart';

class DashboardCard extends StatelessWidget {
  final Color? color;
  final int? value;
  final String icon;
  final String label;
  final String last_updated;
  const DashboardCard(
      {super.key,
      this.color,
      this.value = 0,
      required this.label,
      this.icon = "assets/icons/004-playtime.svg",
      required this.last_updated});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? color!.withOpacity(0.45)
          : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            child: RichText(
              text: TextSpan(
                text:value.toString(),
                style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 35, color: Colors.white),
                children: [
                  TextSpan(
                    text:value == 1?" Record" : " Records",
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.08,
            left: 25,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SvgPicture.asset(
                icon,
                color: Colors.white60,
                width: MediaQuery.of(context).size.width * 0.044,
                height: MediaQuery.of(context).size.width * 0.044,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 10,
          //   left: 10,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: Text(
          //       "Last updated $last_updated",
          //       style: TextStyles(context)
          //           .getDescriptionStyle()
          //           .copyWith(fontSize: 14, color: Colors.white),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 12.0,bottom: 10),
              child: Text(
                label,
                style: TextStyles(context)
                    .getBoldStyle()
                    .copyWith(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
