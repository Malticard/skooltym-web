// ignore_for_file: file_names, non_constant_identifier_names, invalid_return_type_for_catch_error, argument_type_not_assignable_to_error_handler

import '/exports/exports.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({super.key});

  @override
  State<SystemSettings> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  String drop_off_time_start = "";
  String drop_off_time_end = "";
  String pick_up_time_start = "";
  String pick_up_time_end = "";
  // overall form padding
  final EdgeInsets _padding =
      const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5);
  // important methods
  String currencyCode = "Ush UGX";
  String _scheduledTime = "";
// settings data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              titlePadding: _padding,
              titleText: "System settings",
              iconData: Icons.arrow_back,
              onBackClick: () => Routes.popPage(context),
            ),
            Expanded(
                child: ListView(
              children: [
                // set drop off time
                TapEffect(
                  onClick: () => showDropOffOptions(),
                  child: SettingCard(
                    // radius: 10,
                    icon: SettingIcons.dropoffIcon,

                    titleText: "Drop offs",
                    subText: "Set the start and end time for drop offs",
                    trailText: "$drop_off_time_start - $drop_off_time_end",
                  ),
                ),
                //  set drop time allowance
                TapEffect(
                  onClick: () => setDropOffAllowance(),
                  child: BlocBuilder<DropOffController, double>(
                    builder: (context, state) {
                      return SettingCard(
                        icon: SettingIcons.dropoffIcon,
                        titleText: "Drop off time allowance",
                        subText: "Set the start and end time for drop offs",
                        trailText: "${state.floor()}(mins)",
                      );
                    },
                  ),
                ),
                // set pick up time
                TapEffect(
                  onClick: () => showPickUpOptions(),
                  child: SettingCard(
                    icon: (SettingIcons.pickupIcon),
                    titleText: "Pick Ups",
                    subText: "Set the start and end time for pick ups",
                    trailText: "$pick_up_time_start - $pick_up_time_end",
                  ),
                ),
                //  set pick up time allowance
                TapEffect(
                  onClick: () => setPickUpAllowance(),
                  child: BlocBuilder<PickUpController, double>(
                    builder: (context, state) {
                      return SettingCard(
                        icon: (SettingIcons.dropoffIcon),
                        titleText: "Pick Up time allowance",
                        subText: "Set the start and end time for drop offs",
                        trailText: "${state.floor()} (mins) ",
                      );
                    },
                  ),
                ),
                // check if overtime is allowed
                BlocBuilder<AllowOvertimeController, bool>(
                  builder: (context, allow) {
                    return SettingCard(
                      icon: (SettingIcons.overtimeRateIcon),
                      titleText: "Overtime",
                      subText: "Enable or disable overtime",
                      trailWidget: Switch.adaptive(
                          value: allow,
                          onChanged: (b) {
                            context
                                .read<AllowOvertimeController>()
                                .allowOvertime(b);
                          }),
                    );
                  },
                ),
                BlocBuilder<AllowOvertimeController, bool>(
                  builder: (context, state) =>
                      state ? buildRemaining() : Container(),
                ),

                CommonButton(
                  padding: _padding,
                  height: 55,
                  buttonText: "Save Changes",
                  onTap: () => saveSettings(),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

// widget
  Widget buildRemaining() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          if (context.read<AllowOvertimeController>().state == true)
            // set overtime rate
            TapEffect(
              onClick: () => setOvertimeRate(),
              child: BlocBuilder<OvertimeRateController, double>(
                builder: (context, state) {
                  return SettingCard(
                    icon: (SettingIcons.overtimeRateIcon),
                    titleText: "Overtime rate",
                    subText: "Set the time by which the overtime show be paid ",
                    trailText: "${state.floor()}",
                  );
                },
              ),
            ),
          //  overtime currency
          if (context.read<AllowOvertimeController>().state == true)
            TapEffect(
              onClick: () => setOvertimeCurrency(),
              child: SettingCard(
                icon: (SettingIcons.overtimeCurrencyIcon),
                titleText: "Overtime currency",
                subText: "Set the start and end time for drop offs",
                trailText: currencyCode,
              ),
            ),
          if (context.read<AllowOvertimeController>().state == true)
            // set overtime interval
            TapEffect(
              onClick: () => setOvertimeInterval(),
              child: BlocBuilder<IntervalController, double>(
                builder: (context, state) {
                  return SettingCard(
                    icon: (SettingIcons.overtimeIntervalIcon),
                    titleText: "Overtime interval",
                    subText:
                        "Charge overtime every after this amount of minutes.",
                    trailText: "${state.floor()} (mins)",
                  );
                },
              ),
            ),
          if (context.read<AllowOvertimeController>().state == true)
            //  set report scheduling time
            TapEffect(
              onClick: () => setReportSchedule(),
              child: SettingCard(
                icon: (SettingIcons.rescheduleIcon),
                titleText: "Report Scheduling",
                subText: "Set the time when system should issue out reports",
                trailText: _scheduledTime,
              ),
            ),
        ],
      ),
    );
  }

