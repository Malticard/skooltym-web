// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class ClearedOvertime extends StatefulWidget {
  const ClearedOvertime({super.key});

  @override
  State<ClearedOvertime> createState() => _ClearedOvertimeState();
}

class _ClearedOvertimeState extends State<ClearedOvertime>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentController>(context).getPayments(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<PaymentController>(context).getPayments(context);
    return SizedBox(
      width: size.width,
      height: size.width / 2.5,
      child: BlocBuilder<PaymentController, List<PaymentModel>>(
        builder: (context, payment) {
          return CustomDataTable(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payments",
                  style: TextStyles(context).getTitleStyle(),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       showDialog(
                //           context: context,
                //           builder: (context) {
                //             return const AddPayment();
                //           });
                //     },
                //     child: Text(
                //       "Add payment",
                //       style: TextStyles(context).getRegularStyle(),
                //     ))
              ],
            ),
            columns: const [
              DataColumn(
                label: Text(
                  "Student",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              DataColumn(
                label: Text("Cleared By", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: SizedBox(
                    width: 800,
                    child: Text("Date", style: TextStyle(fontSize: 12))),
              ),
              DataColumn(
                label: Text("Cleared With", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: Text("Balance", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: Text("Comment", style: TextStyle(fontSize: 12)),
              ),
            ],
            empty: SizedBox(
              height: MediaQuery.of(context).size.width / 9,
              child: const NoDataWidget(
                  text: "No Cleared  overtimes captured"
                      ""),
            ),
            source: ReportsDataSource(paymentModel: payment, context: context),
          );
        },
      ),
    );
  }
}

//  pending overtimes
class PendingOvertime extends StatefulWidget {
  const PendingOvertime({super.key});

  @override
  State<PendingOvertime> createState() => _PendingOvertimeState();
}

class _PendingOvertimeState extends State<PendingOvertime>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentController>(context).getPayments(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<PaymentController>(context,listen: true).getPayments(context);
    return SizedBox(
      width: size.width,
      height: size.width / 2.5,
      child: BlocBuilder<PaymentController, List<PaymentModel>>(
        builder: (context, payment) {
          return CustomDataTable(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pending",
                  style: TextStyles(context).getTitleStyle(),
                ),
              ],
            ),
            columns: const [
              DataColumn(
                label: Text(
                  "Student",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              DataColumn(
                label: Text("Cleared By", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: SizedBox(
                    width: 800,
                    child: Text("Date", style: TextStyle(fontSize: 12))),
              ),
              DataColumn(
                label: Text("Cleared With", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: Text("Balance", style: TextStyle(fontSize: 12)),
              ),
              DataColumn(
                label: Text("Comment", style: TextStyle(fontSize: 12)),
              ),
            ],
            empty: SizedBox(
              height: MediaQuery.of(context).size.width / 9,
              child: const NoDataWidget(
                  text: "No Pending overtimes captured"
                      ""),
            ),
            source: ReportsDataSource(paymentModel: payment, context: context),
          );
        },
      ),
    );
  }
}
