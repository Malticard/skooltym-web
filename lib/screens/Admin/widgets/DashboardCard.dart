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
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 23,
            left: 20,
            child: Text(
              "$value",
              style: TextStyles(context)
                  .getBoldStyle()
                  .copyWith(fontSize: 30, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 25,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SvgPicture.asset(
                icon,
                color: Colors.white60,
                width: MediaQuery.of(context).size.width * 0.14,
                height: MediaQuery.of(context).size.width * 0.14,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Last updated $last_updated",
                style: TextStyles(context)
                    .getDescriptionStyle()
                    .copyWith(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                label,
                style: TextStyles(context)
                    .getRegularStyle()
                    .copyWith(fontWeight: FontWeight.w200, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
