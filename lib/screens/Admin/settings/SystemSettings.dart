// ignore_for_file: file_names, non_constant_identifier_names, invalid_return_type_for_catch_error, argument_type_not_assignable_to_error_handler

import 'package:admin/models/SettingModel.dart';
import 'package:admin/screens/Admin/widgets/SettingsPopUp.dart';

import '../../../controllers/utils/LoaderController.dart';
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
  Timer? _timer;
  StreamController<SettingsModel> _settingsController =
      StreamController<SettingsModel>();
  @override
  void initState() {
    super.initState();
    settingsUpdate();
  }

  void settingsUpdate() async {
    if (mounted) {
      SettingsModel settingsModel =
          await fetchSettings(context.read<SchoolController>().state['school']);
      _settingsController.add(settingsModel);
    }
  }

  @override
  void dispose() {
    if (_settingsController.hasListener) {
      _settingsController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

// settings data
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context).getSchoolData();
    BlocProvider.of<FirstTimeUserController>(context)
        .getFirstTimeUser(context.read<SchoolController>().state['role']);
    BlocProvider.of<PickUpAllowanceTimeController>(context)
        .getComputedPickUpTime();
    BlocProvider.of<DropOffAllowanceController>(context).getDropOffAllowance();
    BlocProvider.of<IntervalController>(context).getComputedInterval();
    BlocProvider.of<DropOffTimeController>(context).getDropOffTime();
    BlocProvider.of<AllowOvertimeController>(context).getAllowOvertime();
    BlocProvider.of<PickUpTimeController>(context).getPickUpTime();
    BlocProvider.of<OvertimeRateController>(context).getOvertimeRate();
    return StreamBuilder(
        stream: _settingsController.stream,
        builder: (context, snapshot) {
          // var settings = snapshot.data;
          return Consumer<LoaderController>(
              builder: (context, controller, child) {
            return Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 4,
                child: BlocBuilder<SettingsController, Map<String, dynamic>>(
                  builder: (context, state) {
                    return TweenAnimationBuilder(
                      curve: Curves.decelerate,
                      tween: Tween<double>(begin: 0.2, end: 1),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: ListView(
                            children: [
                              Space(space: 0.043),
                              // set drop off time
                              TapEffect(
                                onClick: controller.isSavingSetting
                                    ? () {}
                                    : () => showDropOffOptions(),
                                child:
                                    BlocBuilder<DropOffTimeController, String>(
                                  builder: (context, state) {
                                    return SettingCard(
                                      // radius: 10,
                                      icon: SettingIcons.dropoffIcon,
                                      titleText: "Drop offs",
                                      subText:
                                          "Set the start and end time for students drop offs",
                                      trailText: state,
                                    );
                                  },
                                ),
                              ),
                              //  set drop time allowance
                              TapEffect(
                                onClick: controller.isSavingSetting
                                    ? () {}
                                    : () => setDropOffAllowance(),
                                child: BlocBuilder<DropOffAllowanceController,
                                    int>(
                                  builder: (context, state) {
                                    return SettingCard(
                                      icon: SettingIcons.dropoffIcon,
                                      titleText: "Drop off time allowance",
                                      subText:
                                          "Set the start and end time for students drop offs",
                                      trailText: state.floor() == 1
                                          ? "${state.floor()}(min)"
                                          : "${state.floor()}(mins)",
                                    );
                                  },
                                ),
                              ),
                              // set pick up time
                              TapEffect(
                                onClick: controller.isSavingSetting
                                    ? () {}
                                    : () => showPickUpOptions(),
                                child:
                                    BlocBuilder<PickUpTimeController, String>(
                                  builder: (context, state) {
                                    return SettingCard(
                                      icon: (SettingIcons.pickupIcon),
                                      titleText: "Pick Ups",
                                      subText:
                                          "Set the start and end time for students pickups",
                                      trailText: state,
                                    );
                                  },
                                ),
                              ),
                              //  set pick up time allowance
                              TapEffect(
                                onClick: controller.isSavingSetting
                                    ? () {}
                                    : () => setPickUpAllowance(),
                                child: BlocBuilder<
                                    PickUpAllowanceTimeController, int>(
                                  builder: (context, state) {
                                    return SettingCard(
                                      icon: (SettingIcons.dropoffIcon),
                                      titleText: "Pick Up time allowance",
                                      subText:
                                          "Set the start and end time for students pickups",
                                      trailText: state.floor() == 1
                                          ? "${state.floor()} (min)"
                                          : "${state.floor()} (mins)",
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
                                    subText: (allow) == true
                                        ? "Overtime enabled"
                                        : "Overtime disabled",
                                    trailWidget: Switch.adaptive(
                                        value: allow,
                                        onChanged: controller.isSavingSetting
                                            ? (X) {}
                                            : (b) {
                                                context
                                                    .read<
                                                        AllowOvertimeController>()
                                                    .allowOvertime(b);
                                              }),
                                  );
                                },
                              ),
                              //rendering overtime settings if enabled.
                              ...[
                                //  overtime currency
                                if ((context
                                        .watch<AllowOvertimeController>()
                                        .state ==
                                    true))
                                  TapEffect(
                                    onClick: controller.isSavingSetting
                                        ? () {}
                                        : () => setOvertimeCurrency(),
                                    child: SettingCard(
                                      icon: (SettingIcons.overtimeCurrencyIcon),
                                      titleText: "Overtime currency",
                                      subText:
                                          "Set the currency in which overtime is paid",
                                      trailText: currencyCode,
                                    ),
                                  ),
                                if ((context
                                        .watch<AllowOvertimeController>()
                                        .state ==
                                    true))
                                  // set overtime interval
                                  TapEffect(
                                    onClick: controller.isSavingSetting
                                        ? () {}
                                        : () => setOvertimeInterval(),
                                    child: BlocBuilder<IntervalController, int>(
                                      builder: (context, state) {
                                        return SettingCard(
                                          icon: (SettingIcons
                                              .overtimeIntervalIcon),
                                          titleText: "Overtime interval",
                                          subText:
                                              "Set the amount of time after which overtime will be charged eg. every after 20mins",
                                          trailText: state.floor() == 1
                                              ? "${state.floor()} (min)"
                                              : "${state.floor()} (mins)",
                                        );
                                      },
                                    ),
                                  ),
                                if ((context
                                        .watch<AllowOvertimeController>()
                                        .state ==
                                    true))
                                  // set overtime rate
                                  TapEffect(
                                    onClick: controller.isSavingSetting
                                        ? () {}
                                        : () => setOvertimeRate(),
                                    child: BlocBuilder<OvertimeRateController,
                                        int>(
                                      builder: (context, state) {
                                        return SettingCard(
                                          icon: (SettingIcons.overtimeRateIcon),
                                          titleText: "Overtime rate",
                                          subText:
                                              "Set the amount of money to charge every after the set overtime interval eg. 20000 every after 20mins ",
                                          trailText:
                                              "${currencyCode.split(" ").last} ${state.floor()}",
                                        );
                                      },
                                    ),
                                  ),
                              ],
                              //  set overtime interval
                              CommonButton(
                                  padding: _padding,
                                  backgroundColor: controller.isSavingSetting
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColor,
                                  height: 55,
                                  buttonTextWidget: controller.isSavingSetting
                                      ? CircularProgressIndicator.adaptive()
                                      : Text("Save Changes",
                                          style: TextStyles(context)
                                              .getRegularStyle()
                                              .copyWith(color: Colors.white)),
                                  // buttonText: "Save Changes",
                                  onTap: controller.isSavingSetting
                                      ? () {}
                                      : () {
                                          controller.setSavingSetting = true;
                                          saveSettings(controller);
                                        }),
                              Space(space: 0.043),
                            ],
                          ),
                        );
                      },
                      duration: Duration(milliseconds: 900),
                    );
                  },
                ),
              ),
            );
          });
        });
  }

