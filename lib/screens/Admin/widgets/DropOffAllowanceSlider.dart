import '/exports/exports.dart';

class DropOffAllowanceSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  final double? currentValue;
  const DropOffAllowanceSlider(
      {super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<DropOffAllowanceSlider> createState() => _DropOffAllowanceSliderState();
}

class _DropOffAllowanceSliderState extends State<DropOffAllowanceSlider> {
  // double _currentValue = 0.0;
  bool switcher = true;
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController(text:context
                          .read<DropOffAllowanceController>().state.toString());
    return Scaffold(
      body: BlocBuilder<DropOffAllowanceController, int>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set drop off time allowance",
                style: TextStyles(context).getRegularStyle().copyWith(fontSize: 16),
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
                child: SfSlider(
                    min: 0.0,
                    max: 60,
                    value: state > 60 ? 60 : state,
                    stepSize: 5,
                    // showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (v) {
                      context
                          .read<DropOffAllowanceController>()
                          .setDropOffAllowanceTime(v.toInt());
                      setState(() {
                        textController.text = v.toString();
                      });
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
                        maxLength: 2,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your dropoff allowance time here",
                            hintStyle: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(fontSize: 15)),
                        // hintText: "Enter your pick up allowance time here",
                        onChanged: (p0) {
                          context
                              .read<DropOffAllowanceController>()
                              .setDropOffAllowanceTime(int.parse(p0 == ""?"0":valueLimit(p0, "60")));
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
                height: 55,
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
