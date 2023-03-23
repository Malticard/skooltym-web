import '/exports/exports.dart';
// export 'package:flutter/cupertino.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> with TickerProviderStateMixin {
  AnimationController? staffAnimationController;
  // form details
  static final List<Map<String, dynamic>> formFields = [
    {
      "title": "Full Name *",
      "hint": "e.g John",
      "password": false,
      'icon': Icons.person_2_outlined
    },
    {
      "title": "Email*",
      "hint": "e.g example@gmail.com",
      "password": false,
      'icon': Icons.email_outlined
    },
    {
      "title": "Phone*",
      "hint": "e.g 07xxxx-xx",
      "password": false,
      'icon': Icons.phone_outlined
    },
    {'title': 'Staff Profile', 'profile': 5},
    {
      "title": "Gender*",
      "hint": "Select gender",
      "data": [
        "Select gender",
        "Male",
        "Female",
      ]
    },
    {
      "title": "Assign Role*",
      "hint": "Select role",
      "data": [
        "Select a role",
        "Admin",
        "Teacher",
        "Finance",
      ]
    },
    {
      "title": "Password*",
      "hint": "e.g *********",
      "password": true,
      'icon': Icons.lock_outline,
      'enableSuffix': true,
      'suffix': Icons.visibility_off,
    },
    {
      "title": "Confirm Password*",
      "hint": "e.g *********",
      "password": true,
      'icon': Icons.lock_outline,
      'enableSuffix': true,
      'suffix': Icons.visibility_off,
    },
  ];

  @override
  void initState() {
    staffAnimationController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 950),
    );
    staffAnimationController!.forward();
    super.initState();
  }

  final List<TextEditingController> _formControllers =
      List.generate(formFields.length, (index) => TextEditingController());

  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  // error fields
  List<String> errorFields = List.generate(formFields.length, (i) => '');
  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    return BottomTopMoveAnimationView(
      animationController: staffAnimationController!,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.13,
            // top: size.width * 0.03,
            right: size.width * 0.13,
            bottom: size.width * 0.02),
        child: CommonFormFields(
          padding: padding,
          formFields: formFields,
          numberOfDropDowns: 2,
          formControllers: _formControllers,
          buttonText: "Submit Staff Details",
          errorMsgs: errorFields,
          onSubmit: () {
            if (validateEmail(_formControllers[1].text, context) != false &&
                validateTextControllers(_formControllers)) {
              if (_formControllers[6].text == _formControllers[7].text) {
                // debugPrint("Result => $data");
                _handleFormUpload()
                    .then(
                      (value) => showSuccessDialog(
                          _formControllers[0].text.trim().split(" ")[1],
                          context),
                    )
                    .catchError(
                      (onError) => () => showMessage(
                          context: context,
                          msg: 'An error occurred!! ',
                          type: 'danger'),
                    )
                    .whenComplete(() => showMessage(
                          context: context,
                          type: 'success',
                          msg: "Added new staff successfully",
                        ));
              } else {
                setState(() {
                  errorFields[6] = "Password mismatch";
                });
              }
            }
          },
        ),
      ),
    );
  }

  Future<StreamedResponse> _handleFormUpload() async {
    String uri = _formControllers[3].text.trim();

    //
    var request = MultipartRequest('POST', Uri.parse(AppUrls.addStaff));
    // =============================== form fields =======================
    request.fields['staff_school'] =
        "${context.read<SchoolController>().state['school']}";
    request.fields['staff_fname'] =
        _formControllers[0].text.trim().split(" ")[0];
    request.fields['staff_lname'] =
        _formControllers[0].text.trim().split(" ")[1];
    request.fields['staff_contact'] = _formControllers[2].text;
    request.fields['staff_email'] = _formControllers[1].text.trim();
    // --------------------------- form files ---------------------------
    request.fields['staff_role'] =
        await assignRole(_formControllers[5].text.trim());
    request.fields['staff_gender'] = _formControllers[4].text.trim();
    //
    request.files.add(MultipartFile('staff_profile_pic',
        File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
        filename: uri.split("/").last));
    //
    request.fields['staff_password'] = _formControllers[6].text.trim();
    request.fields['staff_key[key]'] = "";
    // ===================================================================
    var response = request.send();
    //
    return response;
  }
}
