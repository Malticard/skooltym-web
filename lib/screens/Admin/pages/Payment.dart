// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class PaymentReports extends StatefulWidget {
  const PaymentReports({super.key});

  @override
  State<PaymentReports> createState() => _PaymentReportsState();
}

class _PaymentReportsState extends State<PaymentReports>
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
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AddPayment();
                          });
                    },
                    child: Text(
                      "Add payment",
                      style: TextStyles(context).getRegularStyle(),
                    ))
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
            empty: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 2)),
                builder: (context, d) {
                  return d.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: Loader(
                            text: "Payment records",
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.width / 9,
                          child: const NoDataWidget(
                              text: "No  payments recorded"
                                  ""),
                        );
                }),
            rows: List.generate(
              payment.length,
              (index) => overtimeDataRow(payment[index], index),
            ),
            source: ReportsDataSource(context: context, paymentModel: payment),
          );
        },
      ),
    );
  }

  // row data
  DataRow overtimeDataRow(PaymentModel paymentModel, int i) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.network(
                AppUrls.liveImages + paymentModel.student.studentProfilePic,
                height: 33,
                width: 33,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(paymentModel.student.username,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${paymentModel.staff.staffFname} ${paymentModel.staff.staffLname}",
            style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentModel.dateOfPayment.split(".").first,
            style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentModel.paymentMethod,
            style: const TextStyle(fontSize: 11))),
        // DataCell(Text(
        //     "${paymentModel.staff.staffFname} ${paymentModel.staff.staffLname}",
        //     style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentModel.balance.toString(),
            style: const TextStyle(fontSize: 11))),
        DataCell(Text(paymentModel.comment.toString(),
            style: const TextStyle(fontSize: 11))),

        // DataCell(Text(paymentModel.status)),
        // if (context.read<SchoolController>().state['role'] == 'Finance')
        // DataCell(
        //   buildActionButtons(
        //     context,
        //     () {
        //       showDialog(
        //           context: context,
        //           builder: (context) {
        //             return Dialog(
        //               child: SizedBox(
        //                 width: MediaQuery.of(context).size.width / 2.4,
        //                 height: MediaQuery.of(context).size.width / 4,
        //                 child: ClearWindow(
        //                   paymentModel: paymentModel,
        //                   id: paymentModel.id,
        //                   title: paymentModel.student.username,
        //                 ),
        //               ),
        //             );
        //           });
        //     },
        //     () {
        //       showDialog(
        //           context: context,
        //           builder: (context) {
        //             return SizedBox(
        //               width: MediaQuery.of(context).size.width / 2.4,
        //               height: MediaQuery.of(context).size.width / 4,
        //               child: CommonDelete(
        //                 url: AppUrls.deletePayment + paymentModel.id,
        //                 title: paymentModel.student.username,
        //               ),
        //             );
        //           });
        //     },
        //   ),
        // ),
      ],
    );
  }
}
