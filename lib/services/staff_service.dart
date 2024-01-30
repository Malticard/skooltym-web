import 'package:admin/exports/exports.dart';

import '../main.dart';

class StaffService {
  static void updateStaff(Map<String, dynamic> data) async {
    BuildContext? context = navigatorKey.currentContext;
    try {
      Client()
          .patch(
              Uri.parse(
                AppUrls.updateStaffFirstTime +
                    context?.read<SchoolController>().state['id'],
              ),
              body: data)
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
//
}
