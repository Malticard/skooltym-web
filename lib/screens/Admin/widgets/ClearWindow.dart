import '/exports/exports.dart';

class ClearWindow extends StatefulWidget {
  final String title;
  final String id;
  const ClearWindow({super.key, required this.title, required this.id});

  @override
  State<ClearWindow> createState() => _ClearWindowState();
}

class _ClearWindowState extends State<ClearWindow> {
  int _paid = 0;
  int _unpaid = 0;
  final clearedWithCashController = TextEditingController();
  final clearedWithCommentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text("Clearing ${widget.title}'s overtime history",
                style:
                    TextStyles(context).getBoldStyle().copyWith(fontSize: 20)),
          ),
          RadioMenuButton(
            value: _paid,
            groupValue: 1,
            onChanged: (value) {
              setState(() {
                _paid = 1;
                _unpaid = 0;
              });
            },
            child: const Text("Cleared with cash"),
          ),
          if (_paid == 1)
            CommonTextField(
              icon: Icons.attach_money,
              controller: clearedWithCashController,
              hintText: "e.g 5000",keyboardType: TextInputType.number,
              titleText: "Amount paid",
              padding: const EdgeInsets.only(
                left: 20,
                right: 16,
                top: 10,
                bottom: 0,
              ),
              contentPadding: const EdgeInsets.only(
                left: 20,
                right: 16,
                top: 10,
                bottom: 0,
              ),
            ),
          RadioMenuButton(
            value: _unpaid,
            groupValue: 1,
            onChanged: (value) {
              setState(() {
                _paid = 0;
                _unpaid = 1;
              });
            },
            child: const Text("Cleared with comment"),
          ),
          if (_unpaid == 1)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: clearedWithCommentController,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonButton(
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20),
              buttonText: "Clear",
              onTap: () {
                if (_paid == 1) {
                  //clear with cash
                  if (clearedWithCashController.text.isNotEmpty) {
                    if(Validator_.isValidNumber(clearedWithCashController.text) == true){
                      showMessage(context: context,msg: "Please enter valid amount",type: 'warning');
                    } else {
                      Routes.popPage(context);
                    showSuccessDialog(
                        "Successfully cleared ${widget.title}", context);
                    }
                  } else {
                    showMessage(
                        context: context,
                        msg: "Please enter amount paid",
                        type: 'warning');
                  }
                } else {
                  //clear with comment
                  if (clearedWithCommentController.text.isNotEmpty) {
                    
                    Routes.popPage(context);
                    showSuccessDialog(
                        "Successfully cleared ${widget.title}", context);
                  } else {
                    showMessage(
                        context: context,
                        msg: "Please enter comment",
                        type: 'warning');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