// saving settings
  void saveSettings() async {
    Map<String, dynamic> results = {
      "school_id": "${context.read<SchoolController>().state["school"]}",
      "drop_off_start_time": drop_off_time_start,
      "drop_off_end_time": drop_off_time_end,
      "pick_up_start_time": pick_up_time_start,
      "pick_up_end_time": pick_up_time_end,
      "drop_off_allowance": "${context.read<DropOffController>().state}",
      "pick_up_allowance": "${context.read<PickUpController>().state}",
      "allow_overtime": "${context.read<AllowOvertimeController>().state}",
      "overtime_rate": "${context.read<OvertimeRateController>().state}",
      "overtime_currency": currencyCode,
      "overtime_interval": "${context.read<IntervalController>().state}",
      "settings_key[key]": "0",
    };

    showProgress(context);
    Client()
        .post(Uri.parse(AppUrls.addSettings), body: results)
        .then((response) {
      debugPrint("Status code => ${response.statusCode}");
      if (response.statusCode == 200) {
        Routes.popPage(context);
        showSuccessDialog("Settings saved successfully", context);
        showMessage(msg: "Settings saved", type: 'success', context: context);
      } else {
        Routes.popPage(context);
        showMessage(
            msg: "${response.reasonPhrase}", type: 'danger', context: context);
      }
    });
  }

  // drop offs
  showDropOffOptions() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            children: [
              TapEffect(
                onClick: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then(
                    (value) => setState(() {
                      drop_off_time_start = "${value!.hour}:${value.minute}";
                    }),
                  );
                },
                child: SettingCard(
                  titleText: "Start time for drop off",
                  trailText: drop_off_time_start,
                ),
              ),
              TapEffect(
                onClick: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then(
                    (value) => setState(() {
                      drop_off_time_end = "${value!.hour}:${value.minute}";
                    }),
                  );
                },
                child: SettingCard(
                  titleText: "End time for drop off",
                  trailText: drop_off_time_end,
                ),
              ),
              CommonButton(
                buttonText: "Done",
                onTap: () => Routes.popPage(context),
              )
            ],
          ),
        ),
      ),
    );
  }

// pickups
  showPickUpOptions() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            children: [
              TapEffect(
                onClick: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then(
                    (value) => setState(() {
                      pick_up_time_start = "${value!.hour}:${value.minute}";
                    }),
                  );
                },
                child: SettingCard(
                  titleText: "Start time for pick up",
                  trailText: pick_up_time_start,
                ),
              ),
              TapEffect(
                onClick: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then(
                    (value) => setState(() {
                      pick_up_time_end = "${value!.hour}:${value.minute}";
                    }),
                  );
                },
                child: SettingCard(
                  titleText: "End time for pick up",
                  trailText: pick_up_time_end,
                ),
              ),
              CommonButton(
                buttonText: "Okay",
                onTap: () => Routes.popPage(context),
              )
            ],
          ),
        ),
      ),
    );
  }

// setting overtime
  setOvertimeRate() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: RateSlider(),
      ),
    );
  }

// setting overtime currency
  setOvertimeCurrency() {
    showCurrencyPicker(
        context: context,
        onSelect: (currency) {
          setState(() {
            currencyCode = "${currency.symbol} ${currency.code}";
          });
        },
        showFlag: true,
        showSearchField: true,
        showCurrencyName: true,
        showCurrencyCode: true,
        favorite: ['UGX']);
  }

// setting pickup allowance
  void setPickUpAllowance() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: PickUpAllowanceSlider(),
      ),
    );
  }

  void setDropOffAllowance() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: DropOffAllowanceSlider(),
      ),
    );
  }

// setting overtime interval
  setOvertimeInterval() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: IntervalSlider(),
      ),
    );
  }

// schedule
  DateTime initialDate = DateTime.now();
  setReportSchedule() async {
    final firstDate = DateTime(1997);
    final lastDate = DateTime(2050);

    var value = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _scheduledTime =
          "${days[value!.weekday]}, ${months[(value.month) - 1]} ${markDates(value.day)}";
      initialDate = value;
    });
  }
  //
}
