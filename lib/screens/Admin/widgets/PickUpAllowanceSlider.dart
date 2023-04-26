import '/exports/exports.dart';

class PickUpAllowanceSlider extends StatefulWidget {
  final void Function(dynamic)? onChange;
  final double? currentValue;
  const PickUpAllowanceSlider(
      {super.key, this.onChange, this.currentValue = 0.0});

  @override
  State<PickUpAllowanceSlider> createState() => _PickUpAllowanceSliderState();
}

class _PickUpAllowanceSliderState extends State<PickUpAllowanceSlider> {
  // double _currentValue = 0.0;
  bool switcher = true;
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PickUpController, double>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set Pick allowance time",
                style: TextStyles(context)
                    .getRegularStyle()
                    .copyWith(fontSize: 15),
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 26, left: 26),
                child: SfSlider(
                    min: 0.0,
                    max: 100.0,
                    value: state,
                    stepSize: 5,
                    // showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (v) {
                      context
                          .read<PickUpController>()
                          .setPickUpAllowanceTime(v.toDouble());

                      setState(() {
                        _textController.value = TextEditingValue(
                          text: v.toStringAsFixed(0),
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: v.toString().length),
                          ),
                        );
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
                        controller: _textController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your pick up allowance time here",
                            hintStyle: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(fontSize: 15)),
                        // hintText: "Enter your pick up allowance time here",
                        onChanged: (p0) {
                          context
                              .read<PickUpController>()
                              .setPickUpAllowanceTime(double.parse(p0));
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
