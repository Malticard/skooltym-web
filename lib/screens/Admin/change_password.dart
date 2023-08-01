// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import '/exports/exports.dart';

///  Created by bruno on 15/02/2023.
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String _errorNewPassword = '';
  String _errorConfirmPassword = '';
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _confirm = false;
  bool _pass = false;
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<SchoolController>().getSchoolData();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SchoolController>().getSchoolData();
  }
  @override
  Widget build(BuildContext context) {
    context.read<SchoolController>().getSchoolData();
    return Padding(
      padding: EdgeInsets.only(
          // top: MediaQuery.of(context).size.width * 0.1,
          bottom: MediaQuery.of(context).size.width * 0.05,
          // right: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.width * 0.05),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: SvgPicture.asset(
              "assets/vectors/change_pass.svg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 3,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).canvasColor,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 16.0, left: 34, right: 34),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Ensure your new password is at least 6 characters long and different from your current password.",
                              textAlign: TextAlign.start,
                              style: TextStyles(context)
                                  .getDescriptionStyle()
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Space(space: 0.06,),
                    CommonTextField(
                      textInputAction: TextInputAction.next,
                      enableSuffix: true,
                      suffixIcon: _confirm
                          ? Icons.remove_red_eye_rounded
                          : Icons.visibility_off,
                      controller: _newController,
                      titleText: "New password",
                      icon: Icons.lock_outline_rounded,
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      hintText: "************",
                      keyboardType: TextInputType.visiblePassword,
                      isObscureText: !_confirm,
                      onTapSuffix: () {
                        setState(() {
                          _confirm = !_confirm;
                        });
                      },
                      errorText: _errorNewPassword,
                    ),
                    CommonTextField(
                      textInputAction: TextInputAction.done,
                      controller: _confirmController,
                      icon: Icons.lock_outline_rounded,
                      enableSuffix: true,
                      suffixIcon: _pass
                          ? Icons.remove_red_eye_rounded
                          : Icons.visibility_off,
                      titleText: "Confirm Password",
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 24),
                      hintText: "*************",
                      keyboardType: TextInputType.visiblePassword,
                      isObscureText: !_pass,
                      onTapSuffix: () {
                        setState(() {
                          _pass = !_pass;
                        });
                      },
                      errorText: _errorConfirmPassword,
                    ),
                    CommonButton(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      buttonText:
                          "Apply Changes", //AppLocalizations(context).of("Apply_text"),
                      onTap: () {
                        if (_allValidation()) {
                          showProgress(context,
                              msg: "Changing password in progress");
                          Client().post(
                              Uri.parse(AppUrls.setPass +
                                  context.read<SchoolController>().state['id']),
                              body: {
                                "new_password": _newController.text.trim(),
                                "confirm_password":
                                    _confirmController.text.trim(),
                              }).then((value) {
                            var data = jsonDecode(value.body);
                            debugPrint("Change response => ${value.body}");
                            if (value.statusCode == 200 ||
                                value.statusCode == 201) {
                              Routes.popPage(context);
                              _newController.clear();
                              _confirmController.clear();
                              showSuccessDialog(
                                  "Password changed successfully", context,
                                  onPressed: () {
                                Routes.popPage(context);

                                if (context
                                        .read<SchoolController>()
                                        .state['role'] ==
                                    'Finance') {
                                      // for finance after changing the password are redirected to dashboard
                                  BlocProvider.of<WidgetController>(context)
                                      .pushWidget(const Dashboard());
                                  BlocProvider.of<TitleController>(context)
                                      .setTitle("Dashboard");
                                  BlocProvider.of<SideBarController>(context)
                                      .changeSelected(0);
                                      context.read<FinanceFirstTimeController>().setFirstTime(false);
                                } else {
                                  // for admins after changing the password are redirected to system settings
                                  context
                                      .read<WidgetController>()
                                      .pushWidget(const SystemSettings());
                                  context
                                      .read<TitleController>()
                                      .setTitle("System Settings");
                                  context
                                      .read<SideBarController>()
                                      .changeSelected(11);
                                }
                              });
                              showMessage(
                                  context: context,
                                  msg: "Password Updated successfully",
                                  type: 'success');
                            } else {
                              Routes.popPage(context);
                              showMessage(
                                  context: context,
                                  // float: true,
                                  duration: 6,
                                  msg: data['error'],
                                  type: 'warning');
                            }
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;
    if (_newController.text.trim().isEmpty) {
      _errorNewPassword =
          "Password cannot be empty"; //AppLocalizations(context).of('password_cannot_empty');
      isValid = false;
    } else if (_newController.text.trim().length < 6) {
      _errorNewPassword =
          "Enter a valid password of more than 6 characters.."; //AppLocalizations(context).of('valid_new_password');
      isValid = false;
    } else {
      _errorNewPassword = '';
    }
    if (_confirmController.text.trim().isEmpty) {
      _errorConfirmPassword = "Password cannot be empty..";
      //AppLocalizations(context).of('password_cannot_empty');
      isValid = false;
    } else if (_newController.text.trim() != _confirmController.text.trim()) {
      _errorConfirmPassword = "Password doesn't match with the your provided!!";
      //AppLocalizations(context).of('password_not_match');
      isValid = false;
    } else {
      _errorConfirmPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
