// ignore_for_file: invalid_return_type_for_catch_error, unnecessary_null_comparison

import 'dart:developer';

import '/exports/exports.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  List<Map<String, dynamic>>? formFields;
  List<TextEditingController> formControllers =
      List.generate(9, (index) => TextEditingController());
  // overall form padding
  final EdgeInsets _padding =
      const EdgeInsets.only(left: 24, top: 5, right: 24, bottom: 5);
  List<DashboardModel> _dashDataController = [];
  Timer? _timer;
// form key
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    pollData();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void pollData() {
    fetchDashBoardData(context.read<SchoolController>().state['school'])
        .then((dashData) {
      if (mounted) {
        setState(() {
          _dashDataController = dashData;
        });
      }
    });
  }

  List<String> getStreams() {
    return formControllers[5].text.isNotEmpty && mounted
        ? _dashDataController
            .where((element) =>
                element.className == formControllers[5].text.trim())
            .toList()
            .first
            .classStreams
            .map((e) => e.streamName.trim())
            .toList()
        : [];
  }

  Map<String, dynamic> studentData = {};
  @override
  Widget build(BuildContext context) {
// form data
// error fields
    List<String> errorFields = List.generate(9, (i) => '');
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
          ..._dashDataController.map((e) => e.className).toList(),
        ],
        'icon': Icons.home_work_outlined
      },
      {
        "title": "Stream *",
        "hint": "e.g North",
        "data": ["Select stream", ...getStreams()],
        'icon': Icons.home_work_outlined
      },
      {
        "title": "PickUp session *",
        "switch": "0",
        "password": false,
        "icon": Icons.timelapse
      },
      {
        "title": "Van Student *",
        "van": "0",
        "password": false,
        "icon": Icons.car_repair_outlined,
      }
    ];
    return BlocConsumer<ImageUploadController, Map<String, dynamic>>(
      listener: (context, state) {
        setState(() {
          studentData = state;
        });
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: CommonFormFields(
            formTitle: "Add Student",
            padding: _padding,
            formFields: formFields ?? [],
            formControllers: formControllers,
            buttonText: "Save Student Details",
            onSubmit: () {
              if (true) {
                showProgress(context, msg: "Adding new student...");
                _handleStudentRegistration().then(
                  (value) {
                    log("Response => ${value}");
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
            lists: [],
          ),
        );
      },
    );
  }

  Future<StreamedResponse> _handleStudentRegistration() async {
    String uri = formControllers[3].text;

    var request = MultipartRequest('POST', Uri.parse(AppUrls.addStudent));
    // log("${request.headers}");
    //  ============================== student details ============================
    request.fields['guardians'] =
        ""; //json.encode(context.watch()<MainController>().multiselect);
    request.fields['school'] =
        "${context.read<SchoolController>().state['school']}";
    request.fields['name'] =
        "${context.read<SchoolController>().state['schoolName']}"
            .toLowerCase()
            .replaceFirst(" ", "-");
    request.fields['student_fname'] =
        formControllers[0].text.trim().split(" ").first.trim();
    request.fields['student_lname'] =
        formControllers[1].text.trim().split(" ").last.trim();
    request.fields['username'] =
        "${formControllers[0].text.trim().split(" ").first.trim()}_256"; //_formControllers[2].text.trim();
    request.fields['other_name'] = formControllers[2].text.trim();
    request.fields['_class'] = formControllers[5].text.trim();
    request.fields['stream'] = formControllers[6].text.trim();
    request.fields['student_gender'] = formControllers[4].text.trim();
    request.fields['isHalfDay'] = (formControllers[7].text.trim());
    request.fields['isVanStudent'] = (formControllers[8].text.trim());
    //  ============================== student profile pic ============================
    // request.fields['student_profile_pic'] = _formControllers[5].file.path;
    if (kIsWeb && studentData.isNotEmpty) {
      request.files.add(
        MultipartFile(
          "image",
          studentData['image'],
          studentData['size'],
          filename: studentData['name'].toString().trim(),
        ),
      );
    } else {
      if (uri.isNotEmpty) {
        request.files.add(MultipartFile(
            'image', File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
            filename: renameFile(uri.split("/").last)));
      }
    }

    //  ============================== student key ============================
    request.fields['student_key[key]'] = "0";
    //  ============================== student key ============================
    var response = request.send();
    var res = await response;
    log("Status code ${res.reasonPhrase}");
    return response;
  }
}
