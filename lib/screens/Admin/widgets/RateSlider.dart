import '/exports/exports.dart';

class RateSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  double? currentValue;
  RateSlider({super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<RateSlider> createState() => _RateSliderState();
}

class _RateSliderState extends State<RateSlider> {
    bool switcher = true;
  @override
  Widget build(BuildContext context) {
  final textController = TextEditingController(text: context
                          .read<OvertimeRateController>().state.toString());

    return Scaffold(
      body: BlocBuilder<OvertimeRateController, double>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set Overtime rate",
                style: TextStyles(context).getRegularStyle().copyWith(fontSize:17),
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
                child: SfSlider(
                    min: 0,
                    max: 100000,
                    value: state,
                    stepSize: 100,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (v) {
                      context
                          .read<OvertimeRateController>()
                          .setOvertimeRate(v.toDouble());
                      // setState(() {
                      //   widget.currentValue = v.toDouble();
                      // });
                    }),
              ),
                   const Space(space: 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: switcher,
                    replacement: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: textController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your pick up allowance time here",
                            hintStyle: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(fontSize: 15)),
                        // hintText: "Enter your pick up allowance time here",
                        onChanged: (p0) {
                          context
                              .read<OvertimeRateController>()
                              .setOvertimeRate(double.parse(p0));
                        },
                      ),
                    ),
                    child: Text(
                      "Rate ${state.floor()}",
                      style: TextStyles(context)
                          .getBoldStyle()
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    iconSize: 13,
                    onPressed: () {
                      setState(() {
                        switcher = !switcher;
                      });
                    },
                    icon: Icon(
                      switcher ? Icons.edit : Icons.check,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              const Space(space: 0.03),
              CommonButton(
                buttonText: "Done",
                onTap: () => Routes.popPage(context),
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
              )
            ],
          );
        },
      ),
    );
  }
}
