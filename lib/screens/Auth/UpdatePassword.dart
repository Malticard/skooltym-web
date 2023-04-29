import '/exports/exports.dart';

///  Created by bruno on 15/02/2023.
class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  String _errorNewPassword = '';
  String _errorConfirmPassword = '';
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _confirm = false;
  bool _pass = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Responsive(
          mobile: Padding(
            padding: EdgeInsets.only(top: size.width * 0.180),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.23),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black26
                            : Colors.white),
                    child: buildForm(),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.021,
                  left: MediaQuery.of(context).size.height * 0.031,
                  right: MediaQuery.of(context).size.height * 0.031,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: SvgPicture.asset(
                      "assets/images/back2Skool.svg",
                    ),
                  ),
                ),
              ],
            ),
          ),
          desktop: Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.030, bottom: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.width * 0.0150,
                          left: 60,
                          right: 60,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.43,
                          child: SvgPicture.asset(
                            "assets/images/back2Skool.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: size.width / 16,
                        left: size.width / 16,
                        bottom: size.width / 46,
                        top: size.width / 26),
                    child: Container(
                      height: size.height * 0.78,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black26
                              : Colors.white.withOpacity(1)),
                      child: buildForm(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          tablet: Padding(
            padding: EdgeInsets.only(top: size.width * 0.170),
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    bottom: size.height * 0.093,
                    right: size.width / 17,
                    left: size.width / 17,
                  ),
                  child: Container(
                    height: size.height * 0.55,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black26
                            : Colors.white.withOpacity(1)),
                    child: buildForm(),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SvgPicture.asset(
                    "assets/images/back2Skool.svg",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return ListView(
      children: <Widget>[
        const CommonAppbarView(
          titleText: "Set new password",
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 10.0, left: 24, right: 24),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Ensure your new password is at least 6 characters long and different from your current password.",
                  textAlign: TextAlign.start,
                  style: TextStyles(context).getDescriptionStyle().copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).disabledColor,
                      ),
                ),
              ),
            ],
          ),
        ),
        CommonTextField(
          enableSuffix: true,
          suffixIcon:
              !_pass ? Icons.remove_red_eye_rounded : Icons.visibility_off,
          controller: _newController,
          icon: Icons.lock_outline,
          titleText: "New password",
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
          hintText: "************",
          keyboardType: TextInputType.visiblePassword,
          isObscureText: _pass,
          onTapSuffix: () {
            setState(() {
              _pass = !_pass;
            });
          },
          errorText: _errorNewPassword,
        ),
        CommonTextField(
          enableSuffix: true,
          suffixIcon:
              !_confirm ? Icons.remove_red_eye_rounded : Icons.visibility_off,
          icon: Icons.lock_outline,
          controller: _confirmController,
          titleText: "Confirm Password",
          //AppLocalizations(context).of("confirm_password"),
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          hintText: "*************",
          keyboardType: TextInputType.visiblePassword,
          isObscureText: _confirm,
          onTapSuffix: () {
            setState(() {
              _confirm = !_confirm;
            });
          },
          errorText: _errorConfirmPassword,
        ),
        CommonButton(
          height: 50,
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 10.0, left: 24, right: 24),
          buttonTextWidget: Text(
            "Save password",
            style: TextStyles(context)
                .getRegularStyle()
                .copyWith(color: Colors.white),
          ),
          onTap: () {
            if (_allValidation()) {
              showProgress(context, msg: "Updating password in progress");
              Client().post(
                  Uri.parse(AppUrls.setPassword +
                      context.read<ForgotPasswordController>().state['id']),
                  body: {
                    "new_password": _newController.text.trim(),
                    "confirm_password": _confirmController.text.trim(),
                  }).then((value) {
                  final Map<String, dynamic> data = jsonDecode(value.body);

                debugPrint("Change response => ${value.body}");
                if (value.statusCode == 200 || value.statusCode == 201) {
                  Navigator.pop(context);
                  debugPrint(data.toString());
                  // if (data['status'] == 200) {
                  _newController.clear();
                  _confirmController.clear();
                  showSuccessDialog("Password Updated", context, onPressed: () {
                    Routes.namedRemovedUntilRoute(context, Routes.login);
                  });
                } else {
                  showMessage(
                      context: context, msg: data['error'], type: 'danger');
                }
              });
            }
          },
        )
      ],
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
