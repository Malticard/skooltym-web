// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';

import '../../../../models/Guardians.dart';
import '../../../../models/StudentModel.dart';
import '/exports/exports.dart';

class UpdateGuardian extends StatefulWidget {
  final Guardian guardianModel;
  const UpdateGuardian({super.key, required this.guardianModel});

  @override
  State<UpdateGuardian> createState() => _UpdateGuardianState();
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
    "title": "Date Of Entry*",
    "hint": "e.g xx-xx-xx",
    "date": 9,
    "password": false,
    'icon': Icons.calendar_month_outlined
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
    ]
  },
];

class _UpdateGuardianState extends State<UpdateGuardian> {
  final List<TextEditingController> formControllers = [];
  AnimationController? guardianAnimationController;
  List<TextEditingController> _formControllers =
      List.generate(_formFields.length, (index) => TextEditingController());
  @override
  void initState() {
    _formControllers = [
      TextEditingController(
          text:
              "${widget.guardianModel.guardianFname} ${widget.guardianModel.guardianLname}"),
      TextEditingController(text: widget.guardianModel.guardianEmail),
      TextEditingController(
          text: widget.guardianModel.guardianContact.toString()),
      TextEditingController(text: ""),
      TextEditingController(text: widget.guardianModel.guardianGender),
      TextEditingController(text: widget.guardianModel.type),
      TextEditingController(
          text: widget.guardianModel.guardianDateOfEntry.toString()),
      TextEditingController(),
      TextEditingController(text: widget.guardianModel.relationship),
    ];
    BlocProvider.of<FetchStudentsController>(context, listen: false)
        .getStudents(context.read<SchoolController>().state['school']);

    super.initState();
  }
  Map<String,dynamic> imageData = {};
  @override
  void dispose() {
    super.dispose();
  }

  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5);

// form key
  final formKey = GlobalKey<FormState>();
  // error fields
  List<String> errorFields = List.generate(_formFields.length, (i) => '');

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchStudentsController>(context, listen: false)
        .getStudents(context.read<SchoolController>().state['school']);
    context.read<MultiStudentsController>().getMultiStudents();

    // Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Padding(
        padding: padding,
        child: BlocConsumer<ImageUploadController, Map<String, dynamic>>(
          listener: (context, state) {
            setState(() {
              imageData = state;
            });
          },
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 1.5,
              child: BlocBuilder<FetchStudentsController, List<Student>>(
                builder: (context, students) {
                  return CommonFormFields(
                    initialPic: widget.guardianModel.guardianProfilePic,
                    padding: padding,
                    formFields: _formFields,
                    lists: students.map((e) => e.id).toList(),
                    dropdownLists: students.map((item) {
                      return "${item.studentFname} ${item.studentLname}";
                    }).toList(),
                    onDropDownValue: (v) {
                      if (v != null) {
                        BlocProvider.of<MultiStudentsController>(context)
                            .setMultiStudents((json.decode(v).join(",")));
                      }
                    },
                    formControllers: _formControllers,
                    buttonText: "Update Guardian Details",
                    onSubmit: () => _addGuardian(),
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
  void _addGuardian() {
    if (validateEmail(_formControllers[1].text, context) != false) {
      showProgress(context, msg: "Updating guardian in progress");
      _handleGuardian().then((value) {
        debugPrint("Status code ${value.statusCode}");
        Routes.popPage(context);
      }).whenComplete(() {
        Routes.popPage(context);
      });
    }
  }

  Future<StreamedResponse> _handleGuardian() {
    String uri = _formControllers[3].text.trim();
    context.read<MultiStudentsController>().getMultiStudents();
    //
    var request = MultipartRequest(
      'POST',
      Uri.parse(AppUrls.updateGuardian + widget.guardianModel.id),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer ${context.read<TokenController>().state}'
    });

    request.fields['students'] =
        (context.read<MultiStudentsController>().state);
    request.fields['school'] = context.read<SchoolController>().state['school'];
    request.fields['type'] = _formControllers[5].text.trim();
    request.fields['relationship'] = _formControllers[8].text.trim();
    request.fields['guardian_fname'] =
        _formControllers[0].text.trim().split(" ").first;
    request.fields['guardian_lname'] =
        _formControllers[0].text.trim().split(" ").last;
    request.fields['guardian_contact'] = _formControllers[2].text.trim();
    request.fields['guardian_email'] = _formControllers[1].text.trim();
    request.fields['guardian_gender'] = _formControllers[4].text.trim();
    if (kIsWeb) {
      request.files.add(MultipartFile(
          "image",
          imageData['image'],
          imageData['size'],
          filename: imageData['name']));
    } else {
      if (uri.isNotEmpty) {
        request.files.add(MultipartFile(
            'image', File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
            filename: uri.split("/").last));
      }
    }

    request.fields['guardian_dateOfEntry'] = _formControllers[6].text.trim();
    request.fields['passcode'] = "";
    request.fields['fcmToken'] = "";
    request.fields['guardian_key[key]'] = "";
    var response = request.send();
    debugPrint("Status code $response");
    return response;
  }
}
