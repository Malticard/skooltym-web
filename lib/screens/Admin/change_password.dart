import '../../exports/exports.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.1,
          bottom:MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          left: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 24, right: 24),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Enter new password",
                    textAlign: TextAlign.start,
                    style: TextStyle(
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
            controller: _newController,
            titleText: "New password",
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            hintText: "************",
            keyboardType: TextInputType.visiblePassword,
            isObscureText: true,
            onChanged: (String txt) {},
            errorText: _errorNewPassword,
          ),
          CommonTextField(
            controller: _confirmController,
            titleText: "Confirm Password",
            //AppLocalizations(context).of("confirm_password"),
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            hintText: "*************",
            keyboardType: TextInputType.visiblePassword,
            isObscureText: true,
            onChanged: (String txt) {},
            errorText: _errorConfirmPassword,
          ),
          CommonButton(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            buttonText:
                "Apply Changes", //AppLocalizations(context).of("Apply_text"),
            onTap: () {
              if (_allValidation()) {
                Navigator.pop(context);
              }
            },
          )
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
