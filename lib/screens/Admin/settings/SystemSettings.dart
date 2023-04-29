// ignore_for_file: file_names, non_constant_identifier_names, invalid_return_type_for_catch_error, argument_type_not_assignable_to_error_handler
import '/exports/exports.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({super.key});

  @override
  State<SystemSettings> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  String drop_off_time_start = "9:00";
  String drop_off_time_end = "";
  String pick_up_time_start = "";
  String pick_up_time_end = "";
  // overall form padding
  final EdgeInsets _padding =
      const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5);
  // important methods
  String currencyCode = "Ush UGX";
// settings data
  @override
  Widget build(BuildContext context) {
     BlocProvider.of<SchoolController>(context).getSchoolData();
    BlocProvider.of<PickUpAllowanceTimeController>(context)
        .getComputedPickUpTime();
    BlocProvider.of<DropOffAllowanceController>(context).getDropOffAllowance();
    BlocProvider.of<IntervalController>(context).getComputedInterval();
    BlocProvider.of<DropOffTimeController>(context).getDropOffTime();
    BlocProvider.of<AllowOvertimeController>(context).getAllowOvertime();
    BlocProvider.of<PickUpTimeController>(context).getPickUpTime();
    return Padding(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 2,
        child: BlocBuilder<SettingsController, Map<String, dynamic>>(
          builder: (context, state) {
            return ListView(
              
              children: [
                // set drop off time
                TapEffect(
                  onClick: () => showDropOffOptions(),
                  child: BlocBuilder<DropOffTimeController, String>(
                    builder: (context, state) {
                      return SettingCard(
                        // radius: 10,
                        icon: SettingIcons.dropoffIcon,
                        titleText: "Drop offs",
                        subText: "Set the start and end time for students drop offs",
                        trailText: state,
                      );
                    },
                  ),
                ),
                //  set drop time allowance
                TapEffect(
                  onClick: () => setDropOffAllowance(),
                  child: BlocBuilder<DropOffAllowanceController, double>(
                    builder: (context, state) {
                      return SettingCard(
                        icon: SettingIcons.dropoffIcon,
                        titleText: "Drop off time allowance",
                        subText: "Set the start and end time for students drop offs",
                        trailText: "${state.floor()}(mins)",
                      );
                    },
                  ),
                ),
                // set pick up time
                TapEffect(
                  onClick: () => showPickUpOptions(),
                  child: BlocBuilder<PickUpTimeController, String>(
                    builder: (context, state) {
                      return SettingCard(
                        icon: (SettingIcons.pickupIcon),
                        titleText: "Pick Ups",
                        subText: "Set the start and end time for students pickups",
                        trailText: state,
                      );
                    },
                  ),
                ),
                //  set pick up time allowance
                TapEffect(
                  onClick: () => setPickUpAllowance(),
                  child: BlocBuilder<PickUpAllowanceTimeController, int>(
                    builder: (context, state) {
                      return SettingCard(
                        icon: (SettingIcons.dropoffIcon),
                        titleText: "Pick Up time allowance",
                        subText: "Set the start and end time for students pickups",
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
                      subText: allow == true? "Overtime enabled":"Overtime disabled",
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
                //rendering overtime settings if enabled.
                ...[
                  //  overtime currency
                  if (context.watch<AllowOvertimeController>().state == true)
                    TapEffect(
                      onClick: () => setOvertimeCurrency(),
                      child: SettingCard(
                        icon: (SettingIcons.overtimeCurrencyIcon),
                        titleText: "Overtime currency",
                        subText: "Set the currency in which overtime is paid",
                        trailText: currencyCode,
                      ),
                    ),
                  if (context.watch<AllowOvertimeController>().state == true)
                    // set overtime interval
                    TapEffect(
                      onClick: () => setOvertimeInterval(),
                      child: BlocBuilder<IntervalController, int>(
                        builder: (context, state) {
                          return SettingCard(
                            icon: (SettingIcons.overtimeIntervalIcon),
                            titleText: "Overtime interval",
                            subText:
                                "Set the amount of time after which overtime will be charged eg. every after 20mins",
                            trailText: "${state.floor()} (mins)",
                          );
                        },
                      ),
                    ),
                  if (context.watch<AllowOvertimeController>().state == true)
                    // set overtime rate
                    TapEffect(
                      onClick: () => setOvertimeRate(),
                      child: BlocBuilder<OvertimeRateController, int>(
                        builder: (context, state) {
                          return SettingCard(
                            icon: (SettingIcons.overtimeRateIcon),
                            titleText: "Overtime rate",
                            subText:
                                "Set the amount of money to charge every after the set overtime interval eg. 20000 every after 20mins ",
                            trailText: "${state.floor()}",
                          );
                        },
                      ),
                    ),
                ],
                //  set overtime interval
                CommonButton(
                  padding: _padding,
                  height: 55,
                  buttonText: "Save Changes",
                  onTap: () => saveSettings(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

// saving settings
  void saveSettings() async {
// 2012-02-27 13:27:00
// debugPrint("Allow allowance ${(context.read<AllowOvertimeController>().state)}");
// DateTime()
    Map<String, dynamic> results = {
      "school_id": "${context.read<SchoolController>().state["school"]}",
      "drop_off_start_time": context.read<DropOffTimeController>().state.split("-")[0],
      "drop_off_end_time": context.read<DropOffTimeController>().state.split("-")[1],
      "pick_up_start_time":
          "${DateTime.now().toString().split(" ")[0]}${context.read<PickUpTimeController>().state.split("-")[0]}",
      "pick_up_end_time":
          "${DateTime.now().toString().split(" ")[0]}${context.read<PickUpTimeController>().state.split("-")[1]}",
      "drop_off_allowance":
          "${context.read<DropOffAllowanceController>().state}",
      "pick_up_allowance":
          "${context.read<PickUpAllowanceTimeController>().state}",
      "allow_overtime": "${context.read<AllowOvertimeController>().state}",
      "overtime_rate": "${context.read<OvertimeRateController>().state}",
      "overtime_rate_currency": currencyCode,
      "overtime_interval": "${context.read<IntervalController>().state}",
      "settings_key[key]": "0",
    };
    BlocProvider.of<SettingsController>(context).saveSettings(results);
    debugPrint("results => $results");
    showProgress(context);
    Client()
        .post(Uri.parse(AppUrls.addSettings), body: results)
        .then((response) {
      if (response.statusCode == 200) {
        Routes.popPage(context);
        showSuccessDialog(
          "Settings saved successfully",
          context,
          onPressed: () {
            Routes.popPage(context);
            context.read<WidgetController>().pushWidget(const Streams());
            context.read<TitleController>().setTitle("Streams");
            context.read<SideBarController>().changeSelected(5);
          },
        );
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
          width: MediaQuery.of(context).size.width * .37,
          height: MediaQuery.of(context).size.width * .2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 20, right: 20),
                child: Text(
                  "Setting Drop Off Time",
                  style: TextStyles(context).getTitleStyle(),
                ),
              ),
              const Space(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 20, right: 20),
                    child: TapEffect(
                      onClick: () {
                        showTimePicker(
                                helpText: "DropOff start time",
                                context: context,
                                initialTime: TimeOfDay.now())
                            .then(
                          (value) {
                            setState(() {
                              drop_off_time_start =
                                "${value!.hour}:${value.minute < 10 ? '${value.minute}0' : value.minute}:00";
                            });
                          },
                        );
                      },
                      child: Card(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).cardColor
                            : Theme.of(context).canvasColor,
                        child: const Padding(
                          padding: EdgeInsets.all(33.0),
                          child: Text("Tap to set start time"),
                        ),
                      ),
                    ),
                  ),
                  //  const Space(space: 0.01,),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 20, right: 20),
                    child: TapEffect(
                        onClick: () {
                          showTimePicker(
                                  helpText: "DropOff end time",
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then(
                            (value) => setState(() {
                              drop_off_time_end =
                                  "${value!.hour}:${value.minute < 10 ? '${value.minute}0' : value.minute}:00";
                            }),
                          );
                        },
                        child: Card(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).cardColor
                                  : Theme.of(context).canvasColor,
                          child: const Padding(
                            padding: EdgeInsets.all(33.0),
                            child: Text("Tap to set end time"),
                          ),
                        )),
                  ),
                ],
              ),
              CommonButton(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 100, right: 100),
                buttonText: "Done",
                onTap: (){
                  Routes.popPage(context);
                  context.read<DropOffTimeController>().setDropOffTime( "$drop_off_time_start - $drop_off_time_end");
                },
              )
            ],
          ),
        ),
      ),
    );
  }

// pickups
  void showPickUpOptions() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .37,
          height: MediaQuery.of(context).size.width * .2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 20, right: 20),
                child: Text(
                  "Setting PickUp Time",
                  style: TextStyles(context).getTitleStyle(),
                ),
              ),
              const Space(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Space(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 20, right: 20),
                    child: TapEffect(
                      onClick: () {
                        showTimePicker(
                                helpText: "PickUp start time",
                                context: context,
                                initialTime: TimeOfDay.now())
                            .then(
                          (value) => setState(() {
                            pick_up_time_start =
                                '${value!.hour}:${value.minute < 10 ? '${value.minute}0' : value.minute}:00';
                          }),
                        );
                      },
                      child: Card(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).cardColor
                            : Theme.of(context).canvasColor,
                        child: const Padding(
                          padding: EdgeInsets.all(33.0),
                          child: Text("Tap to set start time"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 20, right: 20),
                    child: TapEffect(
                        onClick: () {
                          showTimePicker(
                            helpText: "PickUp end time",
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then(
                            (value) => setState(() {
                              pick_up_time_end =
                                  "${value!.hour}:${value.minute < 10 ? '${value.minute}0' : value.minute}:00";
                            }),
                          );
                        },
                        child: Card(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).cardColor
                                  : Theme.of(context).canvasColor,
                          child: const Padding(
                            padding: EdgeInsets.all(33.0),
                            child: Text("Tap to set end time"),
                          ),
                        )),
                  ),
                ],
              ),
              CommonButton(
                buttonText: "Okay",
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 40, right: 40),
                onTap: (){
                  Routes.popPage(context);
                  context.read<PickUpTimeController>().setPickUpTime( "$pick_up_time_start - $pick_up_time_end");
                },
              )
            ],
          ),
        ),
      ),
    );
  }

// setting overtime
  void setOvertimeRate() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.width * 0.22,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            child: RateSlider(),
          ),
        ),
      ),
    );
  }

// setting overtime currency
  void setOvertimeCurrency() {
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
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.width * 0.22,
          child: const ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            child: PickUpAllowanceSlider(),
          ),
        ),
      ),
    );
  }

  void setDropOffAllowance() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.width * 0.22,
          child: const ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            child: DropOffAllowanceSlider(),
          ),
        ),
      ),
    );
  }

// setting overtime interval
  setOvertimeInterval() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.width * 0.22,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            child: IntervalSlider(),
          ),
        ),
      ),
    );
  }
}
