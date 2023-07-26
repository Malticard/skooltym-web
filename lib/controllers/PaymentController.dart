import '/exports/exports.dart';
class PaymentController extends Cubit<List<PaymentModel>>{
  PaymentController():super([]);
  getPayments(BuildContext ctx){
    // if (ctx.read<SchoolController>().state['role'] == 'Finance') {
      Client()
          .get(Uri.parse(AppUrls.getPayment +
              ctx.read<SchoolController>().state['school'],),)
          .then((value) {
            if (value.statusCode == 200 || value.statusCode == 201) {
            emit(paymentModelFromJson(value.body));
            }
      });
    // }
  }
}