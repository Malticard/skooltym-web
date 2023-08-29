// ignore_for_file: unnecessary_null_comparison, invalid_use_of_visible_for_testing_member

// import 'package:image_picker_for_web/image_picker_for_web.dart';

import 'dart:developer';
import 'package:image_picker/image_picker.dart';

import '/exports/exports.dart';

class CommonFormFields extends StatefulWidget {
  final EdgeInsets padding;
  final bool? isHalfDay;
  final String? initialPic;
  final List<Map<String, dynamic>> formFields;
  final List<String> errorMsgs;
  final List<TextEditingController> formControllers;
  final List<dynamic>? lists;
  final String menuTitle;
  final EdgeInsets titlePadding;
  final void Function(dynamic)? onDropDownValue;
  final List<dynamic>? dropdownLists;
  final int? numberOfDropDowns;
  final String buttonText;
  final VoidCallback? onSubmit;
  final void Function(String?)? onSelectedValue;
  final void Function(String?)? selectedData;
  final Widget? submit;
  final String? formTitle;
  final bool formEnabled;
  const CommonFormFields(
      {super.key,
      required this.padding,
      required this.errorMsgs,
      required this.formFields,
      required this.formControllers,
      this.onSubmit,
      this.formTitle,
      this.submit,
      this.formEnabled = true,
      required this.buttonText,
      this.lists,
      this.numberOfDropDowns,
      this.dropdownLists,
      this.onDropDownValue,
      this.onSelectedValue,
      this.initialPic,
      this.selectedData,
      this.titlePadding = const EdgeInsets.all(20),
      this.menuTitle = "",
      this.isHalfDay});

  @override
  State<CommonFormFields> createState() => _CommonFormFieldsState();
}

