// ignore_for_file: library_private_types_in_public_api

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
    // context.watch<OnlineCheckerController>().checkOnline();
    super.initState();
    // // get saved appTheme
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color.fromARGB(204, 9, 87, 139),
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 50),
              child: Text(
                "Login",
                style: TextStyles(context).getTitleStyle().copyWith(
                      color: Colors.white,
                      fontSize: Responsive.isMobile(context) ? 30 : 40,
                    ),
              ),
            ),
            Expanded(
              child: Responsive(
                mobile: Padding(
                  padding: EdgeInsets.only(top: size.width * 0.180),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.9,
                            child: SvgPicture.asset(
                              "assets/vectors/mother_child.svg",
                            ),
                          ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.13),
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
                      ],
                    ),
                  ),
                ),
                desktop: Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.020, bottom: size.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const  EdgeInsets.only(
                                left: 60,
                                right: 60,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width ,
                                height:
                                   MediaQuery.of(context).size.height /2,
                                child: SvgPicture.asset(
                                  "assets/vectors/mother_child.svg",
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
                              right: size.width / 16,
                              left: size.width / 16,
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
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black26
                                  : Colors.white.withOpacity(1)),
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: SvgPicture.asset(
                          "assets/vectors/mother_child.svg",
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
                  children: [
                    Image.asset(
                      "assets/images/malticard.png",
                      width: 80,
                      height: 80,
                    ),
                    Text(
                      "Powered by Malticard",
                      style: TextStyles(context).getBoldStyle().copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ), 
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // String currentValue = "Admin";
  final formKey = GlobalKey<FormState>();
  Widget _buildForm() {
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
            CommonTextField(
              fieldColor: Theme.of(context).cardColor,
              icon: Icons.email_outlined,
              controller: _emailController,
              errorText: _errorEmail,
              titleText: "Contact",
              padding: padding,
              enableSuffix: true,
              hintText: "Provider your registered contact",
              keyboardType: TextInputType.number,
            ),
            const Space(space: 0.01),
            CommonTextField(
              fieldColor: Theme.of(context).cardColor,
              icon: Icons.lock_outline,
              enableSuffix: true,
              suffixIcon: showPassword
                  ? Icons.remove_red_eye_rounded
                  : Icons.visibility_off,
              titleText: "Password", //AppLocalizations(context).of("password"),
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
              buttonText: "Sign in", //AppLocalizations(context).of("login"),
              onTap: () {
                // if (context.watch<OnlineCheckerController>().state == true) {
                if ( formKey.currentState!.validate()) {
                  loginUser(
                      context, _emailController.text, _passwordController.text);
                }
                // } else {
                //   showMessage(
                //       context: context, msg: "Your offline..", type: 'warning');
                // }
              },
            ),
            Space(
              space: Responsive.isDesktop(context) ? 0.045 : 0.01,
            ),
          ],
        ),
      ),
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
            onTap: (){
              BlocProvider.of<TitleController>(context).setTitle("Verify Phone");
              Routes.namedRoute(context,Routes.phoneVerify);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
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
