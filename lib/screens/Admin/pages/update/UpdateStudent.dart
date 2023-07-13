// ignore_for_file: invalid_return_type_for_catch_error, unnecessary_null_comparison

import 'dart:io';

import '/exports/exports.dart';

class UpdateStudent extends StatefulWidget {
  final StudentModel studentModel;
  const UpdateStudent({super.key, required this.studentModel});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  List<TextEditingController> _formControllers = <TextEditingController>[];
  //  = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    _formControllers = <TextEditingController>[
      TextEditingController(text: widget.studentModel.studentFname),
      TextEditingController(text: widget.studentModel.studentLname),
      TextEditingController(text: widget.studentModel.otherName),
      TextEditingController(text: ""),
      TextEditingController(text: ""),
      TextEditingController(text: widget.studentModel.studentGender),
      TextEditingController(
          text: widget.studentModel.studentModelClass.className),
    ];
  }

  // overall form padding
  final EdgeInsets _padding =
      const EdgeInsets.only(left: 24, top: 5, right: 24, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  // error fields
  @override
  Widget build(BuildContext context) {
    List<String> errorFields = List.generate(7, (i) => '');
      Provider.of<ClassController>(context,listen: true).getClasses(context.read<SchoolController>().state['school']);
  Provider.of<StreamsController>(context);
// form data
    List<Map<String, dynamic>> formFields = [
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
          ...Provider.of<ClassController>(context).classes
              .map((e) => e.className)
              .toList(),
        ],
        'icon': Icons.home_work_outlined
      },
      {
        "title": "Stream *",
        "hint": "e.g North",
        "data": [
          "Select stream",
          ...Provider.of<StreamsController>(context).streams
              .map((e) => e.streamName)
              .toList(),
        ],
        'icon': Icons.home_work_outlined
      }
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Update Student Details",
            style: TextStyles(context).getRegularStyle().copyWith(fontSize: 19),
          ),
        ),
        CommonFormFields(
          initialPic: widget.studentModel.studentProfilePic,
          padding: _padding,
          formFields: formFields,
          formControllers: _formControllers,
          buttonText: "Update Student Details",
          onSubmit: () {
            if (true) {
              showProgress(context, msg: "Updating student details");
              _handleStudentRegistration().then(
                (value) {
                  if (value.statusCode == 200 || value.statusCode == 201) {
                    Routes.popPage(context);
                    showMessage(
                      context: context,
                      type: 'success',
                      msg: "Student details updated successfully",
                    );
                    for (var v in _formControllers) {
                      v.clear();
                    }
                    // showSuccessDialog(
                    //     _formControllers[0].text.trim(), context);
                  } else {
                    showMessage(
                      msg: "Failed to update student ${value.reasonPhrase}",
                      context: context,
                      type: "danger",
                    );
                  }
                },
              ).whenComplete(() {
                Routes.popPage(context);
              });
            }
          },
          errorMsgs: errorFields,
        ),
      ],
    );
  }

  Future<StreamedResponse> _handleStudentRegistration() async {
    String uri = _formControllers[3].text;

    var request = MultipartRequest(
        'POST', Uri.parse(AppUrls.updateStudent + widget.studentModel.id));
    debugPrint("${request.headers}");
    //  ============================== student details ============================
    request.fields['school'] =
        "${context.read<SchoolController>().state['school']}";
    request.fields['student_fname'] =
        _formControllers[0].text.trim().split(" ").first;
    request.fields['student_lname'] =
        _formControllers[1].text.trim().split(" ").last;
    request.fields['username'] =
        "${_formControllers[0].text.trim().split(" ").first}_256"; //_formControllers[2].text.trim();
    request.fields['other_name'] = _formControllers[2].text.trim();
    request.fields['student_class'] = _formControllers[5].text.trim();
    request.fields['student_gender'] = _formControllers[4].text.trim();
    //  ============================== student profile pic ============================
    // request.fields['student_profile_pic'] = _formControllers[5].file.path;
    if (kIsWeb) {
      request.files.add(MultipartFile(
          "image",
          context.read<ImageUploadController>().state['image'],
          context.read<ImageUploadController>().state['size'],
          filename: context.read<ImageUploadController>().state['name']));
    } else {
      if (uri.isNotEmpty) {
        request.files.add(MultipartFile(
            'image', File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
            filename: uri.split("/").last));
      }
    }

    // request.files.add(MultipartFile('image',
    //     File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
    //     filename: uri.split("/").last));
    //  ============================== student key ============================
    request.fields['student_key[key]'] = "";
    //  ============================== student key ============================
    var response = request.send();
    var res = await response;
    debugPrint("Status code ${res.reasonPhrase}");
    return response;
  }
}
