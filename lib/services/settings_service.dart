import 'dart:developer';

import 'package:admin/models/SettingModel.dart';

import '../exports/exports.dart';

class SettingsService {
  static Future<SettingsModel> fetchCurrentSettings() async {
    try {
      Response response = await Client().get(Uri.parse(AppUrls.settings));
      if (response.statusCode == 200) {
        SettingsModel settings = settingsModelFromJson(response.body).single;
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
