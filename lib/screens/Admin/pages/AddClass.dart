// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  @override
  void initState() {
    super.initState();
  }
  // late List<TextEditingController> _ctrl;

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).staffUpdate(context.read<SchoolController>().state['school']);
    Provider.of<MainController>(context).fetchClasses(context.read<SchoolController>().state['school']);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Student Name", "Class", "Gender", "Actions"];


  List<String> _stepText = <String>[];

  int currentStep = 0;
  final int _streams = 0;
  final EdgeInsets _padding = const EdgeInsets.only(right: 0, left: 0);
  //text controllers

  final TextEditingController _classController = TextEditingController();
  final TextEditingController _streamNoController = TextEditingController();
  //error text
  final TextEditingController _errorController1 = TextEditingController();
  final TextEditingController _errorController2 = TextEditingController();
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
  final List<TextEditingController> _ctrl =
      List.generate(50, (n) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    // responsive dimensions
    Size size = MediaQuery.of(context).size;
    List<TextEditingController> _streamErrorControllers = List.generate(
        context.read<StepperController>().state.fields!,
        (index) => TextEditingController());
    Provider.of<MainController>(context).staffUpdate(context.read<SchoolController>().state['school']);
    Provider.of<MainController>(context).fetchClasses(context.read<SchoolController>().state['school']);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Stepper(
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
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 16),
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
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 16),
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
                                      fields:
                                          int.parse(_streamNoController.text),
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
                state:
                    _index == 3 ? assignState(index: 1) : assignState(index: 2),
                title: const Text("Attach streams to class"),
                content: Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 16),
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
                                  _streamErrorControllers[index].text =
                                      "Stream "
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
                                _stepText = List.generate(
                                    context
                                        .read<StepperController>()
                                        .state
                                        .fields!,
                                    (index) => _ctrl[index].text);
                                setState(() => _index = 3);
                                // }
                                Map<String, dynamic> data = {
                                  "school":context.read<SchoolController>().state['school'],
                                  "class_name": _classController.text,
                                  "class_streams": _stepText.join(","),
                                };
                                debugPrint("Saved data $data");
                                showProgress(context,
                                    msg: 'Adding class in progress');
                                // saving class data to db
                                Client()
                                    .post(Uri.parse(AppUrls.addClass),
                                        body: data)
                                    .then((value) {
                                  debugPrint("Worked on data $data");
                                  if (value.statusCode == 200) {
                                    Routes.popPage(context);
                                    showMessage(
                                        context: context,
                                        msg: "Class added successfully",
                                        type: 'success',
                                        duration: 6);
                                  } else {
                                    Routes.popPage(context);
                                    showMessage(
                                        context: context,
                                        msg: 'Class not added',
                                        type: 'danger',
                                        duration: 6);
                                  }
                                }).whenComplete(() {
                                  // when done clear the stepper fields
                                  _classController.clear();
                                  _streamNoController.clear();
                                  _ctrl.forEach((element) {
                                    element.clear();
                                  });
                                  //
                                  // reset back to the first step
                                  setState(() {
                                    currentStep = 0;
                                    _index = 0;
                                  });
                                });
                                // done saving class data to db
                              })
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: SizedBox(
              // width: size.width,
              height: size.width / 2.5,
              child: Data_Table(
                header:const Text("Classes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                columns: const [
                  DataColumn(
                    label: Text("No."),
                  ),
                  DataColumn(
                    label: Text("Class"),
                  ),
                  DataColumn(
                    label: Text("Action"),
                  ),
                ],
                rows: List.generate(
                    context.watch<MainController>().classes.length, (index) {
                      debugPrint("Classes > ${context.watch<MainController>().classes.length}");
                  return DataRow(
                    cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(Text(context
                          .watch<MainController>()
                          .classes[index]
                          )),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => CommonDelete(
                                  title: context
                                      .watch<MainController>()
                                      .classes[index]
                                      ,
                                  url: AppUrls.deleteClass +
                                      context
                                          .watch<MainController>()
                                          .classes[index]
                                          ,
                                ),
                              ),
                              icon:const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                empty: const Center(
                  child: Text("No classes added.."),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
