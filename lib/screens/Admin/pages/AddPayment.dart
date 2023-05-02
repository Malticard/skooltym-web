import '/exports/exports.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchStudentsController>(context)
        .getStudents(context.read<SchoolController>().state['school']);
  }

  final _amountPaidController = TextEditingController();
  final _commentController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _studentController = TextEditingController();
  String? selected;
  // overall form padding
  EdgeInsets padding =
      const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchStudentsController>(context)
        .getStudents(context.read<SchoolController>().state['school']);
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Payment",
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 19)),
            ),
            const SizedBox(height: defaultPadding),
            CommonTextField(
              titleText: "Amount Paid",
              hintText: "e.g 5000",
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
                    _paymentMethodController.text = value;
                  });
                }
              },
            ),
            CommonTextField(
              titleText: "Comment",
              hintText: "e.g school activities",
              controller: _commentController,
            ),
            // const SizedBox(height: defaultPadding),
            BlocBuilder<FetchStudentsController, List<StudentModel>>(
              builder: (context, state) {
                return CommonMenuWidget(
                    fieldText: "Attach a student",
                    onChange: (x) {
                      if (x != null) {
                        setState(() {
                          _studentController.text = json.decode(x).join(",");
                        });
                      }
                    },
                    hint: "Select a student",
                    padding: padding,
                    data: state
                        .map((e) => e.id)
                        .toList(),
                    dropdownList:state
                        .map((e) => "${e.studentFname} ${e.studentLname}")
                        .toList());
              },
            ),
            CommonButton(
              buttonText: "Add Payment",
              onTap: () {
                handlePayment();
              },
              padding: padding,
            )
          ],
        ),
      ),
    );
  }

  // function to handle the add payment
  handlePayment() {
    // print({
    //   "school": context.read<SchoolController>().state['school'],
    //   "guardian": "",
    //   "student": _studentController.text,
    //   "payment_method": _paymentMethodController.text,
    //   "staff": context.read<SchoolController>().state['id'],
    //   "comment": _commentController.text,
    //   "paid_amount": _amountPaidController.text,
    //   "date_of_payment": DateTime.now().toString(),
    //   "payment_key[0]": "0"
    // });
    showProgress(context, msg: "Recording new payment...");
    Client().post(Uri.parse(AppUrls.addPayment), body: {
      "school": context.read<SchoolController>().state['school'],
      "guardian": "",
      "student": _studentController.text,
      "payment_method": _paymentMethodController.text,
      "staff": context.read<SchoolController>().state['id'],
      "comment": _commentController.text,
      "paid_amount": _amountPaidController.text,
      "date_of_payment": DateTime.now().toString().split(" ")[0],
      "payment_key[0]": "0"
    }).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        Routes.popPage(context);
        showMessage(
            context: context,
            msg: "Added new payment successfully",
            type: "success");
      } else {
        Routes.popPage(context);
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
