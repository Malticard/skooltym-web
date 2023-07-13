// ignore_for_file: invalid_return_type_for_catch_error, unnecessary_null_comparison

import 'dart:io';

import '/exports/exports.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  List<Map<String, dynamic>>? formFields;
  List<TextEditingController> formControllers =
      List.generate(7, (index) => TextEditingController());
  // overall form padding
  final EdgeInsets _padding =
      const EdgeInsets.only(left: 24, top: 5, right: 24, bottom: 5);
// form key
  final formKey = GlobalKey<FormState>();
  @override
  void initState() { 
    Provider.of<ClassController>(context,listen: false).getClasses(context.read<SchoolController>().state['school']);
    super.initState();
    initStreams();
  }
  void initStreams(){
       var  stream = Provider.of<StreamsController>(context);
       stream.getStreams(context.read<SchoolController>().state['school']);
}

  @override
  Widget build(BuildContext context) {
    Provider.of<ClassController>(context,listen: true).getClasses(context.read<SchoolController>().state['school']);

    // BlocProvider.of<StreamsController>(context).getStreams(context);
// form data
// error fields
    List<String> errorFields = List.generate(7, (i) => '');
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
          ...Provider.of<ClassController>(context)
              .classes
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
          ...Provider.of<StreamsController>(context,listen: false)
              .streams
              .map((e) => e.streamName)
              .toList(),
        ],
        'icon': Icons.home_work_outlined
      }
    ];

    return Column(
      children: [
        Text("Add Student", style: TextStyles(context).getTitleStyle()),
        SingleChildScrollView(
          child: BlocBuilder<GuardianController, List<Guardians>>(
            builder: (context, guardians) {
              return CommonFormFields(
                padding: _padding,
                formFields: formFields ?? [],
                formControllers: formControllers,
                buttonText: "Save Student Details",
                onSubmit: () {
                  if (true) {
                    showProgress(context, msg: "Adding new student...");
                    _handleStudentRegistration().then(
                      (value) {
                        if (value.statusCode == 200) {
                          Routes.popPage(context);
                          showMessage(
                            context: context,
                            type: 'success',
                            msg: "Added new student successfully",
                          );
                          for (var v in formControllers) {
                            v.clear();
                          }
                        } else {
                          showMessage(
                            msg: "Failed to add student ${value.reasonPhrase}",
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
                lists: guardians,
                onDropDownValue: (p0) {
                  // if (p0 != null) {
                  //   Provider.of<MainController>(context).guardians;
                  // }
                },
               
              );
            },
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
    request.fields['guardians'] =
        ""; //json.encode(context.watch()<MainController>().multiselect);
    request.fields['school'] =
        "${context.read<SchoolController>().state['school']}";
    request.fields['student_fname'] =
        formControllers[0].text.trim().split(" ").first;
    request.fields['student_lname'] =
        formControllers[1].text.trim().split(" ").last;
    request.fields['username'] =
        "${formControllers[0].text.trim().split(" ").first}_256"; //_formControllers[2].text.trim();
    request.fields['other_name'] = formControllers[2].text.trim();
    request.fields['_class'] = formControllers[5].text.trim();
    request.fields['stream'] = formControllers[6].text.trim();
    request.fields['student_gender'] = formControllers[4].text.trim();
    //  ============================== student profile pic ============================
    // request.fields['student_profile_pic'] = _formControllers[5].file.path;
    if (kIsWeb) {
      request.files.add(MultipartFile(
          "image",
          context.read<ImageUploadController>().state['image'],
          context.read<ImageUploadController>().state['size'],
          filename: context.read<ImageUploadController>().state['name']));
    } else {
      request.files.add(MultipartFile(
          'image', File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
          filename: uri.split("/").last));
    }

    //  ============================== student key ============================
    request.fields['student_key[key]'] = "0";
    //  ============================== student key ============================
    var response = request.send();
    var res = await response;
    debugPrint("Status code ${res.reasonPhrase}");
    return response;
  }
}
