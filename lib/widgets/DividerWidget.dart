import '/exports/exports.dart';
class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Row(
              children: [
                SizedBox(
                    width: size.width * 0.28,
                    child: const Divider(
                      thickness: 1.3,
                    )),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 0.5,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                   ? Colors.white12
                          : Colors.black12)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "School Details",
                        style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 13,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                      ),
                    )),
                SizedBox(
                    width: size.width * 0.28,
                    child: const Divider(
                      thickness: 1.3,
                    )),
              ],
            );
  }
}