import '/exports/exports.dart';

class SettingCard extends StatelessWidget {
  final String titleText;
  final String subText;
  final Widget trailWidget;
  final Color? color;
  final double radius;
  final double? trailTextSize;
  final double? subTextSize;
  final double? titleTextSize;
  final String icon;
  final EdgeInsetsGeometry? padding;
  final String? trailText;
  final Widget? leading;
  final Widget? title;
  const SettingCard({
    super.key,
    required this.titleText,
    this.color,
    this.padding,
    this.title,
    this.subText = '',
    this.trailText = '',
    this.trailWidget = const SizedBox(),
    this.radius = 13,
    this.leading,
    this.trailTextSize,
    this.icon = "assets/images/splash.png",
    this.subTextSize,
    this.titleTextSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ??
          const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Theme.of(context).brightness == Brightness.light
            ? color ?? const Color.fromRGBO(246, 246, 246, 1)
            : Theme.of(context).canvasColor,
      ),
      child: ListTileTheme(
        contentPadding:
            const EdgeInsets.only(left: 20, top: 1.2, right: 20, bottom: 1.2),
        child: ListTile(
          leading: SizedBox(
            width: Responsive.isMobile(context) ? 40 : 30,
            height: Responsive.isMobile(context) ? 40 : 30,
            child: Center(
              child: leading ??
                  Image.asset(
                    icon,
                    width: MediaQuery.of(context).size.width / 20,
                  ),
            ),
          ),
          trailing: trailText == null || trailText == ''
              ? trailWidget
              : Text(
                  trailText!,
                  style: TextStyles(context)
                      .getDescriptionStyle()
                      .copyWith(fontSize: trailTextSize ?? 13),
                ),
          title: title ??
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  titleText,
                  style: TextStyles(context)
                      .getBoldStyle()
                      .copyWith(fontSize: titleTextSize ?? 14.3),
                ),
              ),
          subtitle: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              subText,
              style: TextStyles(context)
                  .getDescriptionStyle()
                  .copyWith(fontSize: subTextSize ?? 12),
            ),
          ),
        ),
      ),
    );
  }
}
