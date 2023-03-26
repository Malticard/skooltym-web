// ignore_for_file: invalid_return_type_for_catch_error, unnecessary_null_comparison

import 'dart:io';

import '/exports/exports.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

// form data
final List<Map<String, dynamic>> _formFields = [
  {
    "title": "Student's Firstname *",
    "hint": "e.g John",
    "password": false,
    'icon': Icons.person_outlined
  },
  {
    "title": "Student's Lastname *",
    "hint": "e.g Doe",
    "password": false,
    'icon': Icons.person_2_outlined
  },
  {
    "title": "Student's Othername*",
    "hint": "e.g Paul",
    "password": false,
    'icon': Icons.person_3_outlined
  },
  {'title': 'Student Profile', 'profile': 5},
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
    "title": "Class*",
    "hint": "e.g grade 2",
    "password": false,
    'icon': Icons.home_work_outlined
  },
];

class _AddStudentState extends State<AddStudent> {
  final List<TextEditingController> _formControllers =
      List.generate(_formFields.length, (index) => TextEditingController());

  // overall form padding
  final EdgeInsets _padding =
      const EdgeInsets.only(left: 24, top: 5, right: 24, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  // error fields
  List<String> errorFields = List.generate(_formFields.length, (i) => '');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text("Add Student", style: TextStyles(context).getTitleStyle()),
          SingleChildScrollView(
            child: CommonFormFields(
              padding: _padding,
              formFields: _formFields,
              formControllers: _formControllers,
              buttonText: "Save Student Details",
              onSubmit: () {
                if (true) {
                  showProgress(context);
                  _handleStudentRegistration()
                      .then(
                        (value) {
                          if (value.statusCode == 200) {
                            Routes.popPage(context);
                            showMessage(
                              context: context,
                              type: 'success',
                              msg: "Added new student successfully",
                            );
                            _formControllers.forEach((v) => v.clear());
                            showSuccessDialog(
                                _formControllers[0].text.trim().split(" ")[1],
                                context);
                          } else {
                            showMessage(
                              msg:
                                  "Failed to add student ${value.reasonPhrase}",
                              context: context,
                              type: "danger",
                            );
                          }
                        },
                      )
                      .catchError(
                        (onError) => () => showMessage(
                            context: context,
                            msg: 'An error occurred!! ',
                            type: 'danger'),
                      )
                      .whenComplete(() {
                        Routes.popPage(context);
                      });
                }
              },
              errorMsgs: errorFields,
              students: [],
            ),
          ),
        ],
      ),
    );
  }

  Future<StreamedResponse> _handleStudentRegistration() async {
    String uri = _formControllers[3].text;
    /**
     *    school: req.body.school,
                    student_fname: req.body.student_fname,
                    student_lname: req.body.student_lname,
                    student_contact: req.body.student_contact,
                    student_email: req.body.student_email,
                    student_class: req.body.student_class,
                    student_gender: req.body.student_gender,
                    student_profile_pic: req.file.path,
                    student_key: req.body.student_key
     */
    var request = MultipartRequest('POST', Uri.parse(AppUrls.addStudent));
    debugPrint("${request.headers}");
    //  ============================== student details ============================
    request.fields['school'] =
        "${context.read<SchoolController>().state['school']}";
    request.fields['student_fname'] =
        _formControllers[0].text.trim().split(" ").first;
    request.fields['student_lname'] =
        _formControllers[0].text.trim().split(" ").last;
    request.fields['student_contact'] = _formControllers[2].text.trim();
    request.fields['student_email'] = _formControllers[1].text.trim();
    request.fields['student_class'] = _formControllers[5].text.trim();
    request.fields['student_gender'] = _formControllers[4].text.trim();
    //  ============================== student profile pic ============================
    // request.fields['student_profile_pic'] = _formControllers[5].file.path;
    request.files.add(MultipartFile('student_profile_pic',
        File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
        filename: uri.split("/").last));
    //  ============================== student key ============================
    request.fields['student_key[key]'] = "";
    //  ============================== student key ============================
    var response = request.send();
    var res = await response;
    debugPrint("Status code ${res.reasonPhrase}");
    return response;
  }
}
