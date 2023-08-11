// ignore_for_file: use_key_in_widget_constructors

import '/exports/exports.dart';

class PhoneVerify extends StatefulWidget {
  @override
  _PhoneVerifyState createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify>
    with TickerProviderStateMixin {
  AnimationController? forgotController;
  String _errorPhone = '';
  final TextEditingController _phoneVerificationController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    forgotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      value: 0,
    );
    forgotController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BottomTopMoveAnimationView(
          animationController: forgotController!,
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
                      child: buildList(),
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
                        "assets/vectors/forgot_pass.svg",
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
                    flex: 3,
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
                            height: MediaQuery.of(context).size.height / 1.2,
                            child: SvgPicture.asset(
                              "assets/vectors/forgot_pass.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: size.width / 16,
                          left: size.width / 16,
                          bottom: size.width / 46,
                          top: size.height / 5),
                      child: Container(
                        height: size.height * 0.78,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black26
                                    : Colors.white.withOpacity(1)),
                        child: buildList(),
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
                      child: buildList(),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SvgPicture.asset(
                      "assets/vectors/forgot_pass.svg",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return CommonAppbarView(
      // iconData: Icons.arrow_back,
      titleText:
          "Phone Verification", //AppLocalizations(context).of("forgot_your_Password"),
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildList() {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        appBar(),
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 10.0, left: 24, right: 24),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Provide the phone number that was registered at the time of creating your account.",
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
        ...[
          CommonTextField(
            fieldColor: Theme.of(context).cardColor,
            controller: _phoneVerificationController,
            titleText:
                "Phone number", //AppLocalizations(context).of("your_mail"),
            errorText: _errorPhone,
            icon: Icons.phone,
            isObscureText: false,

            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            hintText: "Enter the phone number that was registered",
            keyboardType: TextInputType.phone,
            onChanged: (String txt) {},
          ),
          CommonButton(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            buttonText:
                "Submit contact details", //AppLocalizations(context).of("send"),
            onTap: () {
              if (_allValidation()) {
                showProgress(context,
                    msg: "${_phoneVerificationController.text} verification");

                Client().post(Uri.parse(AppUrls.forgotPassword), body: {
                  "scontact": _phoneVerificationController.text
                }).then((value) {
                  var data = jsonDecode(value.body);
                  if (kDebugMode) {
                    print("data => ${value.body}");
                  }
                  if (value.statusCode == 200 || value.statusCode == 201) {
                    // if (data['otp'] != null) {
                    Routes.popPage(context);
                    context.read<ForgotPasswordController>().updateForgot(data);
                    BlocProvider.of<TitleController>(context)
                        .setTitle("verify OTP", "guest");
                    showMessage(
                        context: context,
                        msg: "${_phoneVerificationController.text} verified",
                        type: 'success');
                    Routes.push(
                        Verification(
                          phone: _phoneVerificationController.text,
                          code: data['id'].toString(),
                        ),
                        context);
                    // }
                  }
                });
              }
              ;
            },
          )
        ],
      ],
    );
  }

  bool _allValidation() {
    bool isValid = true;
    // phone verification
    if (_phoneVerificationController.text.trim().isEmpty) {
      _errorPhone = "Phone contact cannot be empty";
      isValid = false;
    } else if (_phoneVerificationController.text.trim().length < 10 ||
        _phoneVerificationController.text.trim().length > 10) {
      _errorPhone = "Phone contact must be 10 digits";
      isValid = false;
    }
    setState(() {});
    return isValid;
  }
}
