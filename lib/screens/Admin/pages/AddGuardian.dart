// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';

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
    "title": "Date Of Entry*",
    "hint": "e.g xx-xx-xx",
    "date": 9,
    "password": false,
    'icon': Icons.calendar_month_outlined
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

class _AddGuardianState extends State<AddGuardian>
    with TickerProviderStateMixin {
  AnimationController? guardianAnimationController;
  final List<TextEditingController> _formControllers =
      List.generate(_formFields.length, (index) => TextEditingController());
  @override
  void initState() {
    guardianAnimationController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 800),
    );
    guardianAnimationController!.forward();
    // fetchStudents().then((value) => setState(() => students = value));
    super.initState();
  }

  @override
  void dispose() {
    guardianAnimationController!.dispose();
    // for (var element in formControllers) {
    //   element.dispose();
    // }
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

    Size size = MediaQuery.of(context).size;
    return BottomTopMoveAnimationView(
      animationController: guardianAnimationController!,
      child: Padding(
        padding: padding,
        child: CommonFormFields(
          padding: padding,
          formFields: _formFields,
          students: context.watch<MainController>().students,
          formControllers: _formControllers,
          buttonText: "Save Guardian Details",
          onSubmit: () => addGuardian,
          errorMsgs: errorFields,
        ),
      ),
    );
  }

// adding guardian
  void addGuardian() {
    if (validateEmail(_formControllers[1].text, context) != false) {
     debugPrint("verified");
      // _handleGuardian()
      //     .then((value) {
      //        showProgress(context, msg: "Adding new guardian in progress");
           
      //       Routes.popPage(context);
      //       showSuccessDialog(
      //           _formControllers[0].text.trim().split(" ")[1], context);
      //     })
      //     .catchError(
      //       (onError) => () {
      //         showMessage(
      //             context: context,
      //             msg: 'An error occurred!! ',
      //             type: 'danger');
      //       },
      //     )
      //     .whenComplete(() {
      //       showMessage(
      //         context: context,
      //         type: 'success',
      //         msg: "Added new guardian successfully",
      //       );
      //     });
    }
  }

  Future<StreamedResponse> _handleGuardian() {
    String uri = _formControllers[3].text.trim();
    //
    var request = MultipartRequest(
      'POST',
      Uri.parse(AppUrls.addGuardian),
    );

    request.fields['type'] = _formControllers[6].text.trim();
    request.fields['relationship'] = _formControllers[8].text.trim();
    request.fields['guardian_fname'] =
        _formControllers[0].text.trim().split(" ").first;
    request.fields['guardian_lname'] =
        _formControllers[0].text.trim().split(" ").last;
    request.fields['guardian_contact'] = _formControllers[2].text.trim();
    request.fields['guardian_email'] = _formControllers[1].text.trim();
    request.fields['guardian_gender'] = _formControllers[4].text.trim();

    request.files.add(MultipartFile('image',
        File(uri).readAsBytes().asStream(), File(uri).lengthSync(),
        filename: uri.split("/").last));
    request.fields['guardian_dateOfEntry'] = _formControllers[7].text.trim();
    request.fields['guardian_key[key]'] = "";
    var response = request.send();
     debugPrint("Status code ${response}");
    return response;
  }
}
