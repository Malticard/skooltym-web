import '/exports/exports.dart';

class Verification extends StatefulWidget {
  final String phone;
  final String code;
  const Verification({Key? key,this.phone = '', required this.code}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    Color focusedBorderColor = Theme.of(context).primaryColor;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    Color borderColor = Theme.of(context).primaryColor;
     Size size = MediaQuery.of(context).size;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
 buildPinPut(){
    return ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Space(
              space: 0.1,
            ),
            Center(
              child: Text(
                "Verification",
                style: TextStyles(context).getTitleStyle(),
              ),
            ),
            const Space(
              space: 0.1,
            ),
            Center(
              child: Text("Enter the code sent to the number ${widget.code}"),
            ),
            const Space(
              space: 0.03,
            ),
            Center(
              child: Text(widget.phone,style: TextStyles(context).getDescriptionStyle(),),
            ),
            const Space(
              space: 0.06,
            ),
            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 6,
                controller: pinController,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                validator: (value) {
                  return value!.isEmpty ? 'OTP code is required':null;
                },
                onClipboardFound: (value) {
                  debugPrint('onClipboardFound: $value');
                  // pinController.setText(value);
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            const Space(
              space: 0.06,
            ),
            CommonButton(
              padding: const EdgeInsets.only(left: 44, right: 44),
              onTap: () {
                if(formKey.currentState!.validate()){
                  
                
                focusNode.unfocus();
                print("Id => ${widget.code}");
                // showProgress(context);
                 Client().post(Uri.parse(AppUrls.verifyOtp+widget.code),body: json.encode({"new_otp":pinController.text})).then((value) {
                  print(value.body);
                  if (value.statusCode == 200 || value.statusCode == 201) {
                    showMessage(context: context,msg: "Verification successful",type:'success');
                    Routes.push(const UpdatePassword(), context);
                  } else {
                    // var data = jsonDecode(value.body);
                    showMessage(context: context,msg: value.body,type:'error');
                  }
                 });
                }
                    // Routes.push(UpdatePassword(), context);
              },
              buttonText: 'Verify',
            ),
            const Space(
              space: 0.06,
            ),
            const Center(
              // padding: EdgeInsets.only(left: 44, right: 44),
              child:Text("Didn't receive a code?"),
                  // TextButton(onPressed: (){}, child: Text("Resend"),),
                
            ),
            TextButton(onPressed: (){
              Client().post(Uri.parse(AppUrls.forgotPassword),body: {
                "scontact":widget.phone
              }).then((value) {
                if(value.statusCode == 200){
                  showMessage(context: context,msg: "Verification code resent to ${widget.phone}",type:'info');
                }
              });

            }, child: const Text("Resend"),),
          ],
        );
  }
    /// Optionally you can use form to validate the Pinput
    return Scaffold(
      body: Form(
        key: formKey,
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
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black26
                                  : Colors.white),
                          child: buildPinPut(),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.43,
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
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black26
                                    : Colors.white.withOpacity(1)),
                            child: buildPinPut(),
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
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black26
                                  : Colors.white.withOpacity(1)),
                          child: buildPinPut(),
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
    /// End of Scaffold
  // fucntion to resend a code after 2 seconds
 
  }
 
  void resendCode() {
     Future.delayed(const Duration(seconds: 2), () {
          pinController.clear();
          focusNode.unfocus();
        });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        pinController.text = "";  // clear the pin
      });
    });
  }
}
