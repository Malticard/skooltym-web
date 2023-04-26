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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.1,
          bottom:MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          left: MediaQuery.of(context).size.width * 0.1),
      child: Card(
        color: Theme.of(context).brightness == Brightness.light ? Theme.of
          (context).scaffoldBackgroundColor: Theme.of(context).canvasColor,
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
              // Space(space: 0.06,),
              CommonTextField(
                enableSuffix: true,
                 suffixIcon: _confirm
                            ? Icons.remove_red_eye_rounded
                            : Icons.visibility_off,
                controller: _newController,
                titleText: "New password",
                icon: Icons.lock_outline_rounded,
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
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
                controller: _confirmController,
                icon: Icons.lock_outline_rounded,
                  enableSuffix: true,
                        suffixIcon: !_pass
                            ? Icons.remove_red_eye_rounded
                            : Icons.visibility_off,
                titleText: "Confirm Password",
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                hintText: "*************",
                keyboardType: TextInputType.visiblePassword,
                isObscureText: _pass,
                 onTapSuffix: () {
                          setState(() {
                            _pass = !_pass;
                          });
                        },
                errorText: _errorConfirmPassword,
              ),
              CommonButton(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                buttonText:
                    "Apply Changes", //AppLocalizations(context).of("Apply_text"),
                onTap: () {
                  if (_allValidation()) {
                    Client().post(Uri.parse("${AppUrls.setPass + context.read<SchoolController>().state['id']}/"+ context.read<SchoolController>().state['_token']), body: {
                      "new_password": _newController.text.trim(),
                      "confirm_password": _confirmController.text.trim(),
                    }).then((value) {
                      debugPrint("Change response => ${value.body}");
                      if (value.statusCode == 200 || value.statusCode == 201) {
                        final Map<String, dynamic> data = jsonDecode(value.body);
                        debugPrint(data.toString());
                        // if (data['status'] == 200) {
                          _newController.clear();
                          _confirmController.clear();
                         showMessage(context: context,msg: value.body,type: 'success');
  
                      } else {
                         showMessage(context: context,msg: value.body,type: 'danger');

                      }
                    });
                  }
                },
              )
            ],
          ),
        ),
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
