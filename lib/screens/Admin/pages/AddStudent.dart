// ignore_for_file: invalid_return_type_for_catch_error, unnecessary_null_comparison

import 'dart:io';

import '/exports/exports.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}


class _AddStudentState extends State<AddStudent> {
 List<Map<String, dynamic>> formFields = [];
 List<TextEditingController> formControllers = [];
 @override
 void initState() {
    context.read<MainController>().fetchClasses(context.read<SchoolController>().state['school']);

   // form data
 formFields = [
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
    "title": "Student's Othername *",
    "hint": "e.g Paul",
    "password": false,
    'icon': Icons.person_3_outlined
  },
  {'title': 'Student Profile', 'profile': 5},
  {
    "title": "Gender *",
    "hint": "Select gender",
    "data": [
      "Select gender",
      "Male",
      "Female",
    ]
  },
  {
    "title": "Class *",
    "hint": "e.g grade 2",
    "data": [
      "Select class",
      ...context.read<MainController>().classes.map((e) => e).toList(),
    ],
    'icon': Icons.home_work_outlined
  }

];

  formControllers =
      List.generate(formFields.length, (index) => TextEditingController());
   super.initState();

 }

  // overall form padding
  final EdgeInsets _padding =
      const EdgeInsets.only(left: 24, top: 5, right: 24, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    context.read<MainController>().fetchClasses(context.read<SchoolController>().state['school']);
// error fields
  List<String> errorFields = List.generate(formFields.length, (i) => '');

    return Column(
      children: [
        Text("Add Student", style: TextStyles(context).getTitleStyle()),
        SingleChildScrollView(
          child: CommonFormFields(
            padding: _padding,
            formFields: formFields,
            formControllers: formControllers,
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
                          formControllers.forEach((v) => v.clear());
                          showSuccessDialog(
                              formControllers[0].text.trim(),
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
                    .whenComplete(() {
                      Routes.popPage(context);
                    });
              }
            },
            errorMsgs: errorFields,
             lists:context.watch<MainController>().guardians,
              onDropDownValue: (p0) {
                if (p0 != null) {
                 Provider.of<MainController>(context).guardians;
                }
              },
              dropdownLists: context.watch<MainController>().students.map((item) {
                    return "${item.studentFname} ${item.studentLname}";
                  }).toList(),
                
          ),
        ),
      ],
    );
  }

  Future<StreamedResponse> _handleStudentRegistration() async {
    String uri = formControllers[3].text;
 
    var request = MultipartRequest('POST', Uri.parse(AppUrls.addStudent));
    debugPrint("${request.headers}");
    //  ============================== student details ============================
     request.fields['guardians'] = "";//json.encode(context.watch()<MainController>().multiselect);
    request.fields['school'] =
        "${context.read<SchoolController>().state['school']}";
    request.fields['student_fname'] =
        formControllers[0].text.trim().split(" ").first;
    request.fields['student_lname'] =
        formControllers[1].text.trim().split(" ").last;
    request.fields['username'] = "${formControllers[0].text.trim().split(" ").first}_256";//_formControllers[2].text.trim();
    request.fields['other_name'] = formControllers[2].text.trim();
    request.fields['_class'] = formControllers[5].text.trim();
    request.fields['stream'] = "";
    request.fields['student_gender'] = formControllers[4].text.trim();
    //  ============================== student profile pic ============================
    // request.fields['student_profile_pic'] = _formControllers[5].file.path;
    request.files.add(MultipartFile('image',
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