// saving settings
  void saveSettings(LoaderController controller) async {
    Map<String, dynamic> results = {
      "school_id": "${context.read<SchoolController>().state["school"]}",
      "drop_off_start_time":
          context.read<DropOffTimeController>().state.split("-")[0],
      "drop_off_end_time":
          context.read<DropOffTimeController>().state.split("-")[1],
      "pick_up_start_time":
          context.read<PickUpTimeController>().state.split("-")[0].trim(),
      "pick_up_end_time":
          context.read<PickUpTimeController>().state.split("-")[1],
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
    // check if all fields are captured
    if (results["drop_off_start_time"] != "" &&
        results["drop_off_end_time"] != "" &&
        results["pick_up_start_time"] != "" &&
        results["pick_up_end_time"] != "" &&
        results["drop_off_allowance"] != "" &&
        results["pick_up_allowance"] != "") {
      Client()
          .post(Uri.parse(AppUrls.addSettings), body: results)
          .then((response) {
        if (response.statusCode == 200) {
          controller.setSavingSetting = false;
          showSuccessDialog(
            "Settings saved successfully",
            context,
            onPressed: () {
              Routes.popPage(context);
              if (context.read<FirstTimeUserController>().state) {
                context.read<WidgetController>().pushWidget(5);
                context.read<TitleController>().setTitle(
                    "Streams", context.read<SchoolController>().state['role']);
                context.read<SideBarController>().changeSelected(
                    5, context.read<SchoolController>().state['role']);
              }
            },
          );
          showMessage(msg: "Settings saved", type: 'success', context: context);
        } else {
          controller.setSavingSetting = false;

          showMessage(
              msg: "${response.reasonPhrase}",
              type: 'danger',
              context: context);
        }
      });
    } else {
      controller.setSavingSetting = false;
      showMessage(
          context: context,
          msg: "Drop Offs and Pick Ups are not set",
          type: "warning");
    }
  }

  // drop offs
  showDropOffOptions() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SettingsPopUp(
          headerTitle: "Setting Drop Off Time",
          onPressStartTime: () {
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
          onPressEndTime: () {
            showTimePicker(
                    helpText: "DropOff end time",
                    context: context,
                    initialTime: TimeOfDay.now())
                .then((value) {
              setState(() {
                drop_off_time_end =
                    "${value?.hour}:${value!.minute < 10 ? '${value.minute}0' : value.minute}:00";
              });
            });
          },
          cardTitle1: "Tap to set start time",
          cardTitle2: "Tap to set end time",
          onConfirm: () {
            Routes.popPage(context);
            context
                .read<DropOffTimeController>()
                .setDropOffTime("$drop_off_time_start - $drop_off_time_end");
          }),
    );
  }

// pickups
  void showPickUpOptions() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => SettingsPopUp(
            headerTitle: "Setting Pick Up Time",
            onPressStartTime: () {
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
            onPressEndTime: () {
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
            cardTitle1: "Tap to set start time",
            cardTitle2: "Tap to set end time",
            onConfirm: () {
              Routes.popPage(context);
              context
                  .read<PickUpTimeController>()
                  .setPickUpTime("$pick_up_time_start - $pick_up_time_end");
            }));
  }

// setting overtime
  void setOvertimeRate() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.22,
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height / 2.3
              : MediaQuery.of(context).size.width * 0.22,
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
        theme: CurrencyPickerThemeData(
            bottomSheetHeight: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.height / 1.4
                : MediaQuery.of(context).size.width * 0.52),
        favorite: ['UGX']);
  }

// setting pickup allowance
  void setPickUpAllowance() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.22,
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height / 2.3
              : MediaQuery.of(context).size.width * 0.22,
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
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.22,
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height / 2.3
              : MediaQuery.of(context).size.width * 0.22,
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
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        insetAnimationCurve: Curves.easeInCubic,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * 0.22,
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height / 2.3
              : MediaQuery.of(context).size.width * 0.22,
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
