import 'package:flutter/material.dart';

import '../../../exports/exports.dart';

class SettingsPopUp extends StatelessWidget {
  final String headerTitle;
  final VoidCallback onPressStartTime;
  final VoidCallback onPressEndTime;
  final String cardTitle1;
  final String cardTitle2;
  final VoidCallback onConfirm;
  const SettingsPopUp(
      {super.key,
      required this.headerTitle,
      required this.onPressStartTime,
      required this.onPressEndTime,
      required this.cardTitle1,
      required this.cardTitle2,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * .40,
        height: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.height / 2.3
            : MediaQuery.of(context).size.width * .2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Responsive.isMobile(context) ? 30 : 20,
                  bottom: 8,
                  left: 20,
                  right: 20),
              child: Text(
                headerTitle,
                style: TextStyles(context).getTitleStyle(),
              ),
            ),
            Flex(
              direction: Responsive.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              crossAxisAlignment: Responsive.isMobile(context)
                  ? CrossAxisAlignment.stretch
                  : CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Space(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 8, left: 20, right: 20),
                  child: TapEffect(
                    onClick: onPressStartTime,
                    child: Card(
                      color: Theme.of(context).canvasColor,
                      child: Padding(
                        padding: EdgeInsets.all(
                            Responsive.isMobile(context) ? 20.0 : 33.0),
                        child: Text(
                          cardTitle1,
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 20, right: 20),
                  child: TapEffect(
                      onClick: onPressEndTime,
                      child: Card(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).cardColor
                            : Theme.of(context).canvasColor,
                        child: Padding(
                          padding: EdgeInsets.all(
                              Responsive.isMobile(context) ? 20.0 : 33.0),
                          child: Text(
                            cardTitle2,
                            style: TextStyles(context).getRegularStyle(),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            CommonButton(
              buttonText: "Okay",
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 40, right: 40),
              onTap: onConfirm,
            )
          ],
        ),
      ),
    );
  }
}
