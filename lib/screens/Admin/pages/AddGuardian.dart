import 'dart:developer';

import '../../../models/StudentModel.dart';
import '/exports/exports.dart';

class AddGuardian extends StatefulWidget {
  const AddGuardian({super.key});

  @override
  State<AddGuardian> createState() => _AddGuardianState();
}

final List<Map<String, dynamic>> _formFields = [
  {
    "title": "Guardian Name*",
    "hint": "e.g John Doe",
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
  {'title': 'Guardian Profile', 'profile': 5},
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
    "title": "Type*",
    'icon': Icons.reduce_capacity_outlined,
    "hint": "eg Relationship type e.g Primary",
    "data": ["Select relationship type", "Primary", "Secondary"]
  },
  {
    "title": "Students *",
    "hint": "Select students",
    "menu": 0,
  },
  {
    "title": "Relationship*",
    "hint": "Select relationship",
    "data": [
      "Select relationship",
      "Father",
      "Mother",
      "Sister",
      "Brother",
      "Guardian",
    ]
  },
];

class _AddGuardianState extends State<AddGuardian> {
  final List<TextEditingController> _formControllers =
      List.generate(_formFields.length, (index) => TextEditingController());

  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5);

// form key
  final formKey = GlobalKey<FormState>();
  Timer? _timer;
  StreamController<StudentModel> _guardianStudentsController =
      StreamController<StudentModel>();
  @override
  void initState() {
    super.initState();
    realTimeStudentsData();

    BlocProvider.of<SchoolController>(context).getSchoolData();
  }

  void realTimeStudentsData() async {
    var school = context.read<SchoolController>().state['school'];

    if (mounted) {
      var students = await fetchStudents(school);
      _guardianStudentsController.add(students);
    }

    Timer.periodic(Duration(seconds: 1), (timer) async {
      this._timer = timer;
      if (mounted) {
        var students = await fetchStudents(school);
        _guardianStudentsController.add(students);
      }
    });
  }

  // error fields
  List<String> errorFields = List.generate(_formFields.length, (i) => '');
  @override
  void dispose() {
    _timer?.cancel();
    if (_guardianStudentsController.hasListener) {
      _guardianStudentsController.close();
    }
    super.dispose();
  }

  Map<String, dynamic> schoolData = {};
  @override
  Widget build(BuildContext context) {
    context.read<MultiStudentsController>().getMultiStudents();
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
        width: Responsive.isDesktop(context) ? size.width / 3 : size.width,
        height: Responsive.isMobile(context)
            ? size.height * 1.25
            : size.width / 1.5,
        child: BlocConsumer<ImageUploadController, Map<String, dynamic>>(
          listener: (context, state) {
            setState(() {
              schoolData = state;
            });
          },
          builder: (context, state) {
            return Padding(
              padding: padding,
              child: StreamBuilder(
                stream: _guardianStudentsController.stream,
                builder: (context, students) {
                  return CommonFormFields(
                    formTitle: "Add Guardian",
                    menuTitle: "Attach Students",
                    padding: padding,
                    formFields: _formFields,
                    lists: students.data?.results.map((e) => e.id).toList(),
                    dropdownLists: students.data?.results.map((item) {
                      return "${item.studentFname} ${item.studentLname}";
                    }).toList(),
                    onDropDownValue: (v) {
                      if (v != null) {
                        BlocProvider.of<MultiStudentsController>(context)
                            .setMultiStudents((json.decode(v).join(",")));
                      }
                    },
                    formControllers: _formControllers,
                    buttonText: "Save Guardian Details",
                    onSubmit: () => addGuardian(),
                    errorMsgs: errorFields,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

// adding guardian
  void addGuardian() {
    if (validateEmail(_formControllers[1].text, context) != false) {
      showProgress(context, msg: "Adding guardian...");
      handleGuardian().then((event) {
        Routes.popPage(context);
        log(event.reasonPhrase ?? "");
        log(event.statusCode.toString());
        if (event.statusCode == 200 || event.statusCode == 201) {
          _formControllers.forEach((element) {
            element.clear();
          });
          showMessage(
            context: context,
            type: 'success',
            msg: "Added new guardian successfully",
          );
        } else {
          showMessage(
              context: context, type: 'danger', msg: event.reasonPhrase ?? "");
        }
      }).whenComplete(() => Routes.popPage(context));
    }
  }

  Future<StreamedResponse> handleGuardian() async {
    String uri = _formControllers[3].text.trim();
    var request = MultipartRequest(
      'POST',
      Uri.parse(AppUrls.addGuardian),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    });
    request.fields['students'] =
        (context.read<MultiStudentsController>().state);

    request.fields['school'] = context.read<SchoolController>().state['school'];

    request.fields['type'] = _formControllers[5].text.trim();
    request.fields['relationship'] = _formControllers[7].text.trim();
    request.fields['guardian_fname'] =
        _formControllers[0].text.trim().split(" ").first.trim();
    request.fields['guardian_lname'] =
        _formControllers[0].text.trim().split(" ").last.trim();
    request.fields['guardian_contact'] = _formControllers[2].text.trim();
    request.fields['guardian_email'] = _formControllers[1].text.trim();
    request.fields['guardian_gender'] = _formControllers[4].text.trim();
    if (kIsWeb && schoolData.isNotEmpty) {
      request.files.add(
        MultipartFile(
          "image",
          schoolData['image'],
          schoolData['size'],
          filename: schoolData['name'].toString().trim(),
        ),
      );
    } else {
      if (uri.isNotEmpty) {
        request.files.add(
          MultipartFile(
            'image',
            File(uri).readAsBytes().asStream(),
            File(uri).lengthSync(),
            filename: uri.split("/").last.trim(),
          ),
        );
      }
    }
    request.fields['guardian_key[key]'] = "";
    var response = request.send();
    return response;
  }
}
