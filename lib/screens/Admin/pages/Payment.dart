// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class PaymentReports extends StatefulWidget {
  const PaymentReports({super.key});

  @override
  State<PaymentReports> createState() => _PaymentReportsState();
}

class _PaymentReportsState extends State<PaymentReports>
    with SingleTickerProviderStateMixin {
  int _currentPage = 1;
  int rowsPerPage = 20;
  final PaginatorController _paginatorController = PaginatorController();
  // stream controller
  StreamController<PaymentModel> _paymentController =
      StreamController<PaymentModel>();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    realTimeClearedPayments();
  }

  void realTimeClearedPayments() async {
    // initial data
    var payments = await fetchPayments(
        context.read<SchoolController>().state['school'],
        page: _currentPage,
        limit: rowsPerPage);
    _paymentController.add(payments);
    // listen to the stream
    Timer.periodic(Duration(seconds: 1), (timer) async {
      this.timer = timer;
      if (mounted) {
        var payments = await fetchPayments(
            context.read<SchoolController>().state['school'],
            page: _currentPage,
            limit: rowsPerPage);
        _paymentController.add(payments);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_paymentController.hasListener) {
      _paymentController.close();
    }
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.width / 2.5,
      child: StreamBuilder(
        stream: _paymentController.stream,
        builder: (context, payload) {
          var paymentModel = payload.data;
          var _payments = paymentModel?.results ?? [];
          return CustomDataTable(
            onPageChanged: (page) {
              setState(() {
                _currentPage = (page ~/ rowsPerPage) + 1;
              });
            },
            onRowsPerPageChanged: (rows) {
              setState(() {
                rowsPerPage = rows ?? 20;
              });
            },
            paginatorController: _paginatorController,
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
                  ),
                )
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
            empty:  SizedBox(
                          height: MediaQuery.of(context).size.width / 9,
                          child: payload.hasData ? const NoDataWidget(
                              text: "No  payments recorded"
                                  "") : Loader(
                            text: "Payment records",
                          ),
                        ),
              
            source: ReportsDataSource(
                context: context,
                paymentModel: _payments,
                currentPage: _currentPage,
                paginatorController: _paginatorController,
                totalDocuments: paymentModel?.totalDocuments ?? 0),
          );
        },
      ),
    );
  }

  // row data
  // DataRow overtimeDataRow(PaymentModel paymentModel, int i) {
  //   return DataRow(
  //     cells: [
  //       DataCell(
  //         Row(
  //           children: [
  //             Image.network(
  //               AppUrls.liveImages + paymentModel.student.studentProfilePic,
  //               height: 33,
  //               width: 33,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(0),
  //               child: Text(paymentModel.student.username,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(fontSize: 11)),
  //             ),
  //           ],
  //         ),
  //       ),
  //       DataCell(Text(
  //           "${paymentModel.staff.staffFname} ${paymentModel.staff.staffLname}",
  //           style: const TextStyle(fontSize: 11))),
  //       DataCell(Text(paymentModel.dateOfPayment.split(".").first,
  //           style: const TextStyle(fontSize: 11))),
  //       DataCell(Text(paymentModel.paymentMethod,
  //           style: const TextStyle(fontSize: 11))),
  //       // DataCell(Text(
  //       //     "${paymentModel.staff.staffFname} ${paymentModel.staff.staffLname}",
  //       //     style: const TextStyle(fontSize: 11))),
  //       DataCell(Text(paymentModel.balance.toString(),
  //           style: const TextStyle(fontSize: 11))),
  //       DataCell(Text(paymentModel.comment.toString(),
  //           style: const TextStyle(fontSize: 11))),

  //       // DataCell(Text(paymentModel.status)),
  //       // if (context.read<SchoolController>().state['role'] == 'Finance')
  //       // DataCell(
  //       //   buildActionButtons(
  //       //     context,
  //       //     () {
  //       //       showDialog(
  //       //           context: context,
  //       //           builder: (context) {
  //       //             return Dialog(
  //       //               child: SizedBox(
  //       //                 width: MediaQuery.of(context).size.width / 2.4,
  //       //                 height: MediaQuery.of(context).size.width / 4,
  //       //                 child: ClearWindow(
  //       //                   paymentModel: paymentModel,
  //       //                   id: paymentModel.id,
  //       //                   title: paymentModel.student.username,
  //       //                 ),
  //       //               ),
  //       //             );
  //       //           });
  //       //     },
  //       //     () {
  //       //       showDialog(
  //       //           context: context,
  //       //           builder: (context) {
  //       //             return SizedBox(
  //       //               width: MediaQuery.of(context).size.width / 2.4,
  //       //               height: MediaQuery.of(context).size.width / 4,
  //       //               child: CommonDelete(
  //       //                 url: AppUrls.deletePayment + paymentModel.id,
  //       //                 title: paymentModel.student.username,
  //       //               ),
  //       //             );
  //       //           });
  //       //     },
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
}
