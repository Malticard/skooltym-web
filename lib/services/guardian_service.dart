import 'package:admin/exports/exports.dart';

import '../main.dart';

class GuardianService {
  static void updateGuardian(Map<String, dynamic> data) async {
    BuildContext? context = navigatorKey.currentContext;
    try {
      Client()
          .post(Uri.parse(AppUrls.updateGuardian), body: data)
          .then((value) {
        String message = json.decode(value.body)['message'];

        if (value.statusCode == 200) {
          showMessage(context: context!, msg: message, type: 'info');
        } else {
          showMessage(context: context!, msg: message, type: 'error');
        }
      });
    } on ClientException catch (e, _) {
      showMessage(context: context!, msg: e.message, type: 'info');
    }
  }
}