class _CommonFormFieldsState extends State<CommonFormFields>
    with SingleTickerProviderStateMixin {
  // Error messages
// StreamController<Uint8List> _uploadController = StreamController<Uint8List>();
  List<String?>? dropMsg;

  @override
  void initState() {
    // Error messages
    dropMsg = List.generate(widget.formFields.length, (index) => null);
    super.initState();
  }

  // var _cropController = CropController();
  var _imageBytes;
  void _handleImageUpload(int a) async {
    if (kIsWeb) {
      XFile? picker = await ImagePicker.platform.getImageFromSource(
          source:
              ImageSource.gallery); // pickImage(source: ImageSource.gallery);
      if (picker != null) {
        var element = await picker.readAsBytes();
        setState(() {
          _imageBytes = element;
        });
        BlocProvider.of<ImageUploadController>(context).uploadImage({
          "image": picker.readAsBytes().asStream(),
          "name": renameFile(picker.name.trim()),
          "size": picker.readAsBytes().asStream().length,
        });
      }
    } else {
      FilePicker.platform.pickFiles(
        dialogTitle: "${widget.formFields[a]['title']}",
        type: FileType.custom,
        withReadStream: true,
        allowedExtensions: ['jpg', 'png,', 'jpeg', 'gif'],
      ).then((value) {
        setState(() {
          _imageBytes = File(value!.files.first.path!).readAsBytesSync();
          widget.formControllers[a].text = value.files.first.path!;
        });
      });
    }
  }

  bool _timeSession = false;
  Widget buildSwitchWidget(int x) {
    return Container(
      child: SwitchListTile.adaptive(
        contentPadding: widget.padding,
        secondary: Icon(widget.formFields[x - 1]['icon']),
        title: Text(
          widget.formFields[x - 1]['title'],
        ),
        subtitle: Text(widget.isHalfDay ?? _timeSession == true
            ? "Half day student"
            : "Full day student"),
        value: _timeSession,
        onChanged: (value) {
          setState(() {
            _timeSession = value;
            widget.formControllers[x - 1].text = "${value}";
          });
          log("selected ${_timeSession}");
        },
      ),
    );
  }

  Object drawImage(var url) {
    if (url.isEmpty) {
      return widget.initialPic != null
          ? NetworkImage(AppUrls.liveImages + widget.initialPic!)
          : const AssetImage("assets/icons/001-profile.png");
    }
    return MemoryImage(url);
  }

  String drop = '';
  Widget buildProfile(int ind) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(widget.formFields[ind]['title'],
                style: TextStyles(context).getDescriptionStyle()),
          ),
          SizedBox(
            child: CircleAvatar(
              radius: Responsive.isMobile(context) ? 30 : 35,
              backgroundImage:
                  drawImage(_imageBytes ?? '') as ImageProvider<Object>,
            ),
          ),
          // code for uploading profile picture  using file picker
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueAccent[900]
                  : Colors.white,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color.fromARGB(66, 75, 74, 74),
              side: const BorderSide(color: Colors.blueAccent),
            ),
            onPressed: () => _handleImageUpload(ind),
            child: Responsive.isMobile(context)
                ? Icon(Icons.upload_file_rounded)
                : Text(
                    "Upload",
                    style: TextStyles(context).getRegularStyle(),
                  ),
          ),
        ],
      ),
    );
  }

  bool showPassword = false;
  // global form key
  final formKey = GlobalKey<FormState>();
  List<Widget> buildForm() {
    return List.generate(
      widget.formFields.length + 2,
      (index) => index != (widget.formFields.length + 1)
          ? index == 0
              ? Padding(
                  padding: widget.titlePadding,
                  child: Text(
                    widget.formTitle ?? "",
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: Responsive.isMobile(context) ? 17 : 20,
                        ),
                  ),
                )
              :
              // form fields for drop downs (gender and relationship)
              (widget.formFields[index - 1]['profile'] != null)
                  ? buildProfile(index - 1)
                  : (widget.formFields[index - 1]['data'] != null)
                      ? DropDownWidget(
                          padding: widget.padding,
                          displayText: dropMsg![index - 1] ??
                              widget.formFields[index - 1]['data'][0],
                          titleText: widget.formFields[index - 1]['title'],
                          // controller: widget.formControllers[index -1],
                          elements: widget.formFields[index - 1]['data'],
                          selectedValue: (value) {
                            print("Selected data ${value}");
                            // context.read<ClassNameController>().setClass(value?? '');
                            debugPrint("Selected => ${value.toString()}");
                            // widget.onSelectedValue!;
                            setState(() {
                              dropMsg![index - 1] = value;
                              widget.formControllers[index - 1].text = value!;
                            });
                          },
                        )
                      : (widget.formFields[index - 1]['date'] != null)
                          ?
                          // date of entry
                          CommonTextField(
                              icon: widget.formFields[index - 1]['icon'],
                              enableSuffix: widget.formFields[index - 1]
                                      ['enableSuffix'] ??
                                  showPassword,
                              enableBorder: true,
                              suffixIcon: widget.formFields[index - 1]
                                  ['suffix'],
                              fieldColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : const Color.fromARGB(66, 75, 74, 74),
                              errorText: widget.errorMsgs[index - 1],
                              padding: widget.padding,
                              onChanged: (v) {
                                DateTime initialDate = DateTime.now();
                                DateTime firstDate = DateTime(1990);
                                DateTime lastDate = DateTime(2050);
                                showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: firstDate,
                                        lastDate: lastDate)
                                    .then((value) {
                                  setState(() {
                                    widget.formControllers[index - 1].text =
                                        "${days[value!.weekday - 1]}, ${months[(value.month) - 1]} ${markDates(value.day)}";
                                  });
                                });
                              },
                              isObscureText: widget.formFields[index - 1]
                                  ['password'],
                              controller: widget.formControllers[index - 1],
                              hintText: widget.formFields[index - 1]['hint'],
                              titleText: widget.formFields[index - 1]['title'],
                            )
                          :
                          // dropdown menu
                          (widget.formFields[index - 1]['menu'] != null)
                              ? SingleChildScrollView(
                                  child: CommonMenuWidget(
                                    fieldColor: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : const Color.fromARGB(66, 75, 74, 74),
                                    // controller: widget.formControllers[index - 1],
                                    fieldText: widget.formFields[index - 1]
                                        ['title'],
                                    hint: widget.formFields[index - 1]['hint'],
                                    padding: widget.padding,
                                    onChange: widget.onDropDownValue ??
                                        (v) {
                                          log("Selected => $v");
                                          if (v != null) {
                                            setState(() {
                                              // dropMsg![index - 1] = v;
                                              widget.formControllers[index - 1]
                                                  .text = v!;
                                            });
                                          }
                                        },
                                    data: widget.lists ?? [],
                                    dropdownList: widget.dropdownLists ?? [],
                                    fieldHeaderTitle: widget.menuTitle,
                                  ),
                                )
                              : widget.formFields[index - 1]['switch'] != null
                                  ? buildSwitchWidget(index)
                                  :
                                  // other fields
                                  CommonTextField(
                                      icon: widget.formFields[index - 1]
                                          ['icon'],
                                      enableSuffix: widget.formFields[index - 1]
                                              ['enableSuffix'] ??
                                          showPassword,
                                      enableBorder: true,
                                      suffixIcon: widget.formFields[index - 1]
                                          ['suffix'],
                                      fieldColor:
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  66, 75, 74, 74),
                                      errorText: widget.errorMsgs[index - 1],
                                      padding: widget.padding,
                                      isObscureText: widget
                                          .formFields[index - 1]['password'],
                                      controller:
                                          widget.formControllers[index - 1],
                                      hintText: widget.formFields[index - 1]
                                          ['hint'],
                                      titleText: widget.formFields[index - 1]
                                          ['title'],
                                      onTapSuffix: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                          widget.formFields[index - 1]
                                              ['password'] = showPassword;
                                        });
                                      },
                                      validate: (v) {
                                        setState(() {
                                          widget.errorMsgs[index - 1] =
                                              v!.isEmpty
                                                  ? "This field is required"
                                                  : "";
                                        });

                                        return null;
                                      },
                                    )
          : widget.submit ??
              CommonButton(
                buttonText: widget.buttonText,
                onTap: widget.onSubmit!,
                //  () {
                //   if (formKey.currentState!.validate() == true) {
                //     widget.onSubmit!();
                //   }
                // },
                padding: widget.padding,
                height: 55,
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.formEnabled
        ? Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildForm(),
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildForm(),
            ),
          );
  }
}
