import '/exports/exports.dart';

class IntervalSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  double? currentValue;
  IntervalSlider({super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<IntervalSlider> createState() => _IntervalSliderState();
}

class _IntervalSliderState extends State<IntervalSlider> {
 
 bool switcher = true;
  @override
  Widget build(BuildContext context) {
  final textController = TextEditingController(text: context
                          .read<IntervalController>().state.toString());
    return Scaffold(
      body: BlocBuilder<IntervalController, int>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set interval in minutes",
                style: TextStyles(context).getRegularStyle(),
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
                child: SfSlider(
                    min: 0,
                    max: 60,
                    value: state,
                    stepSize: 5,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (v) {
                      context
                          .read<IntervalController>()
                          .computeInterval(v.toInt());
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
                        maxLength: 2,
                        controller: textController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your dropoff allowance time here",
                            hintStyle: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(fontSize: 15)),
                        // hintText: "Enter your pick up allowance time here",
                        onChanged: (p0) {
                          context
                              .read<IntervalController>()
                              .computeInterval(int.parse(p0 == ""?"0":valueLimit(p0, "60")));
                        },
                      ),
                    ),
                    child: Text(
                      "${state.floor()} (mins)",
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
                    top: 8.0, bottom: 8.0, right: 36, left: 36),
              )
            ],
          );
        },
      ),
    );
  }
}
