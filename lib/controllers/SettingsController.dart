import '/exports/exports.dart';
class SettingsController extends Cubit<Map<String,dynamic>>{
  SettingsController():super(results);
  static Map<String, dynamic> results = {
    "school_id": "",
      "drop_off_start_time": "",
      "drop_off_end_time": "",
      "pick_up_start_time":
          "${DateTime.now().toString().split(" ")[0]} ",
      "pick_up_end_time":
          DateTime.now().toString().split(" ")[0],
      "drop_off_allowance": "0",
      "pick_up_allowance": "0",
      "allow_overtime": false,
      "overtime_rate": "0",
      "overtime_rate_currency": "UGX Ushs",
      "overtime_interval": "0",
      "settings_key[key]": "0",
  };
  saveSettings(Map<String,dynamic> data){
    SharedPreferences.getInstance().then((value) {
      value.setString("system_settings", json.encode(data));
    });
    emit(data);
  }
  // get settings
  getSettings(){
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey("system_settings")) {
        var rs = json.decode(value.getString("system_settings")!);
        emit(rs);
      }
    });
  }
}