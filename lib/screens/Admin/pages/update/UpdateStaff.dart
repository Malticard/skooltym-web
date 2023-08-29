// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import '/exports/exports.dart';

class UpdateStaff extends StatefulWidget {
  final Staff staff;
  const UpdateStaff({super.key, required this.staff});

  @override
  State<UpdateStaff> createState() => _UpdateStaffState();
}

class _UpdateStaffState extends State<UpdateStaff> {
  List<TextEditingController> _formControllers = <TextEditingController>[];
  @override
  void initState() {
    super.initState();
    _formControllers = <TextEditingController>[
      TextEditingController(
          text: "${widget.staff.staffFname} ${widget.staff.staffLname}"),
      TextEditingController(text: widget.staff.staffEmail),
      TextEditingController(text: widget.staff.staffContact.toString()),
      TextEditingController(text: ""),
      TextEditingController(text: widget.staff.staffGender),
      TextEditingController(text: widget.staff.staffRole.roleType),
    ];
  }

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
  Map<String, dynamic> imageData = {};
  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  // error fields
  List<String> errorFields = List.generate(formFields.length, (i) => '');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageUploadController, Map<String, dynamic>>(
      listener: (context, state) {
        setState(() {
          imageData = state;
        });
      },
      builder: (context, state) {
        return Padding(
          padding: padding,
          child: CommonFormFields(
              initialPic: widget.staff.staffProfilePic,
              padding: padding,
              formTitle: "Update Staff Details",
              formFields: formFields,
              numberOfDropDowns: 2,
              formControllers: _formControllers,
              buttonText: "Submit Staff Details",
              errorMsgs: errorFields,
              onSubmit: () {
                if (validateEmail(_formControllers[1].text, context) != false) {
                  log("Email verified");
                  if (_formControllers[0].text.split(" ").last.isEmpty) {
                    log("Staff last name is required");
                    setState(() {
                      errorFields[0] = "Staff last name is required";
                    });

                    // Routes.popPage(context);
                    showMessage(
                        context: context,
                        msg: "Staff last name is required",
                        type: 'warning');
                  } else {
                    showProgress(context, msg: "Updating staff in progress");
                    _handleFormUpload(widget.staff.id).then((value) {
                      if (value.statusCode == 200 || value.statusCode == 201) {
                        Routes.popPage(context);
                        //  bottom msg
                        showMessage(
                          context: context,
                          type: 'success',
                          msg: "Updated staff successfully",
                        );
                        //  end of bottom msg
                      } else {
                        showProgress(context,
                            msg: "Updating staff in progress");
                        showMessage(
                          context: context,
                          type: 'danger',
                          msg: "Error ${value.reasonPhrase}",
                        );
                      }
                    }).whenComplete(() {
                      Routes.popPage(context);
                    });
                  }
                }
              }),
        );
      },
    );
  }

  Future<StreamedResponse> _handleFormUpload(String id) async {
    String uri = _formControllers[3].text.trim();
    debugPrint("handling form upload with $uri");
    //
    var request = MultipartRequest('POST', Uri.parse(AppUrls.updateStaff + id));
    // =============================== form fields =======================
    request.fields['staff_school'] =
        "${context.read<SchoolController>().state['school']}";
    request.fields['staff_fname'] =
        _formControllers[0].text.trim().split(" ")[0].trim();
    request.fields['staff_lname'] =
        _formControllers[0].text.trim().split(" ")[1].trim();
    request.fields['staff_contact'] = _formControllers[2].text.trim();
    request.fields['staff_email'] = _formControllers[1].text.trim();
    request.fields['img'] = widget.staff.staffProfilePic;
    // --------------------------- form files ---------------------------
    request.fields['staff_role'] =
        await assignRole(_formControllers[5].text.trim());
    request.fields['staff_gender'] = _formControllers[4].text.trim();
    var imgData = context.read<ImageUploadController>().state;
    if (kIsWeb && imgData.isNotEmpty) {
      request.files.add(
        MultipartFile(
          "image",
          imgData['image'],
          imgData['size'],
          filename: imgData['name'],
        ),
      );
    } else {
      if (uri.isNotEmpty) {
        request.files.add(
          MultipartFile('image', File(uri).readAsBytes().asStream(),
              File(uri).lengthSync(),
              filename: uri.split("/").last),
        );
      }
    }
    request.fields['staff_password'] = "qwerty";
    request.fields['staff_key[key]'] = "";
    // ===================================================================
    var response = request.send();
    //
    return response;
  }
}
