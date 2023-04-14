import '/exports/exports.dart';
// export 'package:flutter/cupertino.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
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
  ];

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
    // 0756598425
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 2.2,
        child: Padding(
          padding: padding,
          child: CommonFormFields(
            padding: padding,
            formFields: formFields,
            numberOfDropDowns: 2,
            formControllers: _formControllers,
            buttonText: "Submit Staff Details",
            errorMsgs: errorFields,
            onSubmit: () {
              if (validateEmail(_formControllers[1].text, context) != false) {
                  Routes.popPage(context);

                _handleFormUpload().then((value) {
                  debugPrint("Staff data -> ${value.reasonPhrase}");
                  if (value.statusCode == 200 || value.statusCode == 201) {
                    //  bottom msg
                    showMessage(
                      context: context,
                      type: 'success',
                      msg: "Added new staff successfully",
                    );

                    //  end of bottom msg
                  } else {
                    showMessage(
                      context: context,
                      type: 'danger',
                      msg: "Error ${value.reasonPhrase}",
                    );
                    Routes.popPage(context);

                    // showSuccessDialog(
                    //     _formControllers[0].text.trim().split(" ")[1],
                    //     context);
                  }
                    showSuccessDialog(
                      _formControllers[0].text.trim().split(" ")[1], context);
                }).whenComplete(() {
                
                  // Routes.popPage(context);
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Future<StreamedResponse> _handleFormUpload() async {
    String uri = _formControllers[3].text.trim();
    debugPrint("handling form upload with $uri");
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
    request.files.add(MultipartFile(
        'image',
        File(_formControllers[3].text.trim()).readAsBytes().asStream(),
        File(_formControllers[3].text.trim()).lengthSync(),
        filename: uri.split("/").last));
    //
    request.fields['staff_password'] = "qwerty";
    request.fields['staff_key[key]'] = "";
    // ===================================================================
    var response = request.send();
    //
    return response;
  }
}
