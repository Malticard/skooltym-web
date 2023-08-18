// import 'package:flutter/src/animation/animation_controller.dart';
import 'package:admin/tools/searchHelpers.dart';

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
  String? _query;
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
        if (_query != null) {
          var payments = await searchPayments(
              context.read<SchoolController>().state['school'], _query!);
          _paymentController.add(payments);
        } else {
          var payments = await fetchPayments(
              context.read<SchoolController>().state['school'],
              page: _currentPage,
              limit: rowsPerPage);
          _paymentController.add(payments);
        }
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
                Expanded(
                  child: SizedBox(
                    width: 120,
                    child: SearchField(
                      onChanged: (value) {
                        setState(() {
                          _query = value?.trim();
                        });
                      },
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                )
              ],
            ),
            columns: [
              DataColumn(
                label: Text(
                  "Student Profile",
                  // style: TextStyle(fontSize: 12),
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Student Name",
                  // style: TextStyle(fontSize: 12),
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn2(
                label: Text("Guardian Name",
                    style: TextStyles(context).getRegularStyle()),
              ),
              DataColumn(
                label: Text(
                  "Cleared By",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: SizedBox(
                    width: 800,
                    child: Text(
                      "Date",
                      style: TextStyles(context).getRegularStyle(),
                    )),
              ),
              DataColumn(
                label: Text(
                  "Cleared With",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Amount Paid",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
              DataColumn(
                label: Text(
                  "Comment",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ),
            ],
            empty: SizedBox(
              height: MediaQuery.of(context).size.width / 9,
              child: payload.hasData
                  ? const NoDataWidget(
                      text: "No  payments recorded"
                          "")
                  : Loader(
                      text: "Payment records",
                    ),
            ),
            source: PaymentDataSource(
                context: context,
                currentPage: _currentPage,
                paginatorController: _paginatorController,
                totalDocuments: paymentModel?.totalDocuments ?? 0,
                payments: _payments),
          );
        },
      ),
    );
  }
}
