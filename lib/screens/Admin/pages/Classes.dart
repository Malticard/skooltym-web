// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class ViewClasses extends StatefulWidget {
  const ViewClasses({super.key});

  @override
  State<ViewClasses> createState() => _ViewClassesState();
}

class _ViewClassesState extends State<ViewClasses> {
  @override
  void initState() {
    super.initState();
  }
  // late List<TextEditingController> _ctrl;

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).staffUpdate();

    super.didChangeDependencies();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];
  DataRow _dataRow(StaffModel staffModel, int i) {
    return DataRow(
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(staffModel.staffFname),
          ),
        ),
        DataCell(Text(staffModel.staffEmail)),
        DataCell(Text(staffModel.staffGender)),
        DataCell(buildActionButtons(
            "${staffModel.staffFname} ${staffModel.staffLname}", context)),
      ],
    );
  }

  List<String>? _stepText;

  int currentStep = 0;
  int _streams = 0;
  EdgeInsets _padding = const EdgeInsets.only(right: 0, left: 0);
  //text controllers

  TextEditingController _classController = TextEditingController();
  TextEditingController _streamNoController = TextEditingController();
  //error text
  TextEditingController _errorController1 = TextEditingController();
  TextEditingController _errorController2 = TextEditingController();
  //stream eror
  StepState assignState({required int index}) {
    if (currentStep == index) {
      return StepState.editing;
    } else if (currentStep > index) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  int _index = 0;

  //form keys
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  //
  List<TextEditingController> _ctrl =
  List.generate(50, (n) =>
  TextEditingController());
  @override
  Widget build(BuildContext context) {

    // List<String> _list = List.generate(
    //     context.read<StepperController>().state.fields!, (n) => "");
    //error streams
    List<TextEditingController> _streamErrorControllers = List.generate(
        context.read<StepperController>().state.fields!,
        (index) => TextEditingController());
    Provider.of<MainController>(context).staffUpdate();
    return Stepper(
      onStepTapped: (step) {
        setState(() {
          currentStep = step;
        });
      },
      onStepCancel: () {
        setState(() {
          _index = 0;
          currentStep > 0 ? currentStep -= 1 : currentStep = 0;
        });
      },
      onStepContinue: () {
        setState(() {
          currentStep < 2 ? currentStep += 1 : currentStep = 0;
        });
      },
      currentStep: currentStep,
      steps: [
        Step(
          state: assignState(index: 0),
          title: const Text("Add a class"),
          content: Container(
            margin:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              // width:MediaQuery.of(context).size.width / 3,
              child: Form(
                key: _formKey1,
                child: Column(
                  children: [
                    const SizedBox(height: defaultPadding),
                    CommonTextField(
                      controller: _classController,
                      errorText: _errorController1.text,
                      hintText: "e.g grade 1",
                      validate: (valid) {
                        setState(() {
                          _errorController1.text =
                              "The class field is required";
                        });
                        return null;
                      },
                      titleText: "Class Nam"
                          "e",
                      padding: _padding,
                      icon: Icons.school,
                    ),
                    const SizedBox(height: defaultPadding),
                    CommonButton(
                        buttonText: "Save Class",
                        padding: _padding,
                        onTap: () {
                          if (_formKey1.currentState!.validate() &&
                              _classController.text.isNotEmpty) {
                            setState(() {
                              currentStep < 3
                                  ? currentStep += 1
                                  : currentStep = 0;
                            });
                          }
                        }),
                    const SizedBox(height: defaultPadding),
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: assignState(index: 1),
          title: const Text("Number of streams"),
          content: Container(
            margin:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    const SizedBox(height: defaultPadding),
                    CommonTextField(
                      controller: _streamNoController,
                      hintText: "e.g 3",
                      errorText: _errorController2.text,
                      validate: (valid) {
                        setState(() {
                          _errorController2.text =
                              "The number of streams are required to continue ";
                        });
                        return null;
                      },
                      titleText: "How many streams do you want to add?",
                      padding: _padding,
                      icon: Icons.numbers_rounded,
                    ),
                    const SizedBox(height: defaultPadding),
                    CommonButton(
                      buttonText: "Save changes",
                      padding: _padding,
                      onTap: () {
                        if (_formKey2.currentState!.validate()) {
                          setState(() {
                            currentStep < 3
                                ? currentStep += 1
                                : currentStep = 0;
                          });
                          //
                          BlocProvider.of<StepperController>(context)
                              .updateCount(
                            StepperModel(
                                fields: int.parse(_streamNoController.text),
                                text: []),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: defaultPadding),
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: _index == 3 ? assignState(index: 1) : assignState(index: 2),
          title: const Text("Attach streams to class"),
          content: Container(
            margin:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: BlocBuilder<StepperController, StepperModel>(
                builder: (context, inx) {

              return Form(
                key: _formKey3,
                child: Column(
                  children: [
                    ...List.generate(
                        inx.fields ?? 0,
                      //  context.read<StepperController>().state.fields!,
                        (index) => CommonTextField(
                          hintText: "e.g ${index + 1}",
                          errorText: _streamErrorControllers[index].text,
                          controller: _ctrl[index],
                          icon: Icons.home_work_outlined,
                          validate: (valid) {
                            setState(() {
                              _streamErrorControllers[index].text = "Stream "
                                  "field ${index + 1} is"
                                  " required to continue ";
                            });
                            return null;
                          },
                          // controller: _controllers[index],
                          titleText: "Stream ${index + 1}",
                        ),
                      ),

                    const SizedBox(height: defaultPadding),
                    CommonButton(
                        buttonText: "Save changes",
                        padding: _padding,
                        onTap: () {

                            _stepText = List.generate(context
                                .read<StepperController>().state.fields!,
                                    (index) => _ctrl[index].text);

                          // }
                          var data = {
                            "class": _classController.text,
                            "streams": _stepText,
                          };
                          debugPrint("Classes data => $data");

                          // showContentDialog(jsonEncode(data), context);
                          // if (_formKey3.currentState!.validate()) {
                          setState(() {
                            _index = 3;
                            //  data
                          });
                          // }
                        })
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
