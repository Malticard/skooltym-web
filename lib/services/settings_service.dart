import 'dart:developer';

import 'package:admin/models/SettingModel.dart';

import '../exports/exports.dart';
import '../main.dart';

class SettingsService {
  static Future<SettingsModel> fetchCurrentSettings() async {
    try {
      BuildContext context = navigatorKey.currentContext!;
      Response response = await Client().get(
        Uri.parse(AppUrls.settings +
            context.read<SchoolController>().state['school']),
      );
      if (response.statusCode == 200) {
        print(response.body);
        SettingsModel settings = settingsModelFromJson(response.body)[0];
        return settings;
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (e) {
      log(e.message);
      return Future.error(e.message);
    }
  }
}
