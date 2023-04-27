// ignore_for_file: use_build_context_synchronously
import '/exports/exports.dart';
// export 'package:flutter/cupertino.dart';

class UpdateStaff extends StatefulWidget {
  final StaffModel staff;
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
      TextEditingController(text: widget.staff.staffContact),
      TextEditingController(text: AppUrls.liveImages + widget.staff.staffProfilePic),
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

  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  // error fields
  List<String> errorFields = List.generate(formFields.length, (i) => '');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: padding,
      child: CommonFormFields(
        initialPic: widget.staff.staffProfilePic,
        padding: padding,
        formFields: formFields,
        numberOfDropDowns: 2,
        formControllers: _formControllers,
        buttonText: "Submit Staff Details",
        errorMsgs: errorFields,
        onSubmit: () {
          if (validateEmail(_formControllers[1].text, context) != false) {
            if (_formControllers[0].text.trim().split(" ")[1] == '') {
              showMessage(context: context, msg: "Staff last name is required");
            } else {
              _handleFormUpload(widget.staff.id).then((value) {
                debugPrint("response code -> ${value.statusCode}");
                debugPrint("Staff data -> ${value.reasonPhrase}");
                if (value.statusCode == 200 || value.statusCode == 201) {
                  //  bottom msg
                  showMessage(
                    context: context,
                    type: 'success',
                    msg: "Updated staff successfully",
                  );
                  Routes.popPage(context);
                  //  end of bottom msg
                } else {
                  showMessage(
                    context: context,
                    type: 'danger',
                    msg: "Error ${value.reasonPhrase}",
                  );
                  // showSuccessDialog(
                  //     _formControllers[0].text.trim().split(" ")[1],
                  //     context);
                }
              });
            }
          }
        },
      ),
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
    //  if (kIsWeb) {
    //  request.files.add(MultipartFile(
    //     "image", context.read<ImageUploadController>().state['image'], context.read<ImageUploadController>().state['size'],
    //     filename: context.read<ImageUploadController>().state['name']));
    // } else {
      request.files.add(MultipartFile('image',
        File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
        filename: uri.split("/").last));
    // }
    // request.files.add(MultipartFile(
    //     'image',
    //     File(_formControllers[3].text.trim()).readAsBytes().asStream(),
    //     File(_formControllers[3].text.trim()).lengthSync(),
    //     filename: uri.split("/").last));
    //
    request.fields['staff_password'] = "qwerty";
    request.fields['staff_key[key]'] = "";
    // ===================================================================
    var response = request.send();
    //
    return response;
  }
}
