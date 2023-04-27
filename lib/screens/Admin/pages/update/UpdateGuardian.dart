// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';

import '/exports/exports.dart';

class UpdateGuardian extends StatefulWidget {
  final Guardians guardianModel;
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
      TextEditingController(text: "${widget.guardianModel.guardianFname} ${widget.guardianModel.guardianLname}"),
      TextEditingController(text: widget.guardianModel.guardianEmail),
      TextEditingController(text: widget.guardianModel.guardianContact.toString()),
      TextEditingController(text: AppUrls.liveImages + widget.guardianModel.guardianProfilePic),
      TextEditingController(text: widget.guardianModel.guardianGender),
      TextEditingController(text: widget.guardianModel.type),
      TextEditingController(text: widget.guardianModel.guardianDateOfEntry.toString()),
      TextEditingController(),
      TextEditingController(text: widget.guardianModel.relationship),

    ];
    // fetchStudents().then((value) => setState(() => students = value));
    super.initState();
  }

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
    context.watch<MainController>().getAllStudents(context);
    context.read<MultiStudentsController>().getMultiStudents();

    // Size size = MediaQuery.of(context).size;
        return Dialog(
      child: SizedBox(
         width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 1.5,
        child: Padding(
          padding: padding,
          child: CommonFormFields(
            initialPic: widget.guardianModel.guardianProfilePic,
            padding: padding,
            formFields: _formFields,
            lists: context.watch<MainController>().students.map((e) => e.id).toList(),
            dropdownLists: context.watch<MainController>().students.map((item) {
                    return "${item.studentFname} ${item.studentLname}";
                  }).toList(),
                onDropDownValue: (v) {
                 if (v != null) {
                      BlocProvider.of<MultiStudentsController>(context).setMultiStudents((json.decode(v).join(",")));
                 }
                },
            formControllers: _formControllers,
            buttonText: "Update Guardian Details",
            onSubmit:() =>  _addGuardian(),
            errorMsgs: errorFields,
          ),
        ),
      ),
    );
  }

// adding guardian
  void _addGuardian() {
    if (validateEmail(_formControllers[1].text, context) != false) {
      showProgress(context, msg: "Updating guardian in progress");
      _handleGuardian()
          .then((value) {
            debugPrint("Status code ${value.statusCode}");
            Routes.popPage(context);
            showSuccessDialog(
                _formControllers[0].text.trim().split(" ")[1], context,onPressed: () => Routes.popPage(context));
          })
          .whenComplete(() {
            showMessage(
              context: context,
              type: 'success',
              msg: "Added new guardian successfully",
            );
          });
    }
  }

  Future<StreamedResponse> _handleGuardian() {
    String uri = _formControllers[3].text.trim();
    context.read<MultiStudentsController>().getMultiStudents();
    //
    var request = MultipartRequest(
      'POST',
      Uri.parse(AppUrls.updateGuardian),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer ${context.read<TokenController>().state}'
    });
  
    request.fields['students'] = (context.read<MultiStudentsController>().state);
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
      //  if (kIsWeb) {
      // request.files.add(MultipartFile(
      //   "image", context.read<ImageUploadController>().state['image'], context.read<ImageUploadController>().state['size'],
      //   filename: context.read<ImageUploadController>().state['name']));
    // } else {
      request.files.add(MultipartFile('image',
        File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
        filename: uri.split("/").last));
    // }
    // request.files.add(MultipartFile('image',
    //     File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
    //     filename: uri.split("/").last));
    request.fields['guardian_dateOfEntry'] = _formControllers[6].text.trim();
    request.fields['passcode'] = "";
    request.fields['fcmToken'] = "";
    request.fields['guardian_key[key]'] = "";
    var response = request.send();
     debugPrint("Status code $response");
    return response;
  }
}
