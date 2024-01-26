// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:admin/controllers/utils/LoaderController.dart';

import '/exports/exports.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorEmail = '';
  final _emailController = TextEditingController();
  //
  // final _roleController = TextEditingController();
  String _errorPassword = '';
  //
  final _passwordController = TextEditingController();
  //
  EdgeInsets padding = const EdgeInsets.only(left: 24, right: 24, bottom: 5);
  bool showPassword = false;
  // login logic
  Client c = Client();
  @override
  void initState() {
    context.read<ThemeController>().getTheme();
    super.initState();
    // // get saved appTheme
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Theme.of(context).brightness == Brightness.dark
      //     ? Theme.of(context).scaffoldBackgroundColor
      //     : Color.fromARGB(204, 169, 9, 142),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //#9049E4 to #DD74A4 (Left to right)
            colors: [Color(0xFF9049E4), Color(0xFFDD74A4)],
            stops: const [0.0, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: RemoveFocuse(
          onClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.5, end: 1),
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 1600),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 40,
                          right: size.width / 20,
                          left: size.width / 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Image.asset(
                                "assets/images/Login-3.png",
                                width: MediaQuery.of(context).size.width / 6,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // children: [
                              //   InkWell(
                              //     onHover: (x) {
                              //       print(x);
                              //     },
                              //     child: Container(
                              //       padding: const EdgeInsets.all(8.0),
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         color: Colors.white,
                              //       ),
                              //       child: Text(
                              //         "Home",
                              //         style: TextStyles(context)
                              //             .getBoldStyle()
                              //             .copyWith(
                              //                 // color: Colors.white,
                              //                 // fontSize: Responsive.isMobile(context) ? 30 : 40,
                              //                 ),
                              //       ),
                              //     ),
                              //   ),
                              //   Container(
                              //     padding: const EdgeInsets.all(10),
                              //     child: Text(
                              //       "About Us",
                              //       style: TextStyles(context)
                              //           .getRegularStyle()
                              //           .copyWith(
                              //             color: Colors.white,
                              //             // fontSize: Responsive.isMobile(context) ? 30 : 40,
                              //           ),
                              //     ),
                              //   ),
                              //   Container(
                              //     padding: const EdgeInsets.all(10),
                              //     child: Text(
                              //       "Pricing",
                              //       style: TextStyles(context)
                              //           .getRegularStyle()
                              //           .copyWith(
                              //             color: Colors.white,
                              //             // fontSize: Responsive.isMobile(context) ? 30 : 40,
                              //           ),
                              //     ),
                              //   ),
                              //   Container(
                              //     padding: const EdgeInsets.all(10),
                              //     child: Text(
                              //       "Contact",
                              //       style: TextStyles(context)
                              //           .getRegularStyle()
                              //           .copyWith(
                              //             color: Colors.white,
                              //             // fontSize: Responsive.isMobile(context) ? 30 : 40,
                              //           ),
                              //     ),
                              //   ),
                              // ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Responsive(
                          mobile: Padding(
                            padding: EdgeInsets.only(top: size.width * 0),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Image.asset(
                                    "assets/images/Login-1.png",
                                    width:
                                        MediaQuery.of(context).size.width * 1.6,
                                    height:
                                        MediaQuery.of(context).size.width * 0.9,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black26
                                            : Colors.white),
                                    child: _buildForm(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          desktop: Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 0.020,
                                bottom: size.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 60,
                                          right: 60,
                                        ),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.42,
                                          child: Image.asset(
                                            "assets/images/Login-1.png",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: size.width / 10,
                                        left: size.width / 10,
                                        bottom: size.width / 46,
                                        top: size.width / 26),
                                    height: size.height * 1.8,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    child: _buildForm(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          tablet: Padding(
                            padding: EdgeInsets.only(top: size.width * 0.070),
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.03,
                                    bottom: size.height * 0.093,
                                    right: size.width / 17,
                                    left: size.width / 17,
                                  ),
                                  height: size.height * 0.35,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black26
                                          : Colors.white.withOpacity(1)),
                                  child: _buildForm(),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Image.asset(
                                    "assets/images/Login-1.png",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.030,
                            right: size.width * 0.030,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(),
                              Text(
                                "Powered by ",
                                style:
                                    TextStyles(context).getBoldStyle().copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                              ),
                              Image.asset(
                                "assets/images/Login-2.png",
                                width: 180,
                                height: 70,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  // String currentValue = "Admin";
  final formKey = GlobalKey<FormState>();
  Widget _buildForm() {
    return Consumer<LoaderController>(
      builder: (context, controller, child) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              direction: Axis.vertical,
              children: <Widget>[
                Space(
                  space: Responsive.isDesktop(context) ? 0.035 : 0.07,
                ),
                Center(
                  child: Text(
                    "Login",
                    style: TextStyles(context).getTitleStyle().apply(color:Theme.of(context).colorScheme.primary,),
                  ),
                ),
                CommonTextField(
                  readOnly: controller.isLoading ? true : false,
                  fieldColor: Theme.of(context).cardColor,
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  errorText: _errorEmail,
                  titleText: "Contact",
                  padding: padding,
                  enableSuffix: true,
                  validate: (value) {
                    if (value!.isEmpty) {
                      _errorEmail = "Contact can't be empty";
                      setState(() {});
                    }
                    return null;
                  },
                  hintText: "Provider your registered contact",
                  keyboardType: TextInputType.number,
                ),
                const Space(space: 0.01),
                CommonTextField(
                  fieldColor: Theme.of(context).cardColor,
                  icon: Icons.lock_outline,
                  readOnly: controller.isLoading ? true : false,
                  enableSuffix: true,
                  validate: (value) {
                    if (value!.isEmpty) {
                      _errorPassword = "Password can't be empty";
                      setState(() {});
                    }
                    return null;
                  },
                  suffixIcon: showPassword
                      ? Icons.remove_red_eye_rounded
                      : Icons.visibility_off,
                  titleText:
                      "Password", //AppLocalizations(context).of("password"),
                  padding: padding,
                  hintText: "************",
                  isObscureText: !showPassword,
                  errorText: _errorPassword,
                  keyboardType: TextInputType.text,
                  onTapSuffix: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  controller: _passwordController,
                ),
                _forgotYourPasswordUI(),
                CommonButton(
                  height: 55,
                  padding: padding.copyWith(left: 30, right: 30),
                  backgroundColor: controller.isLoading
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor,
                  buttonTextWidget: controller.isLoading
                      ? CircularProgressIndicator.adaptive()
                      : Text(
                          "Sign in",
                          style: TextStyles(context).getBoldStyle().copyWith(
                                color: Colors.white,
                              ),
                        ),
                  onTap: controller.isLoading
                      ? () {}
                      : () {
                          controller.setLoading = true;

                          // if (context.watch<OnlineCheckerController>().state == true) {
                          if (formKey.currentState!.validate()) {
                            if (_emailController.text.trim().isEmpty) {
                              controller.setLoading = false;
                              _errorEmail = "Contact can't be empty";
                              setState(() {});
                            }
                            if (_passwordController.text.trim().isEmpty) {
                              controller.setLoading = false;
                              _errorPassword = "Password can't be empty";
                              setState(() {});
                            }
                            if (_emailController.text.trim().isNotEmpty &&
                                _passwordController.text.trim().isNotEmpty) {
                              _errorPassword = "";
                              _errorEmail = "";
                              setState(() {});
                              loginUser(context, _emailController.text,
                                  _passwordController.text);
                            }
                          }
                        },
                ),
                Space(
                  space: Responsive.isDesktop(context) ? 0.045 : 0.01,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _forgotYourPasswordUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onTap: () {
              BlocProvider.of<TitleController>(context)
                  .setTitle("Verify Phone");
              Routes.namedRoute(context, Routes.phoneVerify);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Forgot Password",
                style: TextStyles(context).getRegularStyle().copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).primaryColor
                          : Colors.white54,
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
    if (_emailController.text.trim().isEmpty) {
      _errorEmail =
          "Email can't be empty"; //AppLocalizations(context).of('email_cannot_empty');
      isValid = false;
    } else if (!Validator_.validateEmail(_emailController.text.trim())) {
      _errorEmail =
          "Provide a valid email"; //AppLocalizations(context).of('enter_valid_email');
      isValid = false;
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword =
          "Password field can't be empty"; //AppLocalizations(context).of('password_cannot_empty');
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      _errorPassword =
          "A password must be of more than 6 characters"; //AppLocalizations(context).of('valid_password');
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }
}
