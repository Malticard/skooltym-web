// ignore_for_file: use_build_context_synchronously

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
  Map<String, dynamic> schoolData = {};
  List<String> errorFields = List.generate(formFields.length, (i) => '');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: BlocConsumer<ImageUploadController, Map<String, dynamic>>(
        listener: (context, state) {
          setState(() {
            schoolData = state;
          });
        },
        builder: (context, state) {
          return SizedBox(
            width: Responsive.isDesktop(context) ? size.width / 3 : size.width,
            height: Responsive.isMobile(context)
                ? size.height / 1.3
                : size.width / 2.3,
            child: Padding(
              padding: padding,
              child: CommonFormFields(
                formTitle: "Add a new Staff member",
                padding: padding,
                formFields: formFields,
                numberOfDropDowns: 2,
                formControllers: _formControllers,
                buttonText: "Submit Staff Details",
                errorMsgs: errorFields,
                onSubmit: () {
                  if (validateEmail(_formControllers[1].text, context) !=
                      false) {
                    showProgress(context, msg: "Adding new staff member...");
                    _handleFormUpload().then((value) {
                      // debugPrint("Staff data -> ${value.reasonPhrase}");
                      if (value.statusCode == 200 || value.statusCode == 201) {
                        Routes.popPage(context);
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
                      // showSuccessDialog(
                      //     _formControllers[0].text.trim().split(" ")[1], context);
                    }).whenComplete(() {
                      Routes.popPage(context);
                    });
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<StreamedResponse> _handleFormUpload() async {
    // debugPrint("handling form upload with ${context.read<ImageUploadController>().state}");
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
    if (kIsWeb && schoolData.isNotEmpty) {
      request.files.add(MultipartFile("image", schoolData['image'],
          context.read<ImageUploadController>().state['size'],
          filename: context.read<ImageUploadController>().state['name']));
    } else if (_formControllers[3].text.trim().isNotEmpty) {
      request.files.add(
        MultipartFile(
          'image',
          File(_formControllers[3].text.trim()).readAsBytes().asStream(),
          File(_formControllers[3].text.trim()).lengthSync(),
          filename: _formControllers[3].text.trim().split("/").last.trim(),
        ),
      );
    } else {}

    //
    request.fields['staff_password'] = "qwerty";
    request.fields['staff_key[key]'] = "";
    // ===================================================================
    var response = request.send();
    //
    return response;
  }
}
