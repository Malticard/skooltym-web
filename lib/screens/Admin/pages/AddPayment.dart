import 'package:admin/controllers/utils/LoaderController.dart';

import '/exports/exports.dart';

class AddPayment extends StatefulWidget {
  final String amount;
  final String guardian;
  final String student;
  final String studentId;
  final String guardianId;
  const AddPayment(
      {super.key,
      required this.studentId,
      required this.guardianId,
      required this.amount,
      required this.guardian,
      required this.student});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchStudentsController>(context)
        .getStudents(context.read<SchoolController>().state['school']);
    BlocProvider.of<GuardianController>(context).getGuardians(context);
  }

  final _amountPaidController = TextEditingController();
  final _commentController = TextEditingController();
  final _paymentMethodController = TextEditingController(text: "Cash");
  String? selected;
  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5);
  @override
  Widget build(BuildContext context) {
    // displaying names for guardian and student being cleared
    final _studentController = TextEditingController(text: widget.student);
    final _guardianController = TextEditingController(text: widget.guardian);
    //
    BlocProvider.of<FetchStudentsController>(context)
        .getStudents(context.read<SchoolController>().state['school']);
    BlocProvider.of<GuardianController>(context).getGuardians(context);
    return Consumer<LoaderController>(builder: (context, controller, child) {
      return Dialog(
        child: SizedBox(
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width,
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height / 1.3
              : MediaQuery.of(context).size.width / 2.2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Payment",
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 19),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                CommonTextField(
                  readOnly: controller.isAddingPayment,
                  titleText: "Amount Owed :  UGX ${widget.amount}",
                  hintText: "UGX ${widget.amount}",
                  padding: padding,
                  icon: Icons.attach_money,
                  contentPadding: const EdgeInsets.only(top: 12),
                  controller: _amountPaidController,
                ),
                // const SizedBox(height: defaultPadding),
                DropDownWidget(
                  displayText: selected ?? "Cash",
                  elements: const ["Cash", "Comment"],
                  titleText: "Payment Method",
                  selectedValue: (value) {
                    if (value!.isNotEmpty) {
                      setState(() {
                        selected = value;
                        _paymentMethodController.text = value.trim();
                      });
                    }
                  },
                ),
                CommonTextField(
                  icon: Icons.comment,
                  titleText: "Comment",
                  padding: padding,
                  readOnly: controller.isAddingPayment,
                  contentPadding: const EdgeInsets.only(top: 12),
                  hintText: "e.g school activities",
                  controller: _commentController,
                ),
                CommonTextField(
                  icon: Icons.person,
                  titleText: "Student",
                  readOnly: true,
                  padding: padding,
                  contentPadding: const EdgeInsets.only(top: 12),
                  hintText: "e.g John Doe",
                  controller: _studentController,
                ),
                CommonTextField(
                  icon: Icons.person,
                  titleText: "Guardian",
                  readOnly: true,
                  padding: padding,
                  contentPadding: const EdgeInsets.only(top: 12),
                  hintText: "e.g Guardian name",
                  controller: _guardianController,
                ),
                CommonButton(
                  buttonTextWidget: controller.isAddingPayment
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        )
                      : Text(
                          "Add Payment",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                  onTap: controller.isAddingPayment
                      ? null
                      : () {
                          handlePayment();
                        },
                  padding: padding,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  // function to handle the add payment
  handlePayment() {
    // showProgress(context, msg: "Recording new payment...");
    Client().post(Uri.parse(AppUrls.addPayment), body: {
      "school": context.read<SchoolController>().state['school'],
      "guardian": widget.guardianId,
      "student": widget.studentId,
      "payment_method": _paymentMethodController.text.trim(),
      "staff": context.read<SchoolController>().state['id'],
      "comment": _commentController.text,
      "paid_amount": (_amountPaidController.text.trim()),
      "date_of_payment": DateTime.now().toString().split(" ")[0].trim(),
      "payment_key[0]": "0"
    }).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        // Routes.popPage(context);
        showMessage(
            context: context,
            msg: "Added new payment successfully",
            type: "success");
      } else {
        showMessage(
            context: context,
            msg: "Added new payment successfully",
            type: "success");
      }
    }).whenComplete(() {
      Routes.popPage(context);
    });
  }
}
